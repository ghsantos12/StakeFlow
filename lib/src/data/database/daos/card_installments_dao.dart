import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/card_installments_table.dart';

part 'card_installments_dao.g.dart';

@DriftAccessor(tables: [CardInstallments])
class CardInstallmentsDao extends DatabaseAccessor<AppDatabase> with _$CardInstallmentsDaoMixin {
  CardInstallmentsDao(super.db);

  Future<List<CardInstallmentRow>> getForTransaction(int cardTransactionId) {
    return (select(cardInstallments)..where((t) => t.cardTransactionId.equals(cardTransactionId))).get();
  }

  Future<List<CardInstallmentRow>> getForBill(int billId) {
    return (select(cardInstallments)..where((t) => t.billId.equals(billId))).get();
  }

  Future<List<CardInstallmentRow>> getAll() => select(cardInstallments).get();

  Future<void> insertInstallments(List<CardInstallmentsCompanion> entries) async {
    await batch((b) => b.insertAll(cardInstallments, entries));
  }

  Future<int> deleteForTransaction(int cardTransactionId) {
    return (delete(cardInstallments)..where((t) => t.cardTransactionId.equals(cardTransactionId))).go();
  }
}
