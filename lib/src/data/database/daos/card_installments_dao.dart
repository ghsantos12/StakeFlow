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
    return (select(cardInstallments)
          ..where((t) => t.billId.equals(billId))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Stream<List<CardInstallmentRow>> watchForBill(int billId) {
    return (select(cardInstallments)
          ..where((t) => t.billId.equals(billId))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .watch();
  }

  Future<CardInstallmentRow?> getById(int id) {
    return (select(cardInstallments)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<CardInstallmentRow>> getAll() => select(cardInstallments).get();

  Future<void> insertInstallments(List<CardInstallmentsCompanion> entries) async {
    await batch((b) => b.insertAll(cardInstallments, entries));
  }

  Future<bool> updateInstallment(CardInstallmentRow row) {
    return update(cardInstallments).replace(row);
  }

  Future<int> deleteForTransaction(int cardTransactionId) {
    return (delete(cardInstallments)..where((t) => t.cardTransactionId.equals(cardTransactionId))).go();
  }

  Future<int> deleteOne(int installmentId) {
    return (delete(cardInstallments)..where((t) => t.id.equals(installmentId))).go();
  }
}
