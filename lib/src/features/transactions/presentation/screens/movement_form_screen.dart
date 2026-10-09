import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../data/database/database.dart';
import '../../../../domain/models/enums.dart';
import '../../../../domain/models/exceptions.dart';
import '../../../../providers/data_providers.dart';
import '../../../../providers/service_providers.dart';
import '../widgets/movement_type_label.dart';

class MovementFormScreen extends ConsumerStatefulWidget {
  const MovementFormScreen({super.key, this.movementId});

  final int? movementId;

  @override
  ConsumerState<MovementFormScreen> createState() => _MovementFormScreenState();
}

class _MovementFormScreenState extends ConsumerState<MovementFormScreen> {
  final _formKey = GlobalKey<FormState>();

  MovementType _type = MovementType.depositToBookmaker;
  int? _sourceAccountId;
  int? _destinationAccountId;
  final _amountController = TextEditingController();
  final _feeController = TextEditingController(text: '0,00');
  final _descriptionController = TextEditingController();
  final _reasonController = TextEditingController();
  DateTime _occurredAt = DateTime.now();
  bool _adjustmentIncreases = true;

  bool _loaded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.movementId == null) {
      _loaded = true;
    } else {
      _loadExisting();
    }
  }

  Future<void> _loadExisting() async {
    final m = await ref.read(movementServiceProvider).getById(widget.movementId!);
    if (m == null) {
      if (mounted) setState(() => _loaded = true);
      return;
    }
    _type = m.type;
    _sourceAccountId = m.sourceAccountId;
    _destinationAccountId = m.destinationAccountId;
    _amountController.text = (m.amountCents.abs() / 100).toStringAsFixed(2);
    _feeController.text = (m.feeCents / 100).toStringAsFixed(2);
    _descriptionController.text = m.description ?? '';
    _reasonController.text = m.adjustmentReason ?? '';
    _occurredAt = m.occurredAt;
    _adjustmentIncreases = m.amountCents >= 0;
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _feeController.dispose();
    _descriptionController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  bool get _needsSource =>
      _type == MovementType.externalWithdrawal ||
      _type == MovementType.depositToBookmaker ||
      _type == MovementType.withdrawalFromBookmaker ||
      _type == MovementType.transferBetweenAccounts ||
      _type == MovementType.adjustment;

  bool get _needsDestination =>
      _type == MovementType.externalDeposit ||
      _type == MovementType.depositToBookmaker ||
      _type == MovementType.withdrawalFromBookmaker ||
      _type == MovementType.transferBetweenAccounts;

  bool get _showFee =>
      _type == MovementType.externalWithdrawal ||
      _type == MovementType.externalDeposit ||
      _type == MovementType.depositToBookmaker ||
      _type == MovementType.withdrawalFromBookmaker ||
      _type == MovementType.transferBetweenAccounts;

  List<AccountRow> _sourceCandidates(List<AccountRow> all) {
    switch (_type) {
      case MovementType.externalWithdrawal:
        return all.where((a) => a.type == AccountType.bank).toList();
      case MovementType.depositToBookmaker:
        return all.where((a) => a.type == AccountType.bank).toList();
      case MovementType.withdrawalFromBookmaker:
        return all.where((a) => a.type == AccountType.bookmaker).toList();
      case MovementType.transferBetweenAccounts:
      case MovementType.adjustment:
        return all;
      case MovementType.externalDeposit:
        return const [];
    }
  }

  List<AccountRow> _destinationCandidates(List<AccountRow> all) {
    switch (_type) {
      case MovementType.externalDeposit:
        return all.where((a) => a.type == AccountType.bank).toList();
      case MovementType.depositToBookmaker:
        return all.where((a) => a.type == AccountType.bookmaker).toList();
      case MovementType.withdrawalFromBookmaker:
        return all.where((a) => a.type == AccountType.bank).toList();
      case MovementType.transferBetweenAccounts:
        return all;
      case MovementType.adjustment:
      case MovementType.externalWithdrawal:
        return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsStreamProvider);
    final isEditing = widget.movementId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar movimentação' : 'Nova movimentação'),
        actions: [
          if (isEditing) IconButton(icon: const Icon(Icons.delete_outline), onPressed: _delete),
        ],
      ),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : accountsAsync.when(
              data: (accounts) => _buildForm(context, accounts),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Erro: $e')),
            ),
    );
  }

  Widget _buildForm(BuildContext context, List<AccountRow> accounts) {
    final sources = _sourceCandidates(accounts);
    final destinations = _destinationCandidates(accounts);
    if (_sourceAccountId != null && !sources.any((a) => a.id == _sourceAccountId)) {
      _sourceAccountId = null;
    }
    if (_destinationAccountId != null && !destinations.any((a) => a.id == _destinationAccountId)) {
      _destinationAccountId = null;
    }

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          DropdownButtonFormField<MovementType>(
            initialValue: _type,
            decoration: const InputDecoration(labelText: 'Tipo de movimentação'),
            items: [
              for (final t in MovementType.values)
                DropdownMenuItem(value: t, child: Text(movementTypeLabel(t))),
            ],
            onChanged: (v) => setState(() {
              _type = v ?? _type;
              _sourceAccountId = null;
              _destinationAccountId = null;
            }),
          ),
          const SizedBox(height: 12),
          if (_needsSource) ...[
            DropdownButtonFormField<int>(
              initialValue: _sourceAccountId,
              decoration: InputDecoration(labelText: _type == MovementType.adjustment ? 'Conta' : 'Conta de origem'),
              items: [
                for (final a in sources) DropdownMenuItem(value: a.id, child: Text(a.name)),
              ],
              onChanged: (v) => setState(() => _sourceAccountId = v),
              validator: (v) => v == null ? 'Selecione a conta' : null,
            ),
            const SizedBox(height: 12),
          ],
          if (_needsDestination) ...[
            DropdownButtonFormField<int>(
              initialValue: _destinationAccountId,
              decoration: const InputDecoration(labelText: 'Conta de destino'),
              items: [
                for (final a in destinations) DropdownMenuItem(value: a.id, child: Text(a.name)),
              ],
              onChanged: (v) => setState(() => _destinationAccountId = v),
              validator: (v) => v == null ? 'Selecione a conta' : null,
            ),
            const SizedBox(height: 12),
          ],
          if (_type == MovementType.adjustment) ...[
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('Aumentar saldo'), icon: Icon(Icons.add)),
                ButtonSegment(value: false, label: Text('Diminuir saldo'), icon: Icon(Icons.remove)),
              ],
              selected: {_adjustmentIncreases},
              onSelectionChanged: (s) => setState(() => _adjustmentIncreases = s.first),
            ),
            const SizedBox(height: 12),
          ],
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
          if (_showFee) ...[
            const SizedBox(height: 12),
            TextFormField(
              controller: _feeController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Taxa (R\$, opcional)'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                final cents = Money.parseToCents(v);
                if (cents == null || cents < 0) return 'Taxa inválida';
                return null;
              },
            ),
          ],
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Data e horário'),
            subtitle: Text(formatDateTime(_occurredAt)),
            trailing: const Icon(Icons.edit_calendar_outlined),
            onTap: () async {
              final picked = await pickDateTime(context, _occurredAt);
              if (picked != null) setState(() => _occurredAt = picked);
            },
          ),
          const SizedBox(height: 12),
          if (_type == MovementType.adjustment)
            TextFormField(
              controller: _reasonController,
              decoration: const InputDecoration(labelText: 'Justificativa do ajuste'),
              maxLines: 2,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Informe a justificativa do ajuste' : null,
            ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Descrição (opcional)'),
            maxLines: 2,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : Text(widget.movementId == null ? 'Registrar movimentação' : 'Salvar alterações'),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final service = ref.read(movementServiceProvider);
    try {
      final amount = Money.parseToCents(_amountController.text)!;
      final fee = _feeController.text.trim().isEmpty ? 0 : (Money.parseToCents(_feeController.text) ?? 0);
      final signedAmount = _type == MovementType.adjustment
          ? (_adjustmentIncreases ? amount : -amount)
          : amount;

      await service.saveMovement(
        movementId: widget.movementId,
        type: _type,
        sourceAccountId: _needsSource ? _sourceAccountId : null,
        destinationAccountId: _needsDestination ? _destinationAccountId : null,
        amountCents: signedAmount,
        feeCents: fee,
        occurredAt: _occurredAt,
        description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
        adjustmentReason: _type == MovementType.adjustment ? _reasonController.text.trim() : null,
      );
      if (mounted) context.pop();
    } on InsufficientBalanceException catch (e) {
      _showError(e.toString());
    } on ValidationException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('Erro inesperado: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    final confirmed = await confirmDialog(
      context,
      title: 'Excluir movimentação',
      message: 'Esta ação não pode ser desfeita. Os lançamentos no extrato serão removidos.',
      confirmLabel: 'Excluir',
    );
    if (!confirmed) return;
    await ref.read(movementServiceProvider).deleteMovement(widget.movementId!);
    if (mounted) context.pop();
  }

  void _showError(String message) {
    showAppSnackBar(context, message, isError: true);
  }
}
