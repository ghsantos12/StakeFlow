/// Funções puras de cálculo financeiro e estatístico, desacopladas do
/// banco de dados para que possam ser testadas unitariamente sem
/// depender de SQLite (ver testes em test/domain).
library;

import '../../data/database/database.dart';
import '../models/enums.dart';
import 'daily_series.dart';

class DatedValue {
  const DatedValue({required this.date, required this.valueCents});
  final DateTime date;
  final int valueCents;
}

class MonthlyValue {
  const MonthlyValue({required this.year, required this.month, required this.valueCents});
  final int year;
  final int month;
  final int valueCents;

  DateTime get asDate => DateTime(year, month);
}

class PatrimonyPoint {
  const PatrimonyPoint({
    required this.date,
    required this.totalCents,
    required this.bankCents,
    required this.bookmakersCents,
  });
  final DateTime date;
  final int totalCents;
  final int bankCents;
  final int bookmakersCents;
}

class ResultDistribution {
  const ResultDistribution({
    required this.wonCount,
    required this.lostCount,
    required this.voidedCount,
    required this.cashedOutCount,
  });
  final int wonCount;
  final int lostCount;
  final int voidedCount;
  final int cashedOutCount;

  int get total => wonCount + lostCount + voidedCount + cashedOutCount;
}

class SportPerformance {
  const SportPerformance({
    required this.sport,
    required this.betCount,
    required this.totalStakeCents,
    required this.netProfitCents,
    required this.wonCount,
    required this.lostCount,
  });
  final String sport;
  final int betCount;
  final int totalStakeCents;
  final int netProfitCents;
  final int wonCount;
  final int lostCount;

  double get roi => totalStakeCents == 0 ? 0 : (netProfitCents / totalStakeCents) * 100;
  double get hitRate {
    final denom = wonCount + lostCount;
    return denom == 0 ? 0 : (wonCount / denom) * 100;
  }
}

class BookmakerPerformance {
  const BookmakerPerformance({
    required this.accountId,
    required this.accountName,
    required this.betCount,
    required this.totalStakeCents,
    required this.netProfitCents,
    required this.wonCount,
    required this.lostCount,
  });
  final int accountId;
  final String accountName;
  final int betCount;
  final int totalStakeCents;
  final int netProfitCents;
  final int wonCount;
  final int lostCount;

  double get roi => totalStakeCents == 0 ? 0 : (netProfitCents / totalStakeCents) * 100;
  double get hitRate {
    final denom = wonCount + lostCount;
    return denom == 0 ? 0 : (wonCount / denom) * 100;
  }
}

class FinancialIndicators {
  const FinancialIndicators({
    required this.totalStakedSettled,
    required this.totalReturns,
    required this.grossProfitWon,
    required this.lossFromLost,
    required this.netResultCashouts,
    required this.netOperationalProfitCents,
    required this.roi,
    required this.hitRate,
    required this.averageOdds,
    required this.averageStakeCents,
    required this.biggestWinCents,
    required this.biggestLossCents,
    required this.last7DaysResultCents,
    required this.last30DaysResultCents,
    required this.settledCount,
    required this.openCount,
    required this.wonCount,
    required this.lostCount,
    required this.voidedCount,
    required this.cashedOutCount,
    required this.totalFeesCents,
  });

  final int totalStakedSettled;
  final int totalReturns;
  final int grossProfitWon;
  final int lossFromLost;
  final int netResultCashouts;
  final int netOperationalProfitCents;
  final double roi;
  final double hitRate;
  final double averageOdds;
  final int averageStakeCents;
  final int biggestWinCents;
  final int biggestLossCents;
  final int last7DaysResultCents;
  final int last30DaysResultCents;
  final int settledCount;
  final int openCount;
  final int wonCount;
  final int lostCount;
  final int voidedCount;
  final int cashedOutCount;
  final int totalFeesCents;
}

