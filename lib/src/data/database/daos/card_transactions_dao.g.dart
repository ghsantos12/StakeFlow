// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_transactions_dao.dart';

// ignore_for_file: type=lint
mixin _$CardTransactionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $CreditCardsTable get creditCards => attachedDatabase.creditCards;
  $FinancialCategoriesTable get financialCategories =>
      attachedDatabase.financialCategories;
  $CardTransactionsTable get cardTransactions =>
      attachedDatabase.cardTransactions;
  CardTransactionsDaoManager get managers => CardTransactionsDaoManager(this);
}

class CardTransactionsDaoManager {
  final _$CardTransactionsDaoMixin _db;
  CardTransactionsDaoManager(this._db);
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
}
