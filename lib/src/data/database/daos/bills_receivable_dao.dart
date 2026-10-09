import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/bills_receivable_table.dart';

part 'bills_receivable_dao.g.dart';

@DriftAccessor(tables: [BillsReceivable])
class BillsReceivableDao extends DatabaseAccessor<AppDatabase> with _$BillsReceivableDaoMixin {
  BillsReceivableDao(super.db);

  Stream<List<BillReceivableRow>> watchAll() {
    return (select(billsReceivable)
          ..where((t) => t.cancelled.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.dueDate)]))
        .watch();
  }

  Future<List<BillReceivableRow>> getAll() => select(billsReceivable).get();

  Future<BillReceivableRow?> getById(int id) {
    return (select(billsReceivable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertBill(BillsReceivableCompanion entry) {
    return into(billsReceivable).insert(entry);
  }

  Future<bool> updateBill(BillReceivableRow row) {
    return update(billsReceivable).replace(row);
  }

  Future<int> deleteBill(int id) {
    return (delete(billsReceivable)..where((t) => t.id.equals(id))).go();
  }
}
