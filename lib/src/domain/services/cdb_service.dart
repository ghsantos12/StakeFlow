import 'dart:math' as math;
import 'package:drift/drift.dart';
import '../../data/database/database.dart';
import '../models/enums.dart';
import '../models/exceptions.dart';

/// Gerencia os rendimentos de CDB efetivamente creditados na conta
/// bancária. Cada rendimento lançado aqui é um fato consumado (o banco já
/// creditou o valor), diferente das estimativas de [CdbEstimationService],
/// que são apenas informativas e nunca tocam o saldo real.
// `yield` é palavra reservada dentro de corpos de função async/generator,
// então o valor do enum precisa ser capturado aqui fora para ser usado
// dentro dos métodos async de [CdbYieldService].
const MovementType _yieldMovementType = MovementType.yield;

class CdbYieldService {
  CdbYieldService(this._db);
  final AppDatabase _db;

  Stream<List<CdbYieldRow>> watchForAccount(int accountId) =>
      _db.cdbYieldsDao.watchAllForAccount(accountId);

  Future<List<CdbYieldRow>> getAllForAccount(int accountId) =>
      _db.cdbYieldsDao.getAllForAccount(accountId);

  Future<List<CdbYieldRow>> getAll() => _db.cdbYieldsDao.getAll();

  Future<int> addYield({
    required int accountId,
    required DateTime date,
    required int amountCents,
    String? description,
  }) async {
    if (amountCents <= 0) {
      throw ValidationException('O valor do rendimento deve ser maior que zero.');
    }
    final account = await _db.accountsDao.getById(accountId);
    if (account == null) throw ValidationException('Conta não encontrada.');
    if (account.type != AccountType.bank) {
      throw ValidationException('Rendimentos de CDB só podem ser lançados em contas bancárias.');
    }

    return _db.transaction<int>(() async {
      final now = DateTime.now();
      final id = await _db.cdbYieldsDao.insertYield(CdbYieldsCompanion.insert(
        accountId: accountId,
        date: date,
        amountCents: amountCents,
        description: Value(description),
        createdAt: now,
      ));
      // Também gera uma Movement (tipo yield) ligada ao mesmo lançamento do
      // ledger, para que este mesmo rendimento apareça como receita no
      // extrato/relatórios do módulo financeiro — sem duplicar o efeito no
      // saldo, já que há só um lançamento no ledger (vinculado a ambos os
      // registros).
      final movementId = await _db.movementsDao.insertMovement(MovementsCompanion.insert(
        type: _yieldMovementType,
        destinationAccountId: Value(accountId),
        amountCents: amountCents,
        occurredAt: date,
        description: Value(description ?? 'Rendimento CDB'),
        createdAt: now,
        updatedAt: now,
      ));
      await _db.ledgerDao.insertEntry(LedgerEntriesCompanion.insert(
        accountId: accountId,
        occurredAt: date,
        type: LedgerEntryType.cdbYield,
        amountCents: amountCents,
        movementId: Value(movementId),
        cdbYieldId: Value(id),
        description: Value(description ?? 'Rendimento CDB'),
        createdAt: now,
      ));
      return id;
    });
  }

  Future<void> deleteYield(int id) async {
    await _db.transaction(() async {
      final entries = await _db.ledgerDao.getForCdbYield(id);
      final movementId = entries.where((e) => e.movementId != null).firstOrNull?.movementId;
      await _db.ledgerDao.deleteForCdbYield(id);
      await _db.cdbYieldsDao.deleteYield(id);
      if (movementId != null) await _db.movementsDao.deleteMovement(movementId);
    });
  }
}

/// Estimativa de rendimento diário de CDB, puramente informativa — nunca
/// altera o saldo real. Considera apenas dias úteis (segunda a sexta,
/// sem calendário de feriados, já que o app funciona 100% offline) e o
/// percentual do CDI configurado na conta sobre a taxa anual do CDI
/// informada pelo usuário nas configurações.
class CdbEstimationService {
  CdbEstimationService();

  static const int businessDaysPerYear = 252;

  bool isBusinessDay(DateTime day) {
    return day.weekday != DateTime.saturday && day.weekday != DateTime.sunday;
  }

  /// Fator de rendimento diário equivalente à taxa anual do CDI composta
  /// em [businessDaysPerYear] dias úteis.
  double dailyCdiFactor(double annualCdiRatePercent) {
    final annualRate = annualCdiRatePercent / 100;
    return math.pow(1 + annualRate, 1 / businessDaysPerYear).toDouble() - 1;
  }

  /// Estimativa do rendimento de um dia (em centavos), dado o saldo
  /// atual da conta e o percentual do CDI contratado nessa conta.
  int estimateDailyYieldCents({
    required int currentBalanceCents,
    required double annualCdiRatePercent,
    required double accountCdiPercent,
    required DateTime day,
  }) {
    if (!isBusinessDay(day)) return 0;
    final factor = dailyCdiFactor(annualCdiRatePercent) * (accountCdiPercent / 100);
    return (currentBalanceCents * factor).round();
  }
}
