import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/accounts_table.dart';

part 'accounts_dao.g.dart';

@DriftAccessor(tables: [Accounts])
class AccountsDao extends DatabaseAccessor<AppDatabase> with _$AccountsDaoMixin {
  AccountsDao(super.db);

  Stream<List<AccountRow>> watchAll({bool includeArchived = false}) {
    final query = select(accounts);
    if (!includeArchived) {
      query.where((t) => t.isArchived.equals(false));
    }
    query.orderBy([(t) => OrderingTerm.asc(t.id)]);
    return query.watch();
  }

  Future<List<AccountRow>> getAll({bool includeArchived = false}) {
    final query = select(accounts);
    if (!includeArchived) {
      query.where((t) => t.isArchived.equals(false));
    }
    return query.get();
  }

  Future<AccountRow?> getById(int id) {
    return (select(accounts)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Stream<AccountRow?> watchById(int id) {
    return (select(accounts)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Future<int> insertAccount(AccountsCompanion entry) {
    return into(accounts).insert(entry);
  }

  Future<bool> updateAccount(AccountRow row) {
    return update(accounts).replace(row);
  }

  Future<int> deleteAccount(int id) {
    return (delete(accounts)..where((t) => t.id.equals(id))).go();
  }
}
