import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/bets_table.dart';
import '../../../domain/models/enums.dart';

part 'bets_dao.g.dart';

@DriftAccessor(tables: [Bets])
class BetsDao extends DatabaseAccessor<AppDatabase> with _$BetsDaoMixin {
  BetsDao(super.db);

  Stream<List<BetRow>> watchAll() {
    return (select(bets)..orderBy([(t) => OrderingTerm.desc(t.placedAt)])).watch();
  }

  Future<List<BetRow>> getAll() {
    return (select(bets)..orderBy([(t) => OrderingTerm.desc(t.placedAt)])).get();
  }

  Future<BetRow?> getById(int id) {
    return (select(bets)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Stream<BetRow?> watchById(int id) {
    return (select(bets)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Future<List<BetRow>> getOpenBetsForAccount(int accountId) {
    return (select(bets)
          ..where((t) => t.accountId.equals(accountId) & t.status.equalsValue(BetStatus.open)))
        .get();
  }

  Stream<List<BetRow>> watchOpenBetsForAccount(int accountId) {
    return (select(bets)
          ..where((t) => t.accountId.equals(accountId) & t.status.equalsValue(BetStatus.open)))
        .watch();
  }

  Future<int> insertBet(BetsCompanion entry) {
    return into(bets).insert(entry);
  }

  Future<bool> updateBet(BetRow row) {
    return update(bets).replace(row);
  }

  Future<int> deleteBet(int id) {
    return (delete(bets)..where((t) => t.id.equals(id))).go();
  }
}
