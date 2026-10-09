import 'package:drift/drift.dart';
import '../../core/utils/money.dart';
import '../../data/database/database.dart';
import '../../data/repositories/settings_repository.dart';
import '../models/enums.dart';
import '../models/exceptions.dart';

/// Centraliza toda a regra de negócio de apostas: criação, edição,
/// liquidação e exclusão. Toda operação é atômica (uma transação do
/// banco) e idempotente — editar ou religar uma aposta sempre remove os
/// lançamentos antigos vinculados a ela antes de recriar os novos, de
/// forma que o extrato nunca contabilize a mesma aposta duas vezes.
class BetService {
  BetService(this._db, this._settings);

  final AppDatabase _db;
  final SettingsRepository _settings;

  Stream<List<BetRow>> watchAll() => _db.betsDao.watchAll();

  Future<List<BetRow>> getAll() => _db.betsDao.getAll();

  Future<BetRow?> getById(int id) => _db.betsDao.getById(id);

  Stream<BetRow?> watchById(int id) => _db.betsDao.watchById(id);

  Future<int> placeBet({
    required int accountId,
    required DateTime placedAt,
    required String sport,
    required String event,
    required String market,
    required String selection,
    required int stakeCents,
    required int oddsScaled,
    String? notes,
  }) {
    return _saveBet(
      betId: null,
      accountId: accountId,
      placedAt: placedAt,
      sport: sport,
      event: event,
      market: market,
      selection: selection,
      stakeCents: stakeCents,
      oddsScaled: oddsScaled,
      status: BetStatus.open,
      settledAt: null,
      cashoutCents: null,
      notes: notes,
    );
  }

  /// Edita todos os campos de uma aposta existente, incluindo status e
  /// liquidação. Os saldos são recalculados automaticamente.
  Future<void> updateBet({
    required int betId,
    required int accountId,
    required DateTime placedAt,
    required String sport,
    required String event,
    required String market,
    required String selection,
    required int stakeCents,
    required int oddsScaled,
    required BetStatus status,
    DateTime? settledAt,
    int? cashoutCents,
    String? notes,
  }) {
    return _saveBet(
      betId: betId,
      accountId: accountId,
      placedAt: placedAt,
      sport: sport,
      event: event,
      market: market,
      selection: selection,
      stakeCents: stakeCents,
      oddsScaled: oddsScaled,
      status: status,
      settledAt: settledAt,
      cashoutCents: cashoutCents,
      notes: notes,
    );
  }

  /// Liquida uma aposta em aberto (ou religa o resultado de uma já
  /// liquidada), mantendo os demais dados inalterados.
  Future<void> settleBet({
    required int betId,
    required BetStatus status,
    required DateTime settledAt,
    int? cashoutCents,
  }) async {
    final bet = await _db.betsDao.getById(betId);
    if (bet == null) throw ValidationException('Aposta não encontrada.');
    await _saveBet(
      betId: betId,
      accountId: bet.accountId,
      placedAt: bet.placedAt,
      sport: bet.sport,
      event: bet.event,
      market: bet.market,
      selection: bet.selection,
      stakeCents: bet.stakeCents,
      oddsScaled: bet.oddsScaled,
      status: status,
      settledAt: settledAt,
      cashoutCents: cashoutCents,
      notes: bet.notes,
    );
  }

  /// Reabre uma aposta liquidada, revertendo o resultado.
  Future<void> reopenBet(int betId) async {
    final bet = await _db.betsDao.getById(betId);
    if (bet == null) throw ValidationException('Aposta não encontrada.');
    await _saveBet(
      betId: betId,
      accountId: bet.accountId,
      placedAt: bet.placedAt,
      sport: bet.sport,
      event: bet.event,
      market: bet.market,
      selection: bet.selection,
      stakeCents: bet.stakeCents,
      oddsScaled: bet.oddsScaled,
      status: BetStatus.open,
      settledAt: null,
      cashoutCents: null,
      notes: bet.notes,
    );
  }

  Future<void> deleteBet(int betId) async {
    await _db.transaction(() async {
      await _db.ledgerDao.deleteForBet(betId);
      await _db.betsDao.deleteBet(betId);
    });
  }

