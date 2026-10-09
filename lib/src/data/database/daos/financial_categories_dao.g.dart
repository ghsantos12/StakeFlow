// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_categories_dao.dart';

// ignore_for_file: type=lint
mixin _$FinancialCategoriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FinancialCategoriesTable get financialCategories =>
      attachedDatabase.financialCategories;
  FinancialCategoriesDaoManager get managers =>
      FinancialCategoriesDaoManager(this);
}

class FinancialCategoriesDaoManager {
  final _$FinancialCategoriesDaoMixin _db;
  FinancialCategoriesDaoManager(this._db);
  $$FinancialCategoriesTableTableManager get financialCategories =>
      $$FinancialCategoriesTableTableManager(
        _db.attachedDatabase,
        _db.financialCategories,
      );
}
