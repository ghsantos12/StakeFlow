import '../../core/utils/money.dart';

/// Uma seleção dentro de uma aposta múltipla, usada tanto para persistir
/// quanto para calcular (de forma pura, sem banco) o resumo exibido ao
/// usuário antes de salvar.
class BetLegInput {
  const BetLegInput({
    required this.sport,
    required this.event,
    required this.market,
    required this.selection,
    required this.oddsScaled,
  });

  final String sport;
  final String event;
  final String market;
  final String selection;
  final int oddsScaled;
}

/// Odd combinada = produto das odds de cada seleção.
int combinedOddsScaled(List<BetLegInput> legs) {
  return DecimalOdds.combine(legs.map((l) => l.oddsScaled));
}

/// Resumo dos jogos de uma múltipla, usado como [BetRow.event].
String summarizeLegEvents(List<BetLegInput> legs) {
  return legs.map((l) => l.event.trim()).join(' + ');
}

/// Resumo das seleções de uma múltipla, usado como [BetRow.selection].
String summarizeLegSelections(List<BetLegInput> legs) {
  return legs.map((l) => l.selection.trim()).join(' + ');
}

/// Esporte de uma múltipla: o esporte único quando todas as seleções são do
/// mesmo esporte, ou "Múltipla" quando mistura esportes diferentes.
String summarizeLegSport(List<BetLegInput> legs) {
  final sports = legs.map((l) => l.sport).toSet();
  return sports.length == 1 ? sports.first : 'Múltipla';
}
