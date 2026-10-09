// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_installments_dao.dart';

// ignore_for_file: type=lint
mixin _$CardInstallmentsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $CreditCardsTable get creditCards => attachedDatabase.creditCards;
  $FinancialCategoriesTable get financialCategories =>
      attachedDatabase.financialCategories;
  $CardTransactionsTable get cardTransactions =>
      attachedDatabase.cardTransactions;
  $CreditCardBillsTable get creditCardBills => attachedDatabase.creditCardBills;
  $CardInstallmentsTable get cardInstallments =>
      attachedDatabase.cardInstallments;
  CardInstallmentsDaoManager get managers => CardInstallmentsDaoManager(this);
}

class CardInstallmentsDaoManager {
  final _$CardInstallmentsDaoMixin _db;
  CardInstallmentsDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$CreditCardsTableTableManager get creditCards =>
      $$CreditCardsTableTableManager(_db.attachedDatabase, _db.creditCards);
  $$FinancialCategoriesTableTableManager get financialCategories =>
      $$FinancialCategoriesTableTableManager(
        _db.attachedDatabase,
        _db.financialCategories,
      );
  $$CardTransactionsTableTableManager get cardTransactions =>
      $$CardTransactionsTableTableManager(
        _db.attachedDatabase,
        _db.cardTransactions,
      );
  $$CreditCardBillsTableTableManager get creditCardBills =>
      $$CreditCardBillsTableTableManager(
        _db.attachedDatabase,
        _db.creditCardBills,
      );
  $$CardInstallmentsTableTableManager get cardInstallments =>
      $$CardInstallmentsTableTableManager(
        _db.attachedDatabase,
        _db.cardInstallments,
      );
}
