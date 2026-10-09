import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../domain/models/enums.dart';
import '../../../../domain/models/exceptions.dart';
import '../../../../providers/service_providers.dart';

class AccountFormScreen extends ConsumerStatefulWidget {
  const AccountFormScreen({super.key, this.accountId});

  final int? accountId;

  @override
  ConsumerState<AccountFormScreen> createState() => _AccountFormScreenState();
}

class _AccountFormScreenState extends ConsumerState<AccountFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _institutionController = TextEditingController();
  final _initialBalanceController = TextEditingController(text: '0,00');
  final _cdiPercentController = TextEditingController(text: '100');
  final _accumulatedBeforeController = TextEditingController(text: '0,00');

  AccountType _type = AccountType.bookmaker;
  CdbAccountingType _cdbAccountingType = CdbAccountingType.net;
  DateTime _cdbTrackingStart = DateTime.now();

  bool _loaded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.accountId == null) {
      _loaded = true;
    } else {
      _loadExisting();
    }
  }

  Future<void> _loadExisting() async {
    final account = await ref.read(accountServiceProvider).getById(widget.accountId!);
    if (account == null) {
      if (mounted) setState(() => _loaded = true);
      return;
    }
    _nameController.text = account.name;
    _institutionController.text = account.institution ?? '';
    _initialBalanceController.text = (account.initialBalanceCents / 100).toStringAsFixed(2);
    _type = account.type;
    if (account.cdiPercent != null) _cdiPercentController.text = account.cdiPercent!.toStringAsFixed(0);
    if (account.cdbAccountingType != null) _cdbAccountingType = account.cdbAccountingType!;
    if (account.cdbTrackingStartDate != null) _cdbTrackingStart = account.cdbTrackingStartDate!;
    _accumulatedBeforeController.text =
        (account.cdbAccumulatedBeforeTrackingCents / 100).toStringAsFixed(2);
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _institutionController.dispose();
    _initialBalanceController.dispose();
    _cdiPercentController.dispose();
    _accumulatedBeforeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.accountId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar conta' : 'Nova conta')),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                children: [
                  if (!isEditing)
                    SegmentedButton<AccountType>(
                      segments: const [
                        ButtonSegment(
                            value: AccountType.bank, label: Text('Conta bancária'), icon: Icon(Icons.account_balance)),
                        ButtonSegment(
                            value: AccountType.bookmaker, label: Text('Casa de apostas'), icon: Icon(Icons.casino)),
                      ],
                      selected: {_type},
                      onSelectionChanged: (s) => setState(() => _type = s.first),
                    ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: _type == AccountType.bank ? 'Nome da conta' : 'Nome da plataforma',
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe um nome' : null,
                  ),
                  if (_type == AccountType.bank) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _institutionController,
                      decoration: const InputDecoration(labelText: 'Instituição financeira (opcional)'),
                    ),
                  ],
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _initialBalanceController,
                    enabled: !isEditing,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Saldo inicial (R\$)',
                      helperText: isEditing
                          ? 'Para corrigir divergências, use um ajuste de saldo.'
                          : null,
                    ),
                    validator: (v) {
                      final cents = Money.parseToCents(v ?? '');
                      if (cents == null) return 'Valor inválido';
                      return null;
                    },
                  ),
                  if (_type == AccountType.bank) ...[
                    const Divider(height: 32),
                    Text('Rendimento de CDB', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _cdiPercentController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Percentual do CDI (ex.: 100, 105, 110)'),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<CdbAccountingType>(
                      initialValue: _cdbAccountingType,
                      decoration: const InputDecoration(labelText: 'Contabilização do rendimento'),
                      items: const [
                        DropdownMenuItem(value: CdbAccountingType.gross, child: Text('Bruto')),
                        DropdownMenuItem(value: CdbAccountingType.net, child: Text('Líquido')),
                      ],
                      onChanged: (v) => setState(() => _cdbAccountingType = v ?? _cdbAccountingType),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Data inicial do acompanhamento'),
                      subtitle: Text(
                          '${_cdbTrackingStart.day.toString().padLeft(2, '0')}/${_cdbTrackingStart.month.toString().padLeft(2, '0')}/${_cdbTrackingStart.year}'),
                      trailing: const Icon(Icons.edit_calendar_outlined),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _cdbTrackingStart,
                          firstDate: DateTime(2015),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) setState(() => _cdbTrackingStart = picked);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _accumulatedBeforeController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Rendimento acumulado antes do acompanhamento (R\$)',
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    child: _saving
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Salvar'),
                  ),
                  if (isEditing) ...[
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: _delete,
                      style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                      child: const Text('Excluir conta'),
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final service = ref.read(accountServiceProvider);
    try {
      if (widget.accountId == null) {
        await service.createAccount(
          name: _nameController.text,
          type: _type,
          institution: _institutionController.text.trim().isEmpty ? null : _institutionController.text.trim(),
          initialBalanceCents: Money.parseToCents(_initialBalanceController.text) ?? 0,
          cdiPercent: _type == AccountType.bank ? double.tryParse(_cdiPercentController.text.replaceAll(',', '.')) : null,
          cdbAccountingType: _type == AccountType.bank ? _cdbAccountingType : null,
          cdbTrackingStartDate: _type == AccountType.bank ? _cdbTrackingStart : null,
          cdbAccumulatedBeforeTrackingCents:
              _type == AccountType.bank ? (Money.parseToCents(_accumulatedBeforeController.text) ?? 0) : 0,
        );
      } else {
        final existing = await service.getById(widget.accountId!);
        if (existing == null) throw ValidationException('Conta não encontrada.');
        await service.updateAccount(existing.copyWith(
          name: _nameController.text.trim(),
          institution: Value(_institutionController.text.trim().isEmpty ? null : _institutionController.text.trim()),
          cdiPercent: Value(_type == AccountType.bank
              ? double.tryParse(_cdiPercentController.text.replaceAll(',', '.'))
              : null),
          cdbAccountingType: Value(_type == AccountType.bank ? _cdbAccountingType : null),
          cdbTrackingStartDate: Value(_type == AccountType.bank ? _cdbTrackingStart : null),
          cdbAccumulatedBeforeTrackingCents:
              _type == AccountType.bank ? (Money.parseToCents(_accumulatedBeforeController.text) ?? 0) : 0,
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

  Future<void> _delete() async {
    final confirmed = await confirmDialog(
      context,
      title: 'Excluir conta',
      message:
          'Só é possível excluir contas sem apostas, movimentações ou lançamentos vinculados.',
      confirmLabel: 'Excluir',
    );
    if (!confirmed) return;
    try {
      await ref.read(accountServiceProvider).deleteAccount(widget.accountId!);
      if (mounted) context.pop();
    } on ValidationException catch (e) {
      if (mounted) showAppSnackBar(context, e.message, isError: true);
    }
  }
}
