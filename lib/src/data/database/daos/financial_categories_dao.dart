import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/financial_categories_table.dart';

part 'financial_categories_dao.g.dart';

@DriftAccessor(tables: [FinancialCategories])
class FinancialCategoriesDao extends DatabaseAccessor<AppDatabase> with _$FinancialCategoriesDaoMixin {
  FinancialCategoriesDao(super.db);

  Stream<List<FinancialCategoryRow>> watchAll({bool includeArchived = false}) {
    final query = select(financialCategories);
    if (!includeArchived) {
      query.where((t) => t.isArchived.equals(false));
    }
    query.orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.watch();
  }

  Future<List<FinancialCategoryRow>> getAll({bool includeArchived = true}) {
    final query = select(financialCategories);
    if (!includeArchived) {
      query.where((t) => t.isArchived.equals(false));
    }
    return query.get();
  }

  Future<FinancialCategoryRow?> getById(int id) {
    return (select(financialCategories)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertCategory(FinancialCategoriesCompanion entry) {
    return into(financialCategories).insert(entry);
  }

  Future<bool> updateCategory(FinancialCategoryRow row) {
    return update(financialCategories).replace(row);
  }

  Future<int> deleteCategory(int id) {
    return (delete(financialCategories)..where((t) => t.id.equals(id))).go();
  }
}
