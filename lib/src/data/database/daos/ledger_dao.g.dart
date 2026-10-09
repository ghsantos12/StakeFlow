// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_dao.dart';

// ignore_for_file: type=lint
mixin _$LedgerDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $BetsTable get bets => attachedDatabase.bets;
  $FinancialCategoriesTable get financialCategories =>
      attachedDatabase.financialCategories;
  $BillsPayableTable get billsPayable => attachedDatabase.billsPayable;
  $BillsReceivableTable get billsReceivable => attachedDatabase.billsReceivable;
  $MovementsTable get movements => attachedDatabase.movements;
  $CdbYieldsTable get cdbYields => attachedDatabase.cdbYields;
  $CreditCardsTable get creditCards => attachedDatabase.creditCards;
  $CreditCardBillsTable get creditCardBills => attachedDatabase.creditCardBills;
  $CreditCardBillPaymentsTable get creditCardBillPayments =>
      attachedDatabase.creditCardBillPayments;
  $LedgerEntriesTable get ledgerEntries => attachedDatabase.ledgerEntries;
  LedgerDaoManager get managers => LedgerDaoManager(this);
}

class LedgerDaoManager {
  final _$LedgerDaoMixin _db;
  LedgerDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$BetsTableTableManager get bets =>
      $$BetsTableTableManager(_db.attachedDatabase, _db.bets);
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
  $$CdbYieldsTableTableManager get cdbYields =>
      $$CdbYieldsTableTableManager(_db.attachedDatabase, _db.cdbYields);
  $$CreditCardsTableTableManager get creditCards =>
      $$CreditCardsTableTableManager(_db.attachedDatabase, _db.creditCards);
  $$CreditCardBillsTableTableManager get creditCardBills =>
      $$CreditCardBillsTableTableManager(
        _db.attachedDatabase,
        _db.creditCardBills,
      );
  $$CreditCardBillPaymentsTableTableManager get creditCardBillPayments =>
      $$CreditCardBillPaymentsTableTableManager(
        _db.attachedDatabase,
        _db.creditCardBillPayments,
      );
  $$LedgerEntriesTableTableManager get ledgerEntries =>
      $$LedgerEntriesTableTableManager(_db.attachedDatabase, _db.ledgerEntries);
}
