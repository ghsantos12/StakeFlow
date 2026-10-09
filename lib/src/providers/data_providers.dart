import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core_providers.dart';
import 'service_providers.dart';
import '../core/utils/date_range.dart';
import '../data/database/database.dart';
import '../domain/services/analytics_service.dart';
import '../domain/services/analytics_calculations.dart';
import '../domain/services/account_service.dart';

final accountsStreamProvider = StreamProvider<List<AccountRow>>((ref) {
  return ref.watch(accountServiceProvider).watchAccounts();
});

final betsStreamProvider = StreamProvider<List<BetRow>>((ref) {
  return ref.watch(betServiceProvider).watchAll();
});

final movementsStreamProvider = StreamProvider<List<MovementRow>>((ref) {
  return ref.watch(movementServiceProvider).watchAll();
});

class RangeFilterState {
  const RangeFilterState({this.preset = RangePreset.last30Days, this.custom});
  final RangePreset preset;
  final DateTimeRange? custom;

  DateTimeRange? resolve() => resolveRange(preset, custom: custom);

  RangeFilterState copyWith({RangePreset? preset, DateTimeRange? custom}) {
    return RangeFilterState(preset: preset ?? this.preset, custom: custom ?? this.custom);
  }
}

class RangeFilterNotifier extends Notifier<RangeFilterState> {
  @override
  RangeFilterState build() => const RangeFilterState();

  void setPreset(RangePreset preset) {
    state = RangeFilterState(preset: preset, custom: state.custom);
  }

  void setCustom(DateTimeRange range) {
    state = RangeFilterState(preset: RangePreset.custom, custom: range);
  }
}

final dashboardRangeProvider = NotifierProvider<RangeFilterNotifier, RangeFilterState>(
  RangeFilterNotifier.new,
);

final reportsRangeProvider = NotifierProvider<RangeFilterNotifier, RangeFilterState>(
  RangeFilterNotifier.new,
);

final dashboardSnapshotProvider = FutureProvider<DashboardSnapshot>((ref) async {
  ref.watch(dbChangesProvider);
  return ref.watch(analyticsServiceProvider).dashboardSnapshot();
});

final dashboardPatrimonyHistoryProvider = FutureProvider<List<PatrimonyPoint>>((ref) async {
  ref.watch(dbChangesProvider);
  final range = ref.watch(dashboardRangeProvider).resolve();
  return ref.watch(analyticsServiceProvider).patrimonyHistory(from: range?.start, to: range?.end);
});

class ReportsBundle {
  const ReportsBundle({
    required this.patrimony,
    required this.dailyProfit,
    required this.cumulativeProfit,
    required this.monthlyResults,
    required this.distribution,
    required this.sportPerformance,
    required this.bookmakerPerformance,
    required this.indicators,
    required this.cdbDaily,
    required this.cdbMonthly,
    required this.betsVsCdb,
    required this.bankBalance,
  });

  final List<PatrimonyPoint> patrimony;
  final List<DatedValue> dailyProfit;
  final List<DatedValue> cumulativeProfit;
  final List<MonthlyValue> monthlyResults;
  final ResultDistribution distribution;
  final List<SportPerformance> sportPerformance;
  final List<BookmakerPerformance> bookmakerPerformance;
  final FinancialIndicators indicators;
  final List<DatedValue> cdbDaily;
  final List<MonthlyValue> cdbMonthly;
  final List<MonthlyComparison> betsVsCdb;
  final List<DatedValue> bankBalance;
}

final reportsBundleProvider = FutureProvider<ReportsBundle>((ref) async {
  ref.watch(dbChangesProvider);
  final service = ref.watch(analyticsServiceProvider);
  final range = ref.watch(reportsRangeProvider).resolve();
  final from = range?.start;
  final to = range?.end;

  final results = await Future.wait([
    service.patrimonyHistory(from: from, to: to),
    service.dailyProfitLossSeries(from: from, to: to),
    service.cumulativeProfitSeries(from: from, to: to),
    service.monthlyResultsSeries(from: from, to: to),
    service.resultDistributionData(from: from, to: to),
    service.sportPerformance(from: from, to: to),
    service.bookmakerPerformance(from: from, to: to),
    service.indicators(from: from, to: to),
    service.cdbDailyYieldSeries(from: from, to: to),
    service.cdbMonthlyYieldSeries(from: from, to: to),
    service.betsVsCdbMonthly(from: from, to: to),
    service.bankBalanceSeries(from: from, to: to),
  ]);

  return ReportsBundle(
    patrimony: results[0] as List<PatrimonyPoint>,
    dailyProfit: results[1] as List<DatedValue>,
    cumulativeProfit: results[2] as List<DatedValue>,
    monthlyResults: results[3] as List<MonthlyValue>,
    distribution: results[4] as ResultDistribution,
    sportPerformance: results[5] as List<SportPerformance>,
    bookmakerPerformance: results[6] as List<BookmakerPerformance>,
    indicators: results[7] as FinancialIndicators,
    cdbDaily: results[8] as List<DatedValue>,
    cdbMonthly: results[9] as List<MonthlyValue>,
    betsVsCdb: results[10] as List<MonthlyComparison>,
    bankBalance: results[11] as List<DatedValue>,
  );
});

final accountBalanceProvider = FutureProvider.family<int, int>((ref, accountId) async {
  ref.watch(dbChangesProvider);
  final accountService = ref.watch(accountServiceProvider);
  final account = await accountService.getById(accountId);
  if (account == null) return 0;
  return accountService.balanceOf(account);
});

final bookmakerSummaryProvider = FutureProvider.family<BookmakerSummary?, int>((ref, accountId) async {
  ref.watch(dbChangesProvider);
  final accountService = ref.watch(accountServiceProvider);
  final account = await accountService.getById(accountId);
  if (account == null) return null;
  return accountService.bookmakerSummary(account);
});

final patrimonySummaryProvider = FutureProvider((ref) async {
  ref.watch(dbChangesProvider);
  return ref.watch(accountServiceProvider).currentPatrimonySummary();
});
