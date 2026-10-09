import 'package:drift/drift.dart';
import '../../../domain/models/enums.dart';
import 'accounts_table.dart';
import 'bets_table.dart';
import 'movements_table.dart';
import 'cdb_yields_table.dart';

/// Lançamento atômico no extrato (ledger) de uma conta. Toda alteração de
/// saldo do app passa por esta tabela, o que garante que:
/// - nenhuma movimentação seja contabilizada duas vezes;
/// - toda transferência tenha débito e crédito correspondentes
///   (via [transferGroupId]);
/// - os saldos possam ser reconstruídos por data, permitindo que edições
///   retroativas corrijam automaticamente os gráficos históricos.
@DataClassName('LedgerEntryRow')
class LedgerEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountId => integer().references(Accounts, #id)();

  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get type => textEnum<LedgerEntryType>()();

  /// Valor com sinal: positivo credita a conta, negativo debita.
  IntColumn get amountCents => integer()();

  IntColumn get betId => integer().nullable().references(Bets, #id)();
  IntColumn get movementId => integer().nullable().references(Movements, #id)();
  IntColumn get cdbYieldId => integer().nullable().references(CdbYields, #id)();

  /// Agrupa as duas pontas (débito/crédito) de uma transferência.
  TextColumn get transferGroupId => text().nullable()();

  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}
