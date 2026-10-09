import 'package:drift/drift.dart';
import '../../../domain/models/enums.dart';
import 'accounts_table.dart';
import 'financial_categories_table.dart';
import 'bills_payable_table.dart';
import 'bills_receivable_table.dart';

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

  // Campos do módulo de gestão financeira pessoal.
  IntColumn get categoryId => integer().nullable().references(FinancialCategories, #id)();
  BoolColumn get reconciled => boolean().withDefault(const Constant(false))();

  /// Preenchido quando esta movimentação é a baixa (total ou parcial) de
  /// uma conta a pagar — o valor já pago de uma conta a pagar é sempre a
  /// soma de `amountCents` das movimentações com este vínculo.
  IntColumn get payableId => integer().nullable().references(BillsPayable, #id)();

  /// Idem para contas a receber.
  IntColumn get receivableId => integer().nullable().references(BillsReceivable, #id)();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
