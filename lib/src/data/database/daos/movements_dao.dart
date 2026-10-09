import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/movements_table.dart';

part 'movements_dao.g.dart';

@DriftAccessor(tables: [Movements])
class MovementsDao extends DatabaseAccessor<AppDatabase> with _$MovementsDaoMixin {
  MovementsDao(super.db);

  Stream<List<MovementRow>> watchAll() {
    return (select(movements)..orderBy([(t) => OrderingTerm.desc(t.occurredAt)])).watch();
  }

  Future<List<MovementRow>> getAll() {
    return (select(movements)..orderBy([(t) => OrderingTerm.desc(t.occurredAt)])).get();
  }

  Future<MovementRow?> getById(int id) {
    return (select(movements)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertMovement(MovementsCompanion entry) {
    return into(movements).insert(entry);
  }

  Future<bool> updateMovement(MovementRow row) {
    return update(movements).replace(row);
  }

  Future<int> deleteMovement(int id) {
    return (delete(movements)..where((t) => t.id.equals(id))).go();
  }
}
