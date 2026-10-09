import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/credit_card_bills_table.dart';

part 'credit_card_bills_dao.g.dart';

@DriftAccessor(tables: [CreditCardBills])
class CreditCardBillsDao extends DatabaseAccessor<AppDatabase> with _$CreditCardBillsDaoMixin {
  CreditCardBillsDao(super.db);

  Future<List<CreditCardBillRow>> getForCard(int cardId) {
    return (select(creditCardBills)
          ..where((t) => t.cardId.equals(cardId))
          ..orderBy([(t) => OrderingTerm.desc(t.referenceYear), (t) => OrderingTerm.desc(t.referenceMonth)]))
        .get();
  }

  Future<List<CreditCardBillRow>> getAll() => select(creditCardBills).get();

  Future<CreditCardBillRow?> getById(int id) {
    return (select(creditCardBills)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<CreditCardBillRow?> findByCardAndMonth(int cardId, int year, int month) {
    return (select(creditCardBills)
          ..where((t) =>
              t.cardId.equals(cardId) & t.referenceYear.equals(year) & t.referenceMonth.equals(month)))
        .getSingleOrNull();
  }

  Future<int> insertBill(CreditCardBillsCompanion entry) {
    return into(creditCardBills).insert(entry);
  }
}