bool _inRange(DateTime date, DateTime? from, DateTime? to) {
  if (from != null && date.isBefore(dayOnly(from))) return false;
  if (to != null && date.isAfter(dayOnly(to).add(const Duration(hours: 23, minutes: 59, seconds: 59)))) {
    return false;
  }
  return true;
}

List<BetRow> _settledBets(List<BetRow> bets) =>
    bets.where((b) => b.status != BetStatus.open && b.settledAt != null).toList();

/// Reconstrói a evolução diária do patrimônio (e das séries de banco e
/// casas de apostas) a partir do histórico completo de lançamentos e
/// apostas — nunca a partir apenas do saldo atual — para que edições
/// retroativas corrijam automaticamente os gráficos.
List<PatrimonyPoint> buildPatrimonyHistory({
  required List<AccountRow> accounts,
  required List<LedgerEntryRow> ledger,
  required List<BetRow> bets,
  DateTime? from,
  DateTime? to,
}) {
  if (accounts.isEmpty) return [];
  final rangeEnd = to != null ? dayOnly(to) : dayOnly(DateTime.now());

  DateTime earliestAmong(Iterable<DateTime> dates, DateTime fallback) {
    DateTime? earliest;
    for (final d in dates) {
      final day = dayOnly(d);
      if (earliest == null || day.isBefore(earliest)) earliest = day;
    }
    return earliest ?? fallback;
  }

  final allRelevantDates = <DateTime>[
    ...accounts.map((a) => a.createdAt),
    ...ledger.map((l) => l.occurredAt),
    ...bets.map((b) => b.placedAt),
    ...bets.where((b) => b.settledAt != null).map((b) => b.settledAt!),
  ];
  final earliest = earliestAmong(allRelevantDates, rangeEnd);
  final rangeStart = from != null ? dayOnly(from) : earliest;

  if (rangeStart.isAfter(rangeEnd)) return [];

  final days = dayRange(rangeStart, rangeEnd);
  final totals = List<int>.filled(days.length, 0);
  final bankTotals = List<int>.filled(days.length, 0);
  final bookmakerTotals = List<int>.filled(days.length, 0);

  for (final account in accounts) {
    final ledgerDeltas = bucketDeltasByDay(
      ledger.where((l) => l.accountId == account.id).map((l) => (l.occurredAt, l.amountCents)),
    );
    final baseBalance = account.initialBalanceCents + sumDeltasBefore(ledgerDeltas, rangeStart);
    final balanceSeries = cumulativeSeriesForRange(
      deltas: ledgerDeltas,
      baseBeforeRange: baseBalance,
      from: rangeStart,
      to: rangeEnd,
    );

    var committedSeries = List<int>.filled(days.length, 0);
    if (account.type == AccountType.bookmaker) {
      final committedEvents = <(DateTime, int)>[];
      for (final bet in bets.where((b) => b.accountId == account.id)) {
        committedEvents.add((bet.placedAt, bet.stakeCents));
        if (bet.settledAt != null) {
          committedEvents.add((bet.settledAt!, -bet.stakeCents));
        }
      }
      final committedDeltas = bucketDeltasByDay(committedEvents);
      final baseCommitted = sumDeltasBefore(committedDeltas, rangeStart);
      committedSeries = cumulativeSeriesForRange(
        deltas: committedDeltas,
        baseBeforeRange: baseCommitted,
        from: rangeStart,
        to: rangeEnd,
      );
    }

    for (var i = 0; i < days.length; i++) {
      final acctTotal = balanceSeries[i] + committedSeries[i];
      totals[i] += acctTotal;
      if (account.type == AccountType.bank) {
        bankTotals[i] += balanceSeries[i];
      } else {
        bookmakerTotals[i] += acctTotal;
      }
    }
  }

  return [
    for (var i = 0; i < days.length; i++)
      PatrimonyPoint(
        date: days[i],
        totalCents: totals[i],
        bankCents: bankTotals[i],
        bookmakersCents: bookmakerTotals[i],
      ),
  ];
}

