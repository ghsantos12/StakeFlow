import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/credit_cards_table.dart';

part 'credit_cards_dao.g.dart';

@DriftAccessor(tables: [CreditCards])
class CreditCardsDao extends DatabaseAccessor<AppDatabase> with _$CreditCardsDaoMixin {
  CreditCardsDao(super.db);

  Stream<List<CreditCardRow>> watchAll({bool includeArchived = false}) {
    final query = select(creditCards);
    if (!includeArchived) {
      query.where((t) => t.isArchived.equals(false));
    }
    query.orderBy([(t) => OrderingTerm.asc(t.id)]);
    return query.watch();
  }

  Future<List<CreditCardRow>> getAll({bool includeArchived = false}) {
    final query = select(creditCards);
    if (!includeArchived) {
      query.where((t) => t.isArchived.equals(false));
    }
    return query.get();
  }

  Future<CreditCardRow?> getById(int id) {
    return (select(creditCards)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Stream<CreditCardRow?> watchById(int id) {
    return (select(creditCards)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Future<int> insertCard(CreditCardsCompanion entry) {
    return into(creditCards).insert(entry);
  }

  Future<bool> updateCard(CreditCardRow row) {
    return update(creditCards).replace(row);
  }

  Future<int> deleteCard(int id) {
    return (delete(creditCards)..where((t) => t.id.equals(id))).go();
  }
}
