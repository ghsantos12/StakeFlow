import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/cdb_yields_table.dart';

part 'cdb_yields_dao.g.dart';

@DriftAccessor(tables: [CdbYields])
class CdbYieldsDao extends DatabaseAccessor<AppDatabase> with _$CdbYieldsDaoMixin {
  CdbYieldsDao(super.db);

  Stream<List<CdbYieldRow>> watchAllForAccount(int accountId) {
    return (select(cdbYields)
          ..where((t) => t.accountId.equals(accountId))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  Future<List<CdbYieldRow>> getAllForAccount(int accountId) {
    return (select(cdbYields)
          ..where((t) => t.accountId.equals(accountId))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }

  Future<List<CdbYieldRow>> getAll() {
    return (select(cdbYields)..orderBy([(t) => OrderingTerm.desc(t.date)])).get();
  }

  Future<int> insertYield(CdbYieldsCompanion entry) {
    return into(cdbYields).insert(entry);
  }

  Future<int> deleteYield(int id) {
    return (delete(cdbYields)..where((t) => t.id.equals(id))).go();
  }
}