List<DatedValue> dailyProfitLoss(List<BetRow> bets, {DateTime? from, DateTime? to}) {
  final settled = _settledBets(bets).where((b) => _inRange(b.settledAt!, from, to));
  final map = <DateTime, int>{};
  for (final b in settled) {
    final day = dayOnly(b.settledAt!);
    map[day] = (map[day] ?? 0) + (b.resultCents ?? 0);
  }
  final days = map.keys.toList()..sort();
  return [for (final d in days) DatedValue(date: d, valueCents: map[d]!)];
}

List<DatedValue> cumulativeProfit(List<BetRow> bets, {DateTime? from, DateTime? to}) {
  final settled = _settledBets(bets);
  final deltas = bucketDeltasByDay(settled.map((b) => (b.settledAt!, b.resultCents ?? 0)));
  if (deltas.isEmpty) return [];
  final sortedDays = deltas.keys.toList()..sort();
  final rangeStart = from != null ? dayOnly(from) : sortedDays.first;
  final rangeEnd = to != null ? dayOnly(to) : sortedDays.last;
  if (rangeStart.isAfter(rangeEnd)) return [];
  final base = sumDeltasBefore(deltas, rangeStart);
  final series = cumulativeSeriesForRange(
    deltas: deltas,
    baseBeforeRange: base,
    from: rangeStart,
    to: rangeEnd,
  );
  final days = dayRange(rangeStart, rangeEnd);
  return [for (var i = 0; i < days.length; i++) DatedValue(date: days[i], valueCents: series[i])];
}

List<MonthlyValue> monthlyResults(List<BetRow> bets, {DateTime? from, DateTime? to}) {
  final settled = _settledBets(bets).where((b) => _inRange(b.settledAt!, from, to));
  final map = <(int, int), int>{};
  for (final b in settled) {
    final key = (b.settledAt!.year, b.settledAt!.month);
    map[key] = (map[key] ?? 0) + (b.resultCents ?? 0);
  }
  final keys = map.keys.toList()
    ..sort((a, b) => a.$1 != b.$1 ? a.$1 - b.$1 : a.$2 - b.$2);
  return [
    for (final k in keys) MonthlyValue(year: k.$1, month: k.$2, valueCents: map[k]!),
  ];
}

ResultDistribution resultDistribution(List<BetRow> bets, {DateTime? from, DateTime? to}) {
  final settled = _settledBets(bets).where((b) => _inRange(b.settledAt!, from, to));
  var won = 0, lost = 0, voided = 0, cashedOut = 0;
  for (final b in settled) {
    switch (b.status) {
      case BetStatus.won:
        won++;
        break;
      case BetStatus.lost:
        lost++;
        break;
      case BetStatus.voided:
        voided++;
        break;
      case BetStatus.cashedOut:
        cashedOut++;
        break;
      case BetStatus.open:
        break;
    }
  }
  return ResultDistribution(
    wonCount: won,
    lostCount: lost,
    voidedCount: voided,
    cashedOutCount: cashedOut,
  );
}

List<SportPerformance> performanceBySport(List<BetRow> bets, {DateTime? from, DateTime? to}) {
  final settled = _settledBets(bets).where((b) => _inRange(b.settledAt!, from, to));
  final grouped = <String, List<BetRow>>{};
  for (final b in settled) {
    grouped.putIfAbsent(b.sport, () => []).add(b);
  }
  final result = <SportPerformance>[];
  grouped.forEach((sport, list) {
    var stake = 0, profit = 0, won = 0, lost = 0;
    for (final b in list) {
      stake += b.stakeCents;
      profit += b.resultCents ?? 0;
      if (b.status == BetStatus.won) won++;
      if (b.status == BetStatus.lost) lost++;
    }
    result.add(SportPerformance(
      sport: sport,
      betCount: list.length,
      totalStakeCents: stake,
      netProfitCents: profit,
      wonCount: won,
      lostCount: lost,
    ));
  });
  result.sort((a, b) => b.netProfitCents.compareTo(a.netProfitCents));
  return result;
}

