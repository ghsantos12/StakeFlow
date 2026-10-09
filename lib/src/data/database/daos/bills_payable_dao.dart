import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/bills_payable_table.dart';

part 'bills_payable_dao.g.dart';

@DriftAccessor(tables: [BillsPayable])
class BillsPayableDao extends DatabaseAccessor<AppDatabase> with _$BillsPayableDaoMixin {
  BillsPayableDao(super.db);

  Stream<List<BillPayableRow>> watchAll() {
    return (select(billsPayable)
          ..where((t) => t.cancelled.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.dueDate)]))
        .watch();
  }

  Future<List<BillPayableRow>> getAll() => select(billsPayable).get();

  Future<BillPayableRow?> getById(int id) {
    return (select(billsPayable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertBill(BillsPayableCompanion entry) {
    return into(billsPayable).insert(entry);
  }

  Future<bool> updateBill(BillPayableRow row) {
    return update(billsPayable).replace(row);
  }

  Future<int> deleteBill(int id) {
    return (delete(billsPayable)..where((t) => t.id.equals(id))).go();
  }
}
