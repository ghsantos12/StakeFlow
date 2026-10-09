import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../data/database/database.dart';
import '../../../../domain/models/bet_leg.dart';
import '../../../../domain/models/enums.dart';
import '../../../../domain/models/exceptions.dart';
import '../../../../providers/data_providers.dart';
import '../../../../providers/service_providers.dart';
import '../widgets/bet_status_badge.dart';

/// Controllers de uma seleção dentro do formulário de aposta múltipla.
class _LegFormData {
  _LegFormData({String? sport})
      : sport = sport ?? kDefaultSports.first,
        eventController = TextEditingController(),
        marketController = TextEditingController(),
        selectionController = TextEditingController(),
        oddsController = TextEditingController();

  String sport;
  final TextEditingController eventController;
  final TextEditingController marketController;
  final TextEditingController selectionController;
  final TextEditingController oddsController;

  int? get oddsScaled => DecimalOdds.parse(oddsController.text);

  BetLegInput toInput() => BetLegInput(
        sport: sport,
        event: eventController.text,
        market: marketController.text,
        selection: selectionController.text,
        oddsScaled: oddsScaled ?? DecimalOdds.scale,
      );

  void dispose() {
    eventController.dispose();
    marketController.dispose();
    selectionController.dispose();
    oddsController.dispose();
  }
}

class BetFormScreen extends ConsumerStatefulWidget {
  const BetFormScreen({super.key, this.betId});

  final int? betId;

  @override
  ConsumerState<BetFormScreen> createState() => _BetFormScreenState();
}

class _BetFormScreenState extends ConsumerState<BetFormScreen> {
  final _formKey = GlobalKey<FormState>();

  int? _accountId;
  DateTime _placedAt = DateTime.now();
  DateTime? _settledAt;
  String _sport = kDefaultSports.first;
  final _eventController = TextEditingController();
  final _marketController = TextEditingController();
  final _selectionController = TextEditingController();
  final _stakeController = TextEditingController();
  final _oddsController = TextEditingController();
  final _cashoutController = TextEditingController();
  final _actualReturnController = TextEditingController();
  final _notesController = TextEditingController();
  BetStatus _status = BetStatus.open;
  BetType _betType = BetType.single;
  bool _adjustReturnManually = false;
  final List<_LegFormData> _legs = [_LegFormData(), _LegFormData()];