List<BookmakerPerformance> performanceByBookmaker(
  List<BetRow> bets,
  List<AccountRow> accounts, {
  DateTime? from,
  DateTime? to,
}) {
  final settled = _settledBets(bets).where((b) => _inRange(b.settledAt!, from, to));
  final grouped = <int, List<BetRow>>{};
  for (final b in settled) {
    grouped.putIfAbsent(b.accountId, () => []).add(b);
  }
  final namesById = {for (final a in accounts) a.id: a.name};
  final result = <BookmakerPerformance>[];
  grouped.forEach((accountId, list) {
    var stake = 0, profit = 0, won = 0, lost = 0;
    for (final b in list) {
      stake += b.stakeCents;
      profit += b.resultCents ?? 0;
      if (b.status == BetStatus.won) won++;
      if (b.status == BetStatus.lost) lost++;
    }
    result.add(BookmakerPerformance(
      accountId: accountId,
      accountName: namesById[accountId] ?? 'Conta removida',
      betCount: list.length,
      totalStakeCents: stake,
      netProfitCents: profit,
      wonCount: won,
      lostCount: lost,
    ));
  });
  result.sort((a, b) => b.netProfitCents.compareTo(a.netProfitCents));
  return result;
}

class MonthlyComparison {
  const MonthlyComparison({
    required this.year,
    required this.month,
    required this.betsProfitCents,
    required this.cdbYieldCents,
  });
  final int year;
  final int month;
  final int betsProfitCents;
  final int cdbYieldCents;

  DateTime get asDate => DateTime(year, month);
}

List<DatedValue> cdbYieldDaily(List<CdbYieldRow> yields, {DateTime? from, DateTime? to}) {
  final filtered = yields.where((y) => _inRange(y.date, from, to));
  final map = <DateTime, int>{};
  for (final y in filtered) {
    final day = dayOnly(y.date);
    map[day] = (map[day] ?? 0) + y.amountCents;
  }
  final days = map.keys.toList()..sort();
  return [for (final d in days) DatedValue(date: d, valueCents: map[d]!)];
}

List<MonthlyValue> cdbYieldMonthly(List<CdbYieldRow> yields, {DateTime? from, DateTime? to}) {
  final filtered = yields.where((y) => _inRange(y.date, from, to));
  final map = <(int, int), int>{};
  for (final y in filtered) {
    final key = (y.date.year, y.date.month);
    map[key] = (map[key] ?? 0) + y.amountCents;
  }
  final keys = map.keys.toList()..sort((a, b) => a.$1 != b.$1 ? a.$1 - b.$1 : a.$2 - b.$2);
  return [for (final k in keys) MonthlyValue(year: k.$1, month: k.$2, valueCents: map[k]!)];
}

List<MonthlyComparison> monthlyBetsVsCdb(
  List<BetRow> bets,
  List<CdbYieldRow> yields, {
  DateTime? from,
  DateTime? to,
}) {
  final betsMonthly = monthlyResults(bets, from: from, to: to);
  final cdbMonthly = cdbYieldMonthly(yields, from: from, to: to);
  final keys = <(int, int)>{};
  final betsMap = {for (final m in betsMonthly) (m.year, m.month): m.valueCents};
  final cdbMap = {for (final m in cdbMonthly) (m.year, m.month): m.valueCents};
  keys.addAll(betsMap.keys);
  keys.addAll(cdbMap.keys);
  final sortedKeys = keys.toList()..sort((a, b) => a.$1 != b.$1 ? a.$1 - b.$1 : a.$2 - b.$2);
  return [
    for (final k in sortedKeys)
      MonthlyComparison(
        year: k.$1,
        month: k.$2,
        betsProfitCents: betsMap[k] ?? 0,
        cdbYieldCents: cdbMap[k] ?? 0,
      ),
  ];
}

