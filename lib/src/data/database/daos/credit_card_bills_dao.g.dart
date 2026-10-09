// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_bills_dao.dart';

// ignore_for_file: type=lint
mixin _$CreditCardBillsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $CreditCardsTable get creditCards => attachedDatabase.creditCards;
  $CreditCardBillsTable get creditCardBills => attachedDatabase.creditCardBills;
  CreditCardBillsDaoManager get managers => CreditCardBillsDaoManager(this);
}

class CreditCardBillsDaoManager {
  final _$CreditCardBillsDaoMixin _db;
  CreditCardBillsDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$CreditCardsTableTableManager get creditCards =>
      $$CreditCardsTableTableManager(_db.attachedDatabase, _db.creditCards);
  $$CreditCardBillsTableTableManager get creditCardBills =>
      $$CreditCardBillsTableTableManager(
        _db.attachedDatabase,
        _db.creditCardBills,
      );
}
