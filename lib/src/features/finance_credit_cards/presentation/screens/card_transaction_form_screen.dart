import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../domain/models/enums.dart';
import '../../../../domain/models/exceptions.dart';
import '../../../../providers/financial_data_providers.dart';
import '../../../../providers/service_providers.dart';

class CardTransactionFormScreen extends ConsumerStatefulWidget {
  const CardTransactionFormScreen({super.key, required this.cardId});
  final int cardId;

  @override
  ConsumerState<CardTransactionFormScreen> createState() => _CardTransactionFormScreenState();
}

class _CardTransactionFormScreenState extends ConsumerState<CardTransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _installmentsController = TextEditingController(text: '1');
  final _notesController = TextEditingController();
  CardTransactionType _type = CardTransactionType.purchase;
  int? _categoryId;
  DateTime _purchaseDate = DateTime.now();
  bool _saving = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _installmentsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Novo lançamento no cartão')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          children: [
            Wrap(
              spacing: 8,
              children: [
                for (final t in CardTransactionType.values)
                  ChoiceChip(
                    label: Text(t.label),
                    selected: _type == t,
                    onSelected: (sel) => setState(() => _type = t),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe uma descrição' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Valor total (R\$)'),
              validator: (v) {
                final cents = Money.parseToCents(v ?? '');
                if (cents == null || cents <= 0) return 'Valor inválido';
                return null;
              },
            ),
            const SizedBox(height: 12),
            if (_type == CardTransactionType.purchase)
              TextFormField(
                controller: _installmentsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Número de parcelas'),
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n < 1 || n > 48) return 'Informe entre 1 e 48 parcelas';
                  return null;
                },
              ),
            if (_type == CardTransactionType.purchase) const SizedBox(height: 12),
            categoriesAsync.when(
              data: (categories) {
                final expenseCategories = categories.where((c) => c.kind == CategoryKind.expense && !c.isArchived).toList();
                return DropdownButtonFormField<int>(
                  initialValue: expenseCategories.any((c) => c.id == _categoryId) ? _categoryId : null,
                  decoration: const InputDecoration(labelText: 'Categoria (opcional)'),
                  items: [for (final c in expenseCategories) DropdownMenuItem(value: c.id, child: Text(c.name))],
                  onChanged: (v) => setState(() => _categoryId = v),
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Data da compra'),
              subtitle: Text(formatDate(_purchaseDate)),
              trailing: const Icon(Icons.edit_calendar_outlined),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _purchaseDate,
                  firstDate: DateTime(2015),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => _purchaseDate = picked);
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Observações (opcional)'),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final amount = Money.parseToCents(_amountController.text)!;
      final installments = _type == CardTransactionType.purchase ? int.parse(_installmentsController.text) : 1;
      await ref.read(creditCardServiceProvider).registerTransaction(
            cardId: widget.cardId,
            type: _type,
            description: _descriptionController.text,
            totalAmountCents: amount,
            purchaseDate: _purchaseDate,
            categoryId: _categoryId,
            installmentsCount: installments,
            notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
          );
      if (mounted) context.pop();
    } on ValidationException catch (e) {
      if (mounted) showAppSnackBar(context, e.message, isError: true);
    } catch (e) {
      if (mounted) showAppSnackBar(context, 'Erro inesperado: $e', isError: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
