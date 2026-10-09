import 'package:drift/drift.dart';
import '../../../domain/models/enums.dart';
import 'accounts_table.dart';
import 'financial_categories_table.dart';

/// Conta a pagar. O valor já pago é sempre a soma de
/// `Movements.amountCents` onde `payableId` aponta para esta linha — assim
/// como em [CreditCardBillPayments], nunca um total em cache.
/// Recorrências são materializadas como várias linhas desta tabela
/// compartilhando o mesmo [recurrenceGroupId], geradas de uma vez na
/// criação (sem job em segundo plano).
@DataClassName('BillPayableRow')
class BillsPayable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  IntColumn get amountCents => integer()();
  IntColumn get categoryId => integer().nullable().references(FinancialCategories, #id)();
  IntColumn get accountId => integer().nullable().references(Accounts, #id)();

  DateTimeColumn get dueDate => dateTime()();
  DateTimeColumn get competenceDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get cancelled => boolean().withDefault(const Constant(false))();

  TextColumn get recurrenceFrequency => textEnum<RecurrenceFrequency>().nullable()();
  TextColumn get recurrenceGroupId => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
