import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../data/database/database.dart';
import '../../../../domain/models/enums.dart';
import '../../../../domain/models/exceptions.dart';
import '../../../../providers/data_providers.dart';
import '../../../../providers/financial_data_providers.dart';
import '../../../../providers/service_providers.dart';
import '../../../finance_credit_cards/presentation/widgets/bill_status_label.dart';

class BillPayableFormScreen extends ConsumerStatefulWidget {
  const BillPayableFormScreen({super.key, this.billId});
  final int? billId;

  @override
  ConsumerState<BillPayableFormScreen> createState() => _BillPayableFormScreenState();
}

class _BillPayableFormScreenState extends ConsumerState<BillPayableFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  int? _categoryId;
  int? _accountId;
  DateTime _dueDate = DateTime.now();
  RecurrenceFrequency? _recurrence;
  bool _loaded = false;
  bool _saving = false;
  BillPayableRow? _existing;

  @override
  void initState() {
    super.initState();
    if (widget.billId == null) {
      _loaded = true;
    } else {
      _loadExisting();
    }
  }

  Future<void> _loadExisting() async {
    final bill = await ref.read(billsPayableServiceProvider).getById(widget.billId!);
    _existing = bill;
    if (bill != null) {
      _descriptionController.text = bill.description;
      _amountController.text = (bill.amountCents / 100).toStringAsFixed(2);
      _notesController.text = bill.notes ?? '';
      _categoryId = bill.categoryId;
      _accountId = bill.accountId;
      _dueDate = bill.dueDate;
    }
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.billId != null;
    final categoriesAsync = ref.watch(categoriesStreamProvider);
    final accountsAsync = ref.watch(accountsStreamProvider);
    final summaryAsync = isEditing ? ref.watch(billPayableSummaryProvider(widget.billId!)) : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Conta a pagar' : 'Nova conta a pagar'),
        actions: [
          if (isEditing) IconButton(icon: const Icon(Icons.delete_outline), onPressed: _delete),
        ],
      ),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              children: [
                if (isEditing && summaryAsync != null)
                  summaryAsync.when(
                    data: (s) => s == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: SectionCard(
                              child: Row(
                                children: [
                                  Icon(Icons.circle, size: 10, color: billStatusColor(s.status)),
                                  const SizedBox(width: 8),
                                  Text(s.status.label),
                                  const Spacer(),
                                  Text('Pago: ${Money.format(s.paidAmountCents)} de ${Money.format(s.bill.amountCents)}'),
                                ],
                              ),
                            ),
                          ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, _) => const SizedBox.shrink(),
                  ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(labelText: 'Descrição'),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe uma descrição' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                        validator: (v) {
                          final cents = Money.parseToCents(v ?? '');
                          if (cents == null || cents <= 0) return 'Valor inválido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      categoriesAsync.when(
                        data: (categories) {
                          final expense = categories.where((c) => c.kind == CategoryKind.expense && !c.isArchived).toList();
                          return DropdownButtonFormField<int>(
                            initialValue: expense.any((c) => c.id == _categoryId) ? _categoryId : null,
                            decoration: const InputDecoration(labelText: 'Categoria (opcional)'),
                            items: [for (final c in expense) DropdownMenuItem(value: c.id, child: Text(c.name))],
                            onChanged: (v) => setState(() => _categoryId = v),
                          );
                        },
                        loading: () => const LinearProgressIndicator(),
                        error: (_, _) => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 12),
                      accountsAsync.when(
                        data: (accounts) {
                          final banks = accounts.where((a) => a.type == AccountType.bank).toList();
                          return DropdownButtonFormField<int>(
                            initialValue: banks.any((a) => a.id == _accountId) ? _accountId : null,
                            decoration: const InputDecoration(labelText: 'Conta prevista (opcional)'),
                            items: [for (final a in banks) DropdownMenuItem(value: a.id, child: Text(a.name))],
                            onChanged: (v) => setState(() => _accountId = v),
                          );
                        },
                        loading: () => const LinearProgressIndicator(),
                        error: (_, _) => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Vencimento'),
                        subtitle: Text(formatDate(_dueDate)),
                        trailing: const Icon(Icons.edit_calendar_outlined),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _dueDate,
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) setState(() => _dueDate = picked);
                        },
                      ),
                      if (!isEditing) ...[
                        const SizedBox(height: 12),
                        DropdownButtonFormField<RecurrenceFrequency?>(
                          initialValue: _recurrence,
                          decoration: const InputDecoration(labelText: 'Recorrência (opcional)'),
                          items: [
                            const DropdownMenuItem(value: null, child: Text('Sem recorrência')),
                            for (final f in RecurrenceFrequency.values)
                              DropdownMenuItem(value: f, child: Text(f.label)),
                          ],
                          onChanged: (v) => setState(() => _recurrence = v),
                        ),
                      ],
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
                            : const Text('Salvar'),
                      ),
                      if (isEditing) ...[
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: () => _openPayDialog(context),
                          icon: const Icon(Icons.payments_outlined),
                          label: const Text('Registrar pagamento'),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: _cancel,
                          style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                          child: const Text('Cancelar conta'),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final amount = Money.parseToCents(_amountController.text)!;
      final service = ref.read(billsPayableServiceProvider);
      if (widget.billId == null) {
        await service.create(
          description: _descriptionController.text,
          amountCents: amount,
          categoryId: _categoryId,
          accountId: _accountId,
          dueDate: _dueDate,
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
          recurrenceFrequency: _recurrence,
        );
      } else {
        final existing = _existing;
        if (existing == null) throw ValidationException('Conta não encontrada.');
        await service.update(existing.copyWith(
          description: _descriptionController.text.trim(),
          amountCents: amount,
          categoryId: Value(_categoryId),
          accountId: Value(_accountId),
          dueDate: _dueDate,
          notes: Value(_notesController.text.trim().isEmpty ? null : _notesController.text.trim()),
        ));
      }
      if (mounted) context.pop();
    } on ValidationException catch (e) {
      if (mounted) showAppSnackBar(context, e.message, isError: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _openPayDialog(BuildContext context) async {
    final bill = _existing;
    if (bill == null) return;
    final paid = await ref.read(billsPayableServiceProvider).paidAmountCents(bill.id);
    if (!context.mounted) return;
    final remaining = bill.amountCents - paid;
    if (remaining <= 0) {
      showAppSnackBar(context, 'Esta conta já está totalmente paga.');
      return;
    }
    final amountController = TextEditingController(text: (remaining / 100).toStringAsFixed(2));
    final accounts = await ref.read(accountsStreamProvider.future);
    final banks = accounts.where((a) => a.type == AccountType.bank).toList();
    int? accountId = _accountId ?? (banks.isNotEmpty ? banks.first.id : null);
    var paidAt = DateTime.now();

    if (!context.mounted) return;
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Registrar pagamento'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<int>(
                    initialValue: accountId,
                    decoration: const InputDecoration(labelText: 'Conta bancária'),
                    items: [for (final a in banks) DropdownMenuItem(value: a.id, child: Text(a.name))],
                    onChanged: (v) => setState(() => accountId = v),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Valor pago (R\$)'),
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
                FilledButton(
                  onPressed: () async {
                    final amount = Money.parseToCents(amountController.text);
                    if (amount == null || amount <= 0 || accountId == null) {
                      showAppSnackBar(context, 'Preencha os dados corretamente', isError: true);
                      return;
                    }
                    try {
                      await ref.read(billsPayableServiceProvider).pay(
                            billId: bill.id,
                            accountId: accountId!,
                            amountCents: amount,
                            paidAt: paidAt,
                          );
                      if (context.mounted) Navigator.of(context).pop();
                    } catch (e) {
                      if (context.mounted) showAppSnackBar(context, 'Erro: $e', isError: true);
                    }
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _delete() async {
    final confirmed = await confirmDialog(
      context,
      title: 'Excluir conta a pagar',
      message: 'Esta ação não pode ser desfeita.',
      confirmLabel: 'Excluir',
    );
    if (!confirmed) return;
    await ref.read(billsPayableServiceProvider).delete(widget.billId!);
    if (mounted) context.pop();
  }

  Future<void> _cancel() async {
    final confirmed = await confirmDialog(
      context,
      title: 'Cancelar conta',
      message: 'A conta ficará marcada como cancelada e não entrará nas previsões.',
      confirmLabel: 'Cancelar conta',
    );
    if (!confirmed) return;
    await ref.read(billsPayableServiceProvider).cancel(widget.billId!);
    if (mounted) context.pop();
  }
}
