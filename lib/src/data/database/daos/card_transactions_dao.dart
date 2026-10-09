import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/card_transactions_table.dart';

part 'card_transactions_dao.g.dart';

@DriftAccessor(tables: [CardTransactions])
class CardTransactionsDao extends DatabaseAccessor<AppDatabase> with _$CardTransactionsDaoMixin {
  CardTransactionsDao(super.db);

  Stream<List<CardTransactionRow>> watchForCard(int cardId) {
    return (select(cardTransactions)
          ..where((t) => t.cardId.equals(cardId))
          ..orderBy([(t) => OrderingTerm.desc(t.purchaseDate)]))
        .watch();
  }

  Future<List<CardTransactionRow>> getAll() => select(cardTransactions).get();

  Future<CardTransactionRow?> getById(int id) {
    return (select(cardTransactions)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertTransaction(CardTransactionsCompanion entry) {
    return into(cardTransactions).insert(entry);
  }

  Future<int> deleteTransaction(int id) {
    return (delete(cardTransactions)..where((t) => t.id.equals(id))).go();
  }
}
