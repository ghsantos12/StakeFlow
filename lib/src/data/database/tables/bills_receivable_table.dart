import 'package:drift/drift.dart';
import '../../../domain/models/enums.dart';
import 'accounts_table.dart';
import 'financial_categories_table.dart';

/// Conta a receber — espelha [BillsPayable]. O valor já recebido é a soma
/// de `Movements.amountCents` onde `receivableId` aponta para esta linha.
@DataClassName('BillReceivableRow')
class BillsReceivable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  IntColumn get amountCents => integer()();
  IntColumn get categoryId => integer().nullable().references(FinancialCategories, #id)();
  IntColumn get accountId => integer().nullable().references(Accounts, #id)();

  DateTimeColumn get dueDate => dateTime()();
  TextColumn get notes => text().nullable()();
  BoolColumn get cancelled => boolean().withDefault(const Constant(false))();

  TextColumn get recurrenceFrequency => textEnum<RecurrenceFrequency>().nullable()();
  TextColumn get recurrenceGroupId => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
