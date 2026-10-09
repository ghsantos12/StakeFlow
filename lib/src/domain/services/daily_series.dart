/// Funções puras para construir séries diárias acumuladas a partir de
/// eventos com data e valor (delta). Usadas para reconstruir saldos
/// históricos (patrimônio, saldo bancário, saldo em casas de apostas) a
/// partir do histórico de lançamentos, em vez de depender apenas do saldo
/// atual — o que garante que edições retroativas corrijam os gráficos.
library;

DateTime dayOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Agrupa uma lista de eventos (data, valor) somando os valores por dia.
Map<DateTime, int> bucketDeltasByDay(Iterable<(DateTime, int)> events) {
  final map = <DateTime, int>{};
  for (final e in events) {
    final day = dayOnly(e.$1);
    map[day] = (map[day] ?? 0) + e.$2;
  }
  return map;
}

/// Gera a lista de dias consecutivos entre [from] e [to] (inclusive).
List<DateTime> dayRange(DateTime from, DateTime to) {
  final start = dayOnly(from);
  final end = dayOnly(to);
  final days = <DateTime>[];
  var cursor = start;
  while (!cursor.isAfter(end)) {
    days.add(cursor);
    cursor = cursor.add(const Duration(days: 1));
  }
  return days;
}

/// Constrói a série acumulada dia a dia entre [from] e [to], carregando o
/// saldo dos dias sem movimentação (forward-fill) e aplicando [deltas] em
/// qualquer dia anterior a [from] como parte do saldo inicial.
List<int> cumulativeSeriesForRange({
  required Map<DateTime, int> deltas,
  required int baseBeforeRange,
  required DateTime from,
  required DateTime to,
}) {
  final days = dayRange(from, to);
  var running = baseBeforeRange;
  final out = <int>[];
  for (final day in days) {
    running += deltas[day] ?? 0;
    out.add(running);
  }
  return out;
}

/// Soma todos os deltas estritamente anteriores a [from].
int sumDeltasBefore(Map<DateTime, int> deltas, DateTime from) {
  final cutoff = dayOnly(from);
  var total = 0;
  for (final entry in deltas.entries) {
    if (entry.key.isBefore(cutoff)) {
      total += entry.value;
    }
  }
  return total;
}
