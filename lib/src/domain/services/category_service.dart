import 'package:drift/drift.dart';
import '../../data/database/database.dart';
import '../models/enums.dart';
import '../models/exceptions.dart';

/// Ícones padrão (Material) para as categorias pré-cadastradas, por nome.
const Map<String, int> _defaultIcons = {
  'Alimentação': 0xe56c, // restaurant
  'Mercado': 0xe8cc, // shopping_cart
  'Transporte': 0xe531, // directions_car
  'Moradia': 0xe88a, // home
  'Saúde': 0xe3f3, // local_hospital
  'Educação': 0xe80c, // school
  'Lazer': 0xea26, // sports_esports (placeholder)
  'Assinaturas': 0xe02f, // subscriptions-ish (placeholder)
  'Compras': 0xe59c, // shopping_bag (placeholder)
  'Contas domésticas': 0xe0b0, // receipt
  'Impostos': 0xe263, // account_balance
  'Outros': 0xe8b8, // settings/category fallback
  'Salário': 0xe227, // payments
  'Freelance': 0xe943, // work
  'Reembolsos': 0xe8d1, // replay
  'Rendimentos': 0xe1bb, // savings
  'Outras receitas': 0xe8b8,
};

class CategoryService {
  CategoryService(this._db);
  final AppDatabase _db;

  Stream<List<FinancialCategoryRow>> watchAll({bool includeArchived = false}) {
    return _db.financialCategoriesDao.watchAll(includeArchived: includeArchived);
  }

  Future<List<FinancialCategoryRow>> getAll({bool includeArchived = true}) {
    return _db.financialCategoriesDao.getAll(includeArchived: includeArchived);
  }

  Future<FinancialCategoryRow?> getById(int id) => _db.financialCategoriesDao.getById(id);

  /// Cria as categorias padrão na primeira vez que o módulo financeiro é
  /// aberto (se ainda não houver nenhuma categoria cadastrada).
  Future<void> ensureDefaultCategories() async {
    final existing = await _db.financialCategoriesDao.getAll();
    if (existing.isNotEmpty) return;

    final now = DateTime.now();
    for (final name in kDefaultExpenseCategories) {
      await _db.financialCategoriesDao.insertCategory(FinancialCategoriesCompanion.insert(
        name: name,
        kind: CategoryKind.expense,
        iconCodePoint: Value(_defaultIcons[name] ?? 0xe8b8),
        createdAt: now,
      ));
    }
    for (final name in kDefaultIncomeCategories) {
      await _db.financialCategoriesDao.insertCategory(FinancialCategoriesCompanion.insert(
        name: name,
        kind: CategoryKind.income,
        iconCodePoint: Value(_defaultIcons[name] ?? 0xe8b8),
        createdAt: now,
      ));
    }
  }

  Future<int> createCategory({
    required String name,
    required CategoryKind kind,
    int? parentCategoryId,
    int iconCodePoint = 0xe8b8,
    int colorValue = 0xFF2563EB,
  }) {
    if (name.trim().isEmpty) throw ValidationException('Informe um nome para a categoria.');
    return _db.financialCategoriesDao.insertCategory(FinancialCategoriesCompanion.insert(
      name: name.trim(),
      kind: kind,
      parentCategoryId: Value(parentCategoryId),
      iconCodePoint: Value(iconCodePoint),
      colorValue: Value(colorValue),
      createdAt: DateTime.now(),
    ));
  }

  Future<void> updateCategory(FinancialCategoryRow row) async {
    if (row.name.trim().isEmpty) throw ValidationException('Informe um nome para a categoria.');
    await _db.financialCategoriesDao.updateCategory(row);
  }

  Future<void> archiveCategory(int id) async {
    final row = await getById(id);
    if (row == null) return;
    await _db.financialCategoriesDao.updateCategory(row.copyWith(isArchived: true));
  }
}
