import 'package:drift/drift.dart';
import 'accounts_table.dart';

@DataClassName('CreditCardRow')
class CreditCards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  TextColumn get issuerBank => text().nullable()();
  IntColumn get creditLimitCents => integer().withDefault(const Constant(0))();

  /// Dia do mês em que a fatura fecha (1-31).
  IntColumn get closingDay => integer()();

  /// Dia do mês em que a fatura vence (1-31).
  IntColumn get dueDay => integer()();

  /// Conta bancária padrão sugerida para pagar a fatura.
  IntColumn get defaultPaymentAccountId => integer().nullable().references(Accounts, #id)();

  IntColumn get colorValue => integer().withDefault(const Constant(0xFF7C3AED))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}
