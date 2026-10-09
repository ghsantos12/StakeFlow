import 'package:drift/drift.dart';
import 'card_transactions_table.dart';
import 'credit_card_bills_table.dart';

@DataClassName('CardInstallmentRow')
class CardInstallments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardTransactionId => integer().references(CardTransactions, #id)();
  IntColumn get billId => integer().references(CreditCardBills, #id)();

  IntColumn get installmentNumber => integer()();
  IntColumn get totalInstallments => integer()();

  /// Valor desta parcela específica (a última parcela absorve o
  /// arredondamento para que a soma bata exatamente com o total da compra).
  IntColumn get amountCents => integer()();

  DateTimeColumn get createdAt => dateTime()();
}
