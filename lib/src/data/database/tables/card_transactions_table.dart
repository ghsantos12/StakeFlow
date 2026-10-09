import 'package:drift/drift.dart';
import '../../../domain/models/enums.dart';
import 'credit_cards_table.dart';
import 'financial_categories_table.dart';

/// Um lançamento no cartão (compra, estorno, ajuste ou encargo). Quando
/// parcelado, gera N linhas em [CardInstallments] — esta tabela guarda só
/// os dados da compra em si.
@DataClassName('CardTransactionRow')
class CardTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId => integer().references(CreditCards, #id)();

  TextColumn get type => textEnum<CardTransactionType>()();
  TextColumn get description => text()();
  IntColumn get totalAmountCents => integer()();
  DateTimeColumn get purchaseDate => dateTime()();
  IntColumn get categoryId => integer().nullable().references(FinancialCategories, #id)();
  IntColumn get installmentsCount => integer().withDefault(const Constant(1))();
  BoolColumn get isRecurring => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
