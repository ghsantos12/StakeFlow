import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/ledger_entries_table.dart';

part 'ledger_dao.g.dart';

@DriftAccessor(tables: [LedgerEntries])
class LedgerDao extends DatabaseAccessor<AppDatabase> with _$LedgerDaoMixin {
  LedgerDao(super.db);

  /// Todos os lançamentos, ordenados cronologicamente. Usado para
  /// reconstruir saldos históricos dia a dia.
  Future<List<LedgerEntryRow>> getAllOrderedByDate() {
    return (select(ledgerEntries)
          ..orderBy([
            (t) => OrderingTerm.asc(t.occurredAt),
            (t) => OrderingTerm.asc(t.id),
          ]))
        .get();
  }

  Stream<List<LedgerEntryRow>> watchAllOrderedByDate() {
    return (select(ledgerEntries)
          ..orderBy([
            (t) => OrderingTerm.asc(t.occurredAt),
            (t) => OrderingTerm.asc(t.id),
          ]))
        .watch();
  }

  Future<List<LedgerEntryRow>> getForAccount(int accountId) {
    return (select(ledgerEntries)
          ..where((t) => t.accountId.equals(accountId))
          ..orderBy([(t) => OrderingTerm.asc(t.occurredAt)]))
        .get();
  }

  /// Saldo atual de uma conta = soma de todos os lançamentos do ledger.
  /// (O saldo inicial da conta é somado separadamente pelo chamador.)
  Future<int> sumForAccount(int accountId) async {
    final sumExp = ledgerEntries.amountCents.sum();
    final query = selectOnly(ledgerEntries)
      ..addColumns([sumExp])
      ..where(ledgerEntries.accountId.equals(accountId));
    final row = await query.getSingle();
    return row.read(sumExp) ?? 0;
  }

  Future<int> insertEntry(LedgerEntriesCompanion entry) {
    return into(ledgerEntries).insert(entry);
  }

  Future<void> insertEntries(List<LedgerEntriesCompanion> entries) async {
    await batch((b) {
      b.insertAll(ledgerEntries, entries);
    });
  }

  Future<int> deleteForBet(int betId) {
    return (delete(ledgerEntries)..where((t) => t.betId.equals(betId))).go();
  }

  Future<int> deleteForMovement(int movementId) {
    return (delete(ledgerEntries)..where((t) => t.movementId.equals(movementId))).go();
  }

  Future<int> deleteForCdbYield(int cdbYieldId) {
    return (delete(ledgerEntries)..where((t) => t.cdbYieldId.equals(cdbYieldId))).go();
  }

  Future<int> deleteForAccount(int accountId) {
    return (delete(ledgerEntries)..where((t) => t.accountId.equals(accountId))).go();
  }
}
