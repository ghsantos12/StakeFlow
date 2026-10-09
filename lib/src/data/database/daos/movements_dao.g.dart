// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movements_dao.dart';

// ignore_for_file: type=lint
mixin _$MovementsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $FinancialCategoriesTable get financialCategories =>
      attachedDatabase.financialCategories;
  $BillsPayableTable get billsPayable => attachedDatabase.billsPayable;
  $BillsReceivableTable get billsReceivable => attachedDatabase.billsReceivable;
  $MovementsTable get movements => attachedDatabase.movements;
  MovementsDaoManager get managers => MovementsDaoManager(this);
}

class MovementsDaoManager {
  final _$MovementsDaoMixin _db;
  MovementsDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$FinancialCategoriesTableTableManager get financialCategories =>
      $$FinancialCategoriesTableTableManager(
        _db.attachedDatabase,
        _db.financialCategories,
      );
  $$BillsPayableTableTableManager get billsPayable =>
      $$BillsPayableTableTableManager(_db.attachedDatabase, _db.billsPayable);
  $$BillsReceivableTableTableManager get billsReceivable =>
      $$BillsReceivableTableTableManager(
        _db.attachedDatabase,
        _db.billsReceivable,
      );
  $$MovementsTableTableManager get movements =>
      $$MovementsTableTableManager(_db.attachedDatabase, _db.movements);
}
