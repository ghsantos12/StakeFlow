import 'package:drift/drift.dart';
import 'accounts_table.dart';
import 'credit_card_bills_table.dart';

/// Um pagamento (total ou parcial) de uma fatura. O valor já pago de uma
/// fatura é sempre a soma destes registros — nunca um campo em cache.
@DataClassName('CreditCardBillPaymentRow')
class CreditCardBillPayments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get billId => integer().references(CreditCardBills, #id)();
  IntColumn get accountId => integer().references(Accounts, #id)();

  IntColumn get amountCents => integer()();
  DateTimeColumn get paidAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
}
