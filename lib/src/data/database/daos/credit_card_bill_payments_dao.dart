import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/credit_card_bill_payments_table.dart';

part 'credit_card_bill_payments_dao.g.dart';

@DriftAccessor(tables: [CreditCardBillPayments])
class CreditCardBillPaymentsDao extends DatabaseAccessor<AppDatabase>
    with _$CreditCardBillPaymentsDaoMixin {
  CreditCardBillPaymentsDao(super.db);

  Future<List<CreditCardBillPaymentRow>> getForBill(int billId) {
    return (select(creditCardBillPayments)..where((t) => t.billId.equals(billId))).get();
  }

  Future<int> insertPayment(CreditCardBillPaymentsCompanion entry) {
    return into(creditCardBillPayments).insert(entry);
  }

  Future<int> deleteForBill(int billId) {
    return (delete(creditCardBillPayments)..where((t) => t.billId.equals(billId))).go();
  }
}
