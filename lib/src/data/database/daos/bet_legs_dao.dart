import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/bet_legs_table.dart';

part 'bet_legs_dao.g.dart';

@DriftAccessor(tables: [BetLegs])
class BetLegsDao extends DatabaseAccessor<AppDatabase> with _$BetLegsDaoMixin {
  BetLegsDao(super.db);

  Future<List<BetLegRow>> getForBet(int betId) {
    return (select(betLegs)
          ..where((t) => t.betId.equals(betId))
          ..orderBy([(t) => OrderingTerm.asc(t.position)]))
        .get();
  }

  Stream<List<BetLegRow>> watchForBet(int betId) {
    return (select(betLegs)
          ..where((t) => t.betId.equals(betId))
          ..orderBy([(t) => OrderingTerm.asc(t.position)]))
        .watch();
  }

  Future<void> insertLegs(List<BetLegsCompanion> legs) async {
    await batch((b) => b.insertAll(betLegs, legs));
  }

  Future<int> deleteForBet(int betId) {
    return (delete(betLegs)..where((t) => t.betId.equals(betId))).go();
  }
}
