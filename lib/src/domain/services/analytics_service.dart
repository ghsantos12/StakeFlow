import '../../data/database/database.dart';
import '../models/enums.dart';
import 'analytics_calculations.dart';

class DashboardSnapshot {
  const DashboardSnapshot({
    required this.bankBalanceCents,
    required this.bookmakersAvailableCents,
    required this.bookmakersCommittedCents,
    required this.accumulatedBetsProfitCents,
    required this.todayBetsProfitCents,
    required this.monthBetsProfitCents,
    required this.roiClosedBets,
    required this.totalBetsCount,
    required this.hitRate,
    required this.accumulatedCdbYieldCents,
    required this.monthCdbYieldCents,
    required this.totalFeesCents,
  });

  final int bankBalanceCents;
  final int bookmakersAvailableCents;
  final int bookmakersCommittedCents;

  final int accumulatedBetsProfitCents;
  final int todayBetsProfitCents;
  final int monthBetsProfitCents;
  final double roiClosedBets;
  final int totalBetsCount;
  final double hitRate;

  final int accumulatedCdbYieldCents;
  final int monthCdbYieldCents;
  final int totalFeesCents;

  int get bookmakersTotalCents => bookmakersAvailableCents + bookmakersCommittedCents;
  int get totalPatrimonyCents => bankBalanceCents + bookmakersTotalCents;

  /// Lucro total = lucro líquido das apostas + rendimento líquido do CDB
  /// − outras despesas financeiras registradas.
  int get totalAccumulatedProfitCents =>
      accumulatedBetsProfitCents + accumulatedCdbYieldCents - totalFeesCents;
}

/// Camada fina que carrega os dados do banco e delega os cálculos para as
/// funções puras de [analytics_calculations.dart] (testáveis isoladamente).
class AnalyticsService {
  AnalyticsService(this._db);
  final AppDatabase _db;

  Future<_RawData> _loadRaw() async {
    final accounts = await _db.accountsDao.getAll(includeArchived: true);
    final bets = await _db.betsDao.getAll();
    final ledger = await _db.ledgerDao.getAllOrderedByDate();
    final cdbYields = await _db.cdbYieldsDao.getAll();
    final movements = await _db.movementsDao.getAll();
    return _RawData(
      accounts: accounts,
      bets: bets,
      ledger: ledger,
      cdbYields: cdbYields,
      movements: movements,
    );
  }

  Future<DashboardSnapshot> dashboardSnapshot() async {
    final raw = await _loadRaw();
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);

    var bank = 0, available = 0, committed = 0;
    for (final account in raw.accounts.where((a) => !a.isArchived)) {
      final balance = account.initialBalanceCents +
          raw.ledger.where((l) => l.accountId == account.id).fold<int>(0, (s, l) => s + l.amountCents);
      if (account.type == AccountType.bank) {
        bank += balance;
      } else {
        available += balance;
        committed += raw.bets
            .where((b) => b.accountId == account.id && b.status == BetStatus.open)
            .fold<int>(0, (s, b) => s + b.stakeCents);
      }
    }

    final indicatorsAll = computeIndicators(raw.bets, now: now);
    final indicatorsToday = computeIndicators(raw.bets, from: now, to: now, now: now);
    final indicatorsMonth = computeIndicators(raw.bets, from: monthStart, to: now, now: now);

    final accumulatedCdb = raw.cdbYields.fold<int>(0, (s, y) => s + y.amountCents);
    final monthCdb = raw.cdbYields
        .where((y) => !y.date.isBefore(monthStart))
        .fold<int>(0, (s, y) => s + y.amountCents);
    final fees = totalFees(raw.movements);

    return DashboardSnapshot(
      bankBalanceCents: bank,
      bookmakersAvailableCents: available,
      bookmakersCommittedCents: committed,
      accumulatedBetsProfitCents: indicatorsAll.netOperationalProfitCents,
      todayBetsProfitCents: indicatorsToday.netOperationalProfitCents,
      monthBetsProfitCents: indicatorsMonth.netOperationalProfitCents,
      roiClosedBets: indicatorsAll.roi,
      totalBetsCount: raw.bets.length,
      hitRate: indicatorsAll.hitRate,
      accumulatedCdbYieldCents: accumulatedCdb,
      monthCdbYieldCents: monthCdb,
      totalFeesCents: fees,
    );
  }

  Future<List<PatrimonyPoint>> patrimonyHistory({DateTime? from, DateTime? to}) async {
    final raw = await _loadRaw();
    return buildPatrimonyHistory(accounts: raw.accounts, ledger: raw.ledger, bets: raw.bets, from: from, to: to);
  }

  Future<List<DatedValue>> dailyProfitLossSeries({DateTime? from, DateTime? to}) async {
    final raw = await _loadRaw();
    return dailyProfitLoss(raw.bets, from: from, to: to);
  }

  Future<List<DatedValue>> cumulativeProfitSeries({DateTime? from, DateTime? to}) async {
    final raw = await _loadRaw();
    return cumulativeProfit(raw.bets, from: from, to: to);
  }

  Future<List<MonthlyValue>> monthlyResultsSeries({DateTime? from, DateTime? to}) async {
    final raw = await _loadRaw();
    return monthlyResults(raw.bets, from: from, to: to);
  }

  Future<ResultDistribution> resultDistributionData({DateTime? from, DateTime? to}) async {
    final raw = await _loadRaw();
    return resultDistribution(raw.bets, from: from, to: to);
  }

  Future<List<SportPerformance>> sportPerformance({DateTime? from, DateTime? to}) async {
    final raw = await _loadRaw();
    return performanceBySport(raw.bets, from: from, to: to);
  }

  Future<List<BookmakerPerformance>> bookmakerPerformance({DateTime? from, DateTime? to}) async {
    final raw = await _loadRaw();
    return performanceByBookmaker(raw.bets, raw.accounts, from: from, to: to);
  }

  Future<FinancialIndicators> indicators({DateTime? from, DateTime? to}) async {
    final raw = await _loadRaw();
    final fees = totalFees(raw.movements, from: from, to: to);
    return computeIndicators(raw.bets, from: from, to: to, totalFeesCents: fees);
  }

  Future<List<DatedValue>> cdbDailyYieldSeries({DateTime? from, DateTime? to}) async {
    final raw = await _loadRaw();
    return cdbYieldDaily(raw.cdbYields, from: from, to: to);
  }

  Future<List<MonthlyValue>> cdbMonthlyYieldSeries({DateTime? from, DateTime? to}) async {
    final raw = await _loadRaw();
    return cdbYieldMonthly(raw.cdbYields, from: from, to: to);
  }

  Future<List<MonthlyComparison>> betsVsCdbMonthly({DateTime? from, DateTime? to}) async {
    final raw = await _loadRaw();
    return monthlyBetsVsCdb(raw.bets, raw.cdbYields, from: from, to: to);
  }

  Future<List<DatedValue>> bankBalanceSeries({DateTime? from, DateTime? to}) async {
    final points = await patrimonyHistory(from: from, to: to);
    return [for (final p in points) DatedValue(date: p.date, valueCents: p.bankCents)];
  }
}

class _RawData {
  _RawData({
    required this.accounts,
    required this.bets,
    required this.ledger,
    required this.cdbYields,
    required this.movements,
  });

  final List<AccountRow> accounts;
  final List<BetRow> bets;
  final List<LedgerEntryRow> ledger;
  final List<CdbYieldRow> cdbYields;
  final List<MovementRow> movements;
}
