// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_bill_payments_dao.dart';

// ignore_for_file: type=lint
mixin _$CreditCardBillPaymentsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $CreditCardsTable get creditCards => attachedDatabase.creditCards;
  $CreditCardBillsTable get creditCardBills => attachedDatabase.creditCardBills;
  $CreditCardBillPaymentsTable get creditCardBillPayments =>
      attachedDatabase.creditCardBillPayments;
  CreditCardBillPaymentsDaoManager get managers =>
      CreditCardBillPaymentsDaoManager(this);
}

class CreditCardBillPaymentsDaoManager {
  final _$CreditCardBillPaymentsDaoMixin _db;
  CreditCardBillPaymentsDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
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
}