int totalFees(List<MovementRow> movements, {DateTime? from, DateTime? to}) {
  return movements
      .where((m) => _inRange(m.occurredAt, from, to))
      .fold<int>(0, (sum, m) => sum + m.feeCents);
}

FinancialIndicators computeIndicators(
  List<BetRow> allBets, {
  DateTime? from,
  DateTime? to,
  DateTime? now,
  int totalFeesCents = 0,
}) {
  final reference = now ?? DateTime.now();
  final filtered = _settledBets(allBets).where((b) => _inRange(b.settledAt!, from, to)).toList();

  var totalStaked = 0;
  var totalReturns = 0;
  var grossProfitWon = 0;
  var lossFromLost = 0;
  var netResultCashouts = 0;
  var netProfit = 0;
  var won = 0, lost = 0, voided = 0, cashedOut = 0;
  var biggestWin = 0, biggestLoss = 0;
  var oddsSum = 0.0;

  for (final b in filtered) {
    totalStaked += b.stakeCents;
    final result = b.resultCents ?? 0;
    netProfit += result;
    oddsSum += b.oddsScaled / 1000;
    if (result > biggestWin) biggestWin = result;
    if (result < biggestLoss) biggestLoss = result;

    switch (b.status) {
      case BetStatus.won:
        won++;
        grossProfitWon += result;
        totalReturns += b.stakeCents + result;
        break;
      case BetStatus.lost:
        lost++;
        lossFromLost += result.abs();
        break;
      case BetStatus.voided:
        voided++;
        totalReturns += b.stakeCents;
        break;
      case BetStatus.cashedOut:
        cashedOut++;
        netResultCashouts += result;
        totalReturns += b.stakeCents + result;
        break;
      case BetStatus.open:
        break;
    }
  }

  final hitRateDenom = won + lost;
  final roi = totalStaked == 0 ? 0.0 : (netProfit / totalStaked) * 100;
  final hitRate = hitRateDenom == 0 ? 0.0 : (won / hitRateDenom) * 100;
  final avgOdds = filtered.isEmpty ? 0.0 : oddsSum / filtered.length;
  final avgStake = filtered.isEmpty ? 0 : totalStaked ~/ filtered.length;

  final last7 = reference.subtract(const Duration(days: 7));
  final last30 = reference.subtract(const Duration(days: 30));
  final allSettled = _settledBets(allBets);
  final last7Result = allSettled
      .where((b) => !b.settledAt!.isBefore(dayOnly(last7)))
      .fold<int>(0, (sum, b) => sum + (b.resultCents ?? 0));
  final last30Result = allSettled
      .where((b) => !b.settledAt!.isBefore(dayOnly(last30)))
      .fold<int>(0, (sum, b) => sum + (b.resultCents ?? 0));

  final openCount = allBets.where((b) => b.status == BetStatus.open).length;

  return FinancialIndicators(
    totalStakedSettled: totalStaked,
    totalReturns: totalReturns,
    grossProfitWon: grossProfitWon,
    lossFromLost: lossFromLost,
    netResultCashouts: netResultCashouts,
    netOperationalProfitCents: netProfit,
    roi: roi,
    hitRate: hitRate,
    averageOdds: avgOdds,
    averageStakeCents: avgStake,
    biggestWinCents: biggestWin,
    biggestLossCents: biggestLoss,
    last7DaysResultCents: last7Result,
    last30DaysResultCents: last30Result,
    settledCount: filtered.length,
    openCount: openCount,
    wonCount: won,
    lostCount: lost,
    voidedCount: voided,
    cashedOutCount: cashedOut,
    totalFeesCents: totalFeesCents,
  );
}
