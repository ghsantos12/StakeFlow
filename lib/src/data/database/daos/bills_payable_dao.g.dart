// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_payable_dao.dart';

// ignore_for_file: type=lint
mixin _$BillsPayableDaoMixin on DatabaseAccessor<AppDatabase> {
  $FinancialCategoriesTable get financialCategories =>
      attachedDatabase.financialCategories;
  $AccountsTable get accounts => attachedDatabase.accounts;
  $BillsPayableTable get billsPayable => attachedDatabase.billsPayable;
  BillsPayableDaoManager get managers => BillsPayableDaoManager(this);
}

class BillsPayableDaoManager {
  final _$BillsPayableDaoMixin _db;
  BillsPayableDaoManager(this._db);
  $$FinancialCategoriesTableTableManager get financialCategories =>
      $$FinancialCategoriesTableTableManager(
        _db.attachedDatabase,
        _db.financialCategories,
      );
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$BillsPayableTableTableManager get billsPayable =>
      $$BillsPayableTableTableManager(_db.attachedDatabase, _db.billsPayable);
}