  bool _loaded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.betId == null) {
      _loaded = true;
    } else {
      _loadExisting();
    }
  }

  Future<void> _loadExisting() async {
    final service = ref.read(betServiceProvider);
    final bet = await service.getById(widget.betId!);
    if (bet == null) {
      if (mounted) setState(() => _loaded = true);
      return;
    }
    _accountId = bet.accountId;
    _placedAt = bet.placedAt;
    _settledAt = bet.settledAt;
    _sport = bet.sport;
    _eventController.text = bet.event;
    _marketController.text = bet.market;
    _selectionController.text = bet.selection;
    _stakeController.text = (bet.stakeCents / 100).toStringAsFixed(2);
    _oddsController.text = DecimalOdds.format(bet.oddsScaled);
    _cashoutController.text = bet.cashoutCents != null ? (bet.cashoutCents! / 100).toStringAsFixed(2) : '';
    _notesController.text = bet.notes ?? '';
    _status = bet.status;
    _adjustReturnManually = bet.actualReturnCents != null;
    _actualReturnController.text =
        bet.actualReturnCents != null ? (bet.actualReturnCents! / 100).toStringAsFixed(2) : '';
    _betType = service.typeOf(bet);
    if (_betType == BetType.multiple) {
      final legRows = await service.getLegs(bet.id);
      if (legRows.isNotEmpty) {
        _legs
          ..clear()
          ..addAll([
            for (final leg in legRows)
              _LegFormData(sport: leg.sport)
                ..eventController.text = leg.event
                ..marketController.text = leg.market
                ..selectionController.text = leg.selection
                ..oddsController.text = DecimalOdds.format(leg.oddsScaled),
          ]);
      }
    }
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _eventController.dispose();
    _marketController.dispose();
    _selectionController.dispose();
    _stakeController.dispose();
    _oddsController.dispose();
    _cashoutController.dispose();
    _actualReturnController.dispose();
    _notesController.dispose();
    for (final leg in _legs) {
      leg.dispose();
    }
    super.dispose();
  }

  int? get _stakeCents => Money.parseToCents(_stakeController.text);
  int? get _oddsScaled => DecimalOdds.parse(_oddsController.text);

  int get _effectiveOddsScaled {
    if (_betType == BetType.single) return _oddsScaled ?? DecimalOdds.scale;
    return combinedOddsScaled([for (final leg in _legs) leg.toInput()]);
  }

  int get _potentialReturn {
    final stake = _stakeCents ?? 0;
    return DecimalOdds.potentialReturn(stake, _effectiveOddsScaled);
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsStreamProvider);
    final isEditing = widget.betId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar aposta' : 'Nova aposta'),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
        ],
      ),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : accountsAsync.when(
              data: (accounts) {
                final bookmakers = accounts.where((a) => a.type == AccountType.bookmaker).toList();
                if (bookmakers.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Cadastre uma casa de apostas antes de registrar apostas.'),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: () => context.push('/settings/accounts/new'),
                          child: const Text('Cadastrar casa de apostas'),
                        ),
                      ],
                    ),
                  );
                }
                _accountId ??= bookmakers.first.id;
                return _buildForm(context, bookmakers);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Erro: $e')),
            ),
    );
  }

  Widget _buildForm(BuildContext context, List<AccountRow> bookmakers) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          DropdownButtonFormField<int>(
            initialValue: _accountId,
            decoration: const InputDecoration(labelText: 'Casa de apostas'),
            items: [
              for (final a in bookmakers) DropdownMenuItem(value: a.id, child: Text(a.name)),
            ],
            onChanged: (v) => setState(() => _accountId = v),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Data e horário da aposta'),
            subtitle: Text(formatDateTime(_placedAt)),
            trailing: const Icon(Icons.edit_calendar_outlined),
            onTap: () async {
              final picked = await pickDateTime(context, _placedAt);
              if (picked != null) setState(() => _placedAt = picked);
            },
          ),
          const SizedBox(height: 12),
          SegmentedButton<BetType>(
            segments: const [
              ButtonSegment(value: BetType.single, label: Text('Simples')),
              ButtonSegment(value: BetType.multiple, label: Text('Múltipla')),
            ],
            selected: {_betType},
            onSelectionChanged: (s) => setState(() => _betType = s.first),
          ),
          const SizedBox(height: 16),
          if (_betType == BetType.single) ..._buildSingleFields() else ..._buildMultipleFields(context),
          const SizedBox(height: 12),
          TextFormField(
            controller: _stakeController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Stake (R\$)'),
            onChanged: (_) => setState(() {}),
            validator: (v) {
              final cents = Money.parseToCents(v ?? '');
              if (cents == null || cents <= 0) return 'Stake inválida';
              return null;
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ReadOnlyField(
                  label: 'Retorno potencial',
                  value: Money.format(_potentialReturn),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ReadOnlyField(
                  label: 'Lucro potencial',
                  value: Money.format(_potentialReturn - (_stakeCents ?? 0)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text('Status', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final status in BetStatus.values)
                ChoiceChip(
                  label: Text(betStatusLabel(status)),
                  selected: _status == status,
                  onSelected: (sel) {
                    if (!sel) return;
                    setState(() {
                      _status = status;
                      if (status != BetStatus.open && _settledAt == null) {
                        _settledAt = DateTime.now();
                      }
                    });
                  },
                ),
            ],
          ),
          if (_status != BetStatus.open) ...[
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Data e horário da liquidação'),
              subtitle: Text(_settledAt != null ? formatDateTime(_settledAt!) : 'Não definida'),
              trailing: const Icon(Icons.edit_calendar_outlined),
              onTap: () async {
                final picked = await pickDateTime(context, _settledAt ?? DateTime.now());
                if (picked != null) setState(() => _settledAt = picked);
              },
            ),
          ],
          if (_status == BetStatus.cashedOut) ...[
            const SizedBox(height: 12),
            TextFormField(
              controller: _cashoutController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Valor recebido no cashout (R\$)'),
              validator: (v) {
                if (_status != BetStatus.cashedOut) return null;
                final cents = Money.parseToCents(v ?? '');
                if (cents == null || cents < 0) return 'Valor inválido';
                return null;
              },
            ),
          ],
          if (_status == BetStatus.won) ...[
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Ajustar valor recebido manualmente'),
              subtitle: const Text('Use quando o arredondamento da odd da casa gerar centavos diferentes'),
              value: _adjustReturnManually,
              onChanged: (v) => setState(() {
                _adjustReturnManually = v;
                if (v && _actualReturnController.text.isEmpty) {
                  _actualReturnController.text = (_potentialReturn / 100).toStringAsFixed(2);
                }
              }),
            ),
            if (_adjustReturnManually) ...[
              const SizedBox(height: 8),
              TextFormField(
                controller: _actualReturnController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Valor total recebido (R\$)'),
                validator: (v) {
                  if (_status != BetStatus.won || !_adjustReturnManually) return null;
                  final cents = Money.parseToCents(v ?? '');
                  if (cents == null || cents < 0) return 'Valor inválido';
                  return null;
                },
              ),
            ],
          ],
          const SizedBox(height: 12),
          TextFormField(
            controller: _notesController,
            decoration: const InputDecoration(labelText: 'Observações (opcional)'),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : Text(widget.betId == null ? 'Registrar aposta' : 'Salvar alterações'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSingleFields() {
    return [
      DropdownButtonFormField<String>(
        initialValue: _sport,
        decoration: const InputDecoration(labelText: 'Esporte'),
        items: [
          for (final s in kDefaultSports) DropdownMenuItem(value: s, child: Text(s)),
        ],
        onChanged: (v) => setState(() => _sport = v ?? _sport),
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _eventController,
        decoration: const InputDecoration(labelText: 'Evento / partida'),
        validator: (v) =>
            (_betType == BetType.single && (v == null || v.trim().isEmpty)) ? 'Informe o evento' : null,
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _marketController,
        decoration: const InputDecoration(labelText: 'Mercado'),
        validator: (v) =>
            (_betType == BetType.single && (v == null || v.trim().isEmpty)) ? 'Informe o mercado' : null,
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _selectionController,
        decoration: const InputDecoration(labelText: 'Descrição da seleção'),
        validator: (v) =>
            (_betType == BetType.single && (v == null || v.trim().isEmpty)) ? 'Informe a seleção' : null,
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _oddsController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(labelText: 'Odd decimal'),
        onChanged: (_) => setState(() {}),
        validator: (v) {
          if (_betType != BetType.single) return null;
          final odds = DecimalOdds.parse(v ?? '');
          if (odds == null) return 'Odd inválida (mín. 1,01)';
          return null;
        },
      ),
    ];
  }

  List<Widget> _buildMultipleFields(BuildContext context) {
    return [
      for (var i = 0; i < _legs.length; i++) _buildLegCard(context, i),
      const SizedBox(height: 4),
      OutlinedButton.icon(
        onPressed: () => setState(() => _legs.add(_LegFormData())),
        icon: const Icon(Icons.add),
        label: const Text('Adicionar seleção'),
      ),
      const SizedBox(height: 12),
      _ReadOnlyField(
        label: 'Odd combinada (${_legs.length} seleções)',
        value: DecimalOdds.format(_effectiveOddsScaled),
      ),
    ];
  }

  Widget _buildLegCard(BuildContext context, int index) {
    final leg = _legs[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Seleção ${index + 1}', style: Theme.of(context).textTheme.titleSmall),
                ),
                if (_legs.length > 2)
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () => setState(() => _legs.removeAt(index).dispose()),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: leg.sport,
              decoration: const InputDecoration(labelText: 'Esporte'),
              items: [
                for (final s in kDefaultSports) DropdownMenuItem(value: s, child: Text(s)),
              ],
              onChanged: (v) => setState(() => leg.sport = v ?? leg.sport),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: leg.eventController,
              decoration: const InputDecoration(labelText: 'Evento / partida'),
              validator: (v) =>
                  (_betType == BetType.multiple && (v == null || v.trim().isEmpty)) ? 'Informe o evento' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: leg.marketController,
              decoration: const InputDecoration(labelText: 'Mercado'),
              validator: (v) =>
                  (_betType == BetType.multiple && (v == null || v.trim().isEmpty)) ? 'Informe o mercado' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: leg.selectionController,
              decoration: const InputDecoration(labelText: 'Descrição da seleção'),
              validator: (v) =>
                  (_betType == BetType.multiple && (v == null || v.trim().isEmpty)) ? 'Informe a seleção' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: leg.oddsController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Odd decimal'),
              onChanged: (_) => setState(() {}),
              validator: (v) {
                if (_betType != BetType.multiple) return null;
                final odds = DecimalOdds.parse(v ?? '');
                if (odds == null) return 'Odd inválida (mín. 1,01)';
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() || _accountId == null) return;
    if (_betType == BetType.multiple && _legs.length < 2) {
      showAppSnackBar(context, 'Uma aposta múltipla precisa de pelo menos duas seleções.', isError: true);
      return;
    }
    setState(() => _saving = true);
    final service = ref.read(betServiceProvider);
    try {
      final stakeCents = _stakeCents!;
      final legInputs = [for (final leg in _legs) leg.toInput()];
      final sport = _betType == BetType.single ? _sport : summarizeLegSport(legInputs);
      final event = _betType == BetType.single ? _eventController.text : summarizeLegEvents(legInputs);
      final market = _betType == BetType.single ? _marketController.text : 'Combinada';
      final selection = _betType == BetType.single ? _selectionController.text : summarizeLegSelections(legInputs);
      final oddsScaled = _betType == BetType.single ? _oddsScaled! : combinedOddsScaled(legInputs);
      final cashoutCents = _status == BetStatus.cashedOut ? Money.parseToCents(_cashoutController.text) : null;
      final actualReturnCents = (_status == BetStatus.won && _adjustReturnManually)
          ? Money.parseToCents(_actualReturnController.text)
          : null;

      if (widget.betId == null) {
        await service.placeBet(
          accountId: _accountId!,
          placedAt: _placedAt,
          sport: sport,
          event: event,
          market: market,
          selection: selection,
          stakeCents: stakeCents,
          oddsScaled: oddsScaled,
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
          betType: _betType,
          legs: _betType == BetType.multiple ? legInputs : const [],
        );
      } else {
        await service.updateBet(
          betId: widget.betId!,
          accountId: _accountId!,
          placedAt: _placedAt,
          sport: sport,
          event: event,
          market: market,
          selection: selection,
          stakeCents: stakeCents,
          oddsScaled: oddsScaled,
          status: _status,
          settledAt: _settledAt,
          cashoutCents: cashoutCents,
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
          betType: _betType,
          legs: _betType == BetType.multiple ? legInputs : const [],
          actualReturnCents: actualReturnCents,
        );
      }
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
      title: 'Excluir aposta',
      message: 'Esta ação não pode ser desfeita. Os lançamentos no extrato serão removidos.',
      confirmLabel: 'Excluir',
    );
    if (!confirmed) return;
    await ref.read(betServiceProvider).deleteBet(widget.betId!);
    if (mounted) context.pop();
  }

  void _showError(String message) {
    showAppSnackBar(context, message, isError: true);
  }
}

class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(labelText: label),
      child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
