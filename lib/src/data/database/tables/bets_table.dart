import 'package:drift/drift.dart';
import '../../../domain/models/enums.dart';
import 'accounts_table.dart';

@DataClassName('BetRow')
class Bets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountId => integer().references(Accounts, #id)();

  DateTimeColumn get placedAt => dateTime()();
  DateTimeColumn get settledAt => dateTime().nullable()();

  TextColumn get sport => text()();
  TextColumn get event => text()();
  TextColumn get market => text()();
  TextColumn get selection => text()();

  IntColumn get stakeCents => integer()();
  IntColumn get oddsScaled => integer()();

  TextColumn get status => textEnum<BetStatus>()();

  /// Valor efetivamente recebido em caso de cashout (em centavos).
  IntColumn get cashoutCents => integer().nullable()();

  /// Resultado financeiro realizado (lucro/prejuízo) em centavos.
  /// Nulo enquanto a aposta estiver em aberto.
  IntColumn get resultCents => integer().nullable()();

  TextColumn get notes => text().nullable()();

  /// Nulo para apostas gravadas antes do suporte a múltiplas — tratar como
  /// [BetType.single]. Para [BetType.multiple], os campos [sport]/[event]/
  /// [market]/[selection]/[oddsScaled] acima guardam um resumo combinado
  /// (odd = produto das odds de cada seleção em [BetLegs]); o detalhe de
  /// cada jogo fica nas linhas de [BetLegs] vinculadas a esta aposta.
  TextColumn get betType => textEnum<BetType>().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