  Future<int> _saveBet({
    required int? betId,
    required int accountId,
    required DateTime placedAt,
    required String sport,
    required String event,
    required String market,
    required String selection,
    required int stakeCents,
    required int oddsScaled,
    required BetStatus status,
    required DateTime? settledAt,
    required int? cashoutCents,
    String? notes,
  }) async {
    _validateStakeOdds(stakeCents, oddsScaled);
    if (event.trim().isEmpty) throw ValidationException('Informe o evento/partida.');
    if (sport.trim().isEmpty) throw ValidationException('Informe o esporte.');
    if (status != BetStatus.open && settledAt == null) {
      throw ValidationException('Informe a data de liquidação.');
    }
    if (status == BetStatus.cashedOut && (cashoutCents == null || cashoutCents < 0)) {
      throw ValidationException('Informe o valor recebido no cashout.');
    }

    return _db.transaction<int>(() async {
      final now = DateTime.now();

      if (betId != null) {
        await _db.ledgerDao.deleteForBet(betId);
      }

      final account = await _requireBookmaker(accountId);
      await _checkAvailable(account, stakeCents);

      int? creditAmount;
      int? resultCents;
      if (status != BetStatus.open) {
        creditAmount = _creditAmountFor(status, stakeCents, oddsScaled, cashoutCents);
        resultCents = _resultFor(status, stakeCents, creditAmount);
      }

      final int id;
      if (betId == null) {
        id = await _db.betsDao.insertBet(BetsCompanion.insert(
          accountId: accountId,
          placedAt: placedAt,
          sport: sport.trim(),
          event: event.trim(),
          market: market.trim(),
          selection: selection.trim(),
          stakeCents: stakeCents,
          oddsScaled: oddsScaled,
          status: status,
          settledAt: Value(settledAt),
          cashoutCents: Value(status == BetStatus.cashedOut ? cashoutCents : null),
          resultCents: Value(resultCents),
          notes: Value(notes),
          createdAt: now,
          updatedAt: now,
        ));
      } else {
        id = betId;
        final existing = await _db.betsDao.getById(betId);
        if (existing == null) throw ValidationException('Aposta não encontrada.');
        await _db.betsDao.updateBet(existing.copyWith(
          accountId: accountId,
          placedAt: placedAt,
          sport: sport.trim(),
          event: event.trim(),
          market: market.trim(),
          selection: selection.trim(),
          stakeCents: stakeCents,
          oddsScaled: oddsScaled,
          status: status,
          settledAt: Value(settledAt),
          cashoutCents: Value(status == BetStatus.cashedOut ? cashoutCents : null),
          resultCents: Value(resultCents),
          notes: Value(notes),
          updatedAt: now,
        ));
      }

      await _db.ledgerDao.insertEntry(LedgerEntriesCompanion.insert(
        accountId: accountId,
        occurredAt: placedAt,
        type: LedgerEntryType.betPlaced,
        amountCents: -stakeCents,
        betId: Value(id),
        description: Value('Aposta: ${event.trim()}'),
        createdAt: now,
      ));

      if (status != BetStatus.open) {
        await _db.ledgerDao.insertEntry(LedgerEntriesCompanion.insert(
          accountId: accountId,
          occurredAt: settledAt!,
          type: _settleType(status),
          amountCents: creditAmount!,
          betId: Value(id),
          description: Value('Liquidação (${_statusLabel(status)}): ${event.trim()}'),
          createdAt: now,
        ));
      }

      return id;
    });
  }

  Future<AccountRow> _requireBookmaker(int accountId) async {
    final account = await _db.accountsDao.getById(accountId);
    if (account == null) throw ValidationException('Conta não encontrada.');
    if (account.type != AccountType.bookmaker) {
      throw ValidationException('A conta selecionada não é uma casa de apostas.');
    }
    return account;
  }

  Future<void> _checkAvailable(AccountRow account, int stakeCents) async {
    if (!_settings.blockInsufficientBalance) return;
    final balance = account.initialBalanceCents + await _db.ledgerDao.sumForAccount(account.id);
    if (balance < stakeCents) {
      throw InsufficientBalanceException(account.name, balance, stakeCents);
    }
  }

  void _validateStakeOdds(int stakeCents, int oddsScaled) {
    if (stakeCents <= 0) throw ValidationException('A stake deve ser maior que zero.');
    if (oddsScaled < 1010) {
      throw ValidationException('A odd deve ser maior ou igual a 1,01.');
    }
  }

  int _creditAmountFor(BetStatus status, int stakeCents, int oddsScaled, int? cashoutCents) {
    switch (status) {
      case BetStatus.won:
        return DecimalOdds.potentialReturn(stakeCents, oddsScaled);
      case BetStatus.lost:
        return 0;
      case BetStatus.voided:
        return stakeCents;
      case BetStatus.cashedOut:
        return cashoutCents!;
      case BetStatus.open:
        throw StateError('Aposta em aberto não possui valor de crédito.');
    }
  }

  int _resultFor(BetStatus status, int stakeCents, int creditAmount) {
    switch (status) {
      case BetStatus.won:
        return creditAmount - stakeCents;
      case BetStatus.lost:
        return -stakeCents;
      case BetStatus.voided:
        return 0;
      case BetStatus.cashedOut:
        return creditAmount - stakeCents;
      case BetStatus.open:
        throw StateError('Aposta em aberto não possui resultado.');
    }
  }

  LedgerEntryType _settleType(BetStatus status) {
    switch (status) {
      case BetStatus.won:
        return LedgerEntryType.betSettledWin;
      case BetStatus.lost:
        return LedgerEntryType.betSettledLoss;
      case BetStatus.voided:
        return LedgerEntryType.betSettledVoid;
      case BetStatus.cashedOut:
        return LedgerEntryType.betSettledCashout;
      case BetStatus.open:
        throw StateError('Aposta em aberto não possui tipo de liquidação.');
    }
  }

  String _statusLabel(BetStatus status) {
    switch (status) {
      case BetStatus.won:
        return 'Ganha';
      case BetStatus.lost:
        return 'Perdida';
      case BetStatus.voided:
        return 'Anulada';
      case BetStatus.cashedOut:
        return 'Cashout';
      case BetStatus.open:
        return 'Em aberto';
    }
  }
}
