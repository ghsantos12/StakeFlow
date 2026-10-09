import 'package:drift/drift.dart';
import 'accounts_table.dart';

@DataClassName('CdbYieldRow')
class CdbYields extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountId => integer().references(Accounts, #id)();

  DateTimeColumn get date => dateTime()();
  IntColumn get amountCents => integer()();
  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
}
