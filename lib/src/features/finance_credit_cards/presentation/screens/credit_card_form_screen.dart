import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../domain/models/enums.dart';
import '../../../../domain/models/exceptions.dart';
import '../../../../providers/data_providers.dart';
import '../../../../providers/service_providers.dart';

const _kCardColors = [0xFF7C3AED, 0xFF2563EB, 0xFFDC2626, 0xFF16A34A, 0xFFF59E0B, 0xFF0EA5E9];

class CreditCardFormScreen extends ConsumerStatefulWidget {
  const CreditCardFormScreen({super.key, this.cardId});
  final int? cardId;

  @override
  ConsumerState<CreditCardFormScreen> createState() => _CreditCardFormScreenState();
}

class _CreditCardFormScreenState extends ConsumerState<CreditCardFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _issuerController = TextEditingController();
  final _limitController = TextEditingController(text: '0,00');
  final _closingDayController = TextEditingController(text: '1');
  final _dueDayController = TextEditingController(text: '10');
  int? _defaultAccountId;
  int _colorValue = _kCardColors.first;

  bool _loaded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.cardId == null) {
      _loaded = true;
    } else {
      _loadExisting();
    }
  }

  Future<void> _loadExisting() async {
    final card = await ref.read(creditCardServiceProvider).getCardById(widget.cardId!);
    if (card == null) {
      if (mounted) setState(() => _loaded = true);
      return;
    }
    _nameController.text = card.name;
    _issuerController.text = card.issuerBank ?? '';
    _limitController.text = (card.creditLimitCents / 100).toStringAsFixed(2);
    _closingDayController.text = card.closingDay.toString();
    _dueDayController.text = card.dueDay.toString();
    _defaultAccountId = card.defaultPaymentAccountId;
    _colorValue = card.colorValue;
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _issuerController.dispose();
    _limitController.dispose();
    _closingDayController.dispose();
    _dueDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsStreamProvider);
    final isEditing = widget.cardId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar cartão' : 'Novo cartão'),
        actions: [
          if (isEditing) IconButton(icon: const Icon(Icons.delete_outline), onPressed: _archive),
        ],
      ),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nome do cartão'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe um nome' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _issuerController,
                    decoration: const InputDecoration(labelText: 'Banco emissor (opcional)'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _limitController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Limite total (R\$)'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _closingDayController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Dia de fechamento'),
                          validator: _dayValidator,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _dueDayController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Dia de vencimento'),
                          validator: _dayValidator,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  accountsAsync.when(
                    data: (accounts) {
                      final banks = accounts.where((a) => a.type == AccountType.bank).toList();
                      return DropdownButtonFormField<int>(
                        initialValue: banks.any((a) => a.id == _defaultAccountId) ? _defaultAccountId : null,
                        decoration: const InputDecoration(labelText: 'Conta padrão para pagamento (opcional)'),
                        items: [for (final a in banks) DropdownMenuItem(value: a.id, child: Text(a.name))],
                        onChanged: (v) => setState(() => _defaultAccountId = v),
                      );
                    },
                    loading: () => const LinearProgressIndicator(),
                    error: (_, _) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),
                  Text('Cor de identificação', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    children: [
                      for (final c in _kCardColors)
                        GestureDetector(
                          onTap: () => setState(() => _colorValue = c),
                          child: CircleAvatar(
                            backgroundColor: Color(c),
                            radius: 18,
                            child: _colorValue == c ? const Icon(Icons.check, color: Colors.white) : null,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    child: _saving
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Salvar'),
                  ),
                ],
              ),
            ),
    );
  }

  String? _dayValidator(String? v) {
    final day = int.tryParse(v ?? '');
    if (day == null || day < 1 || day > 31) return 'Dia inválido (1-31)';
    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final service = ref.read(creditCardServiceProvider);
      final limit = Money.parseToCents(_limitController.text) ?? 0;
      final closingDay = int.parse(_closingDayController.text);
      final dueDay = int.parse(_dueDayController.text);

      if (widget.cardId == null) {
        await service.createCard(
          name: _nameController.text,
          issuerBank: _issuerController.text.trim().isEmpty ? null : _issuerController.text.trim(),
          creditLimitCents: limit,
          closingDay: closingDay,
          dueDay: dueDay,
          defaultPaymentAccountId: _defaultAccountId,
          colorValue: _colorValue,
        );
      } else {
        final existing = await service.getCardById(widget.cardId!);
        if (existing == null) throw ValidationException('Cartão não encontrado.');
        await service.updateCard(existing.copyWith(
          name: _nameController.text.trim(),
          issuerBank: Value(_issuerController.text.trim().isEmpty ? null : _issuerController.text.trim()),
          creditLimitCents: limit,
          closingDay: closingDay,
          dueDay: dueDay,
          defaultPaymentAccountId: Value(_defaultAccountId),
          colorValue: _colorValue,
        ));
      }
      if (mounted) context.pop();
    } on ValidationException catch (e) {
      if (mounted) showAppSnackBar(context, e.message, isError: true);
    } catch (e) {
      if (mounted) showAppSnackBar(context, 'Erro inesperado: $e', isError: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _archive() async {
    final confirmed = await confirmDialog(
      context,
      title: 'Arquivar cartão',
      message: 'O cartão deixará de aparecer na lista, mas o histórico de compras e faturas é preservado.',
      confirmLabel: 'Arquivar',
    );
    if (!confirmed) return;
    await ref.read(creditCardServiceProvider).archiveCard(widget.cardId!);
    if (mounted) context.pop();
  }
}
