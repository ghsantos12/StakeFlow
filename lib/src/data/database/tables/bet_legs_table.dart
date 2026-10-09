import 'package:drift/drift.dart';
import 'bets_table.dart';

/// Cada seleção de uma aposta múltipla (combinada). Uma aposta simples não
/// tem nenhuma linha aqui — seus dados ficam só em [Bets].
@DataClassName('BetLegRow')
class BetLegs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get betId => integer().references(Bets, #id)();

  /// Ordem de exibição das seleções dentro da múltipla.
  IntColumn get position => integer()();

  TextColumn get sport => text()();
  TextColumn get event => text()();
  TextColumn get market => text()();
  TextColumn get selection => text()();
  IntColumn get oddsScaled => integer()();
}
