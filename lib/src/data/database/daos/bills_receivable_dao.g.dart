// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_receivable_dao.dart';

// ignore_for_file: type=lint
mixin _$BillsReceivableDaoMixin on DatabaseAccessor<AppDatabase> {
  $FinancialCategoriesTable get financialCategories =>
      attachedDatabase.financialCategories;
  $AccountsTable get accounts => attachedDatabase.accounts;
  $BillsReceivableTable get billsReceivable => attachedDatabase.billsReceivable;
  BillsReceivableDaoManager get managers => BillsReceivableDaoManager(this);
}

class BillsReceivableDaoManager {
  final _$BillsReceivableDaoMixin _db;
  BillsReceivableDaoManager(this._db);
  $$FinancialCategoriesTableTableManager get financialCategories =>
      $$FinancialCategoriesTableTableManager(
        _db.attachedDatabase,
        _db.financialCategories,
      );
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$BillsReceivableTableTableManager get billsReceivable =>
      $$BillsReceivableTableTableManager(
        _db.attachedDatabase,
        _db.billsReceivable,
      );
}
