import 'package:drift/drift.dart';
import '../../../domain/models/enums.dart';
import 'accounts_table.dart';

@DataClassName('MovementRow')
class Movements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => textEnum<MovementType>()();

  IntColumn get sourceAccountId => integer().nullable().references(Accounts, #id)();
  IntColumn get destinationAccountId => integer().nullable().references(Accounts, #id)();

  /// Valor principal movimentado, em centavos (sem contar a taxa).
  IntColumn get amountCents => integer()();

  /// Taxa cobrada na operação (ex: taxa de transferência), em centavos.
  IntColumn get feeCents => integer().withDefault(const Constant(0))();

  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get description => text().nullable()();

  /// Justificativa obrigatória para movimentações de ajuste.
  TextColumn get adjustmentReason => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
