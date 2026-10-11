import 'package:drift/drift.dart';
import '../../../domain/models/enums.dart';

@DataClassName('AccountRow')
class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  TextColumn get type => textEnum<AccountType>()();
  TextColumn get institution => text().nullable()();
  IntColumn get initialBalanceCents => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  // Campos específicos de conta bancária com rendimento de CDB.
  RealColumn get cdiPercent => real().nullable()();
  TextColumn get cdbAccountingType => textEnum<CdbAccountingType>().nullable()();
  DateTimeColumn get cdbTrackingStartDate => dateTime().nullable()();
  IntColumn get cdbAccumulatedBeforeTrackingCents => integer().withDefault(const Constant(0))();

  /// Subtipo de conta bancária (corrente, poupança, dinheiro em espécie...)
  /// usado pelo módulo de gestão financeira pessoal. Nulo para contas
  /// criadas antes da existência desse módulo ou para casas de apostas.
  TextColumn get bankAccountKind => textEnum<BankAccountKind>().nullable()();

  /// Cor de identificação visual da conta (módulo financeiro).
  IntColumn get colorValue => integer().nullable()();

  /// Marca uma conta bancária como exclusiva para o dinheiro de apostas:
  /// ela (e suas movimentações) ficam fora do dashboard/extrato/previsão/
  /// relatórios do módulo financeiro, igual às casas de apostas — só
  /// aparecem lá quando o dinheiro é transferido para outra conta bancária
  /// que não tenha esta marcação. Sem efeito em contas de casa de apostas.
  BoolColumn get bettingFundsOnly => boolean().withDefault(const Constant(false))();
}
