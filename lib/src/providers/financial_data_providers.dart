import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core_providers.dart';
import 'service_providers.dart';
import 'data_providers.dart';
import '../data/database/database.dart';
import '../domain/services/forecast_service.dart';
import '../domain/services/financial_analytics_service.dart';
import '../domain/services/financial_analytics_calculations.dart';
import '../domain/services/credit_card_service.dart';
import '../domain/services/bills_payable_service.dart';
import '../domain/services/bills_receivable_service.dart';

final categoriesStreamProvider = StreamProvider<List<FinancialCategoryRow>>((ref) {
  return ref.watch(categoryServiceProvider).watchAll();
});

final creditCardsStreamProvider = StreamProvider<List<CreditCardRow>>((ref) {
  return ref.watch(creditCardServiceProvider).watchCards();
});

final billsPayableStreamProvider = StreamProvider<List<BillPayableRow>>((ref) {
  return ref.watch(billsPayableServiceProvider).watchAll();
});

final billsReceivableStreamProvider = StreamProvider<List<BillReceivableRow>>((ref) {
  return ref.watch(billsReceivableServiceProvider).watchAll();
});

final financialDashboardSnapshotProvider = FutureProvider<FinancialDashboardSnapshot>((ref) async {
  ref.watch(dbChangesProvider);
  return ref.watch(financialAnalyticsServiceProvider).dashboardSnapshot();
});

final financialReportsRangeProvider = NotifierProvider<RangeFilterNotifier, RangeFilterState>(
  RangeFilterNotifier.new,
);

class FinancialReportsBundle {
  const FinancialReportsBundle({
    required this.monthly,
    required this.expensesByCategory,
    required this.incomeByCategory,
    required this.cashFlow,
    required this.cardSpending,
  });

  final List<MonthlyIncomeExpense> monthly;
  final List<CategoryTotal> expensesByCategory;
  final List<CategoryTotal> incomeByCategory;
  final CashFlowSummary cashFlow;
  final List<CardSpendingTotal> cardSpending;
}

final financialReportsBundleProvider = FutureProvider<FinancialReportsBundle>((ref) async {
  ref.watch(dbChangesProvider);
  final service = ref.watch(financialAnalyticsServiceProvider);
  final range = ref.watch(financialReportsRangeProvider).resolve();
  final from = range?.start;
  final to = range?.end;

  final results = await Future.wait([
    service.monthlyIncomeExpenseSeries(from: from, to: to),
    service.expensesByCategorySeries(from: from, to: to),
    service.incomeByCategorySeries(from: from, to: to),
    service.cashFlow(from: from, to: to),
    service.spendingByCard(from: from, to: to),
  ]);

  return FinancialReportsBundle(
    monthly: results[0] as List<MonthlyIncomeExpense>,
    expensesByCategory: results[1] as List<CategoryTotal>,
    incomeByCategory: results[2] as List<CategoryTotal>,
    cashFlow: results[3] as CashFlowSummary,
    cardSpending: results[4] as List<CardSpendingTotal>,
  );
});

/// Conta selecionada na tela de previsão (nulo = todas as contas
/// consolidadas).
final forecastAccountProvider = NotifierProvider<_ForecastAccountNotifier, int?>(
  _ForecastAccountNotifier.new,
);

class _ForecastAccountNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void select(int? accountId) => state = accountId;
}

final forecastProvider = FutureProvider<ForecastSummary>((ref) async {
  ref.watch(dbChangesProvider);
  final accountId = ref.watch(forecastAccountProvider);
  return ref.watch(forecastServiceProvider).forecast(accountId: accountId);
});

final creditCardBillsProvider = FutureProvider.family<List<CreditCardBillSummary>, int>((ref, cardId) async {
  ref.watch(dbChangesProvider);
  final service = ref.watch(creditCardServiceProvider);
  final bills = await service.getBillsForCard(cardId);
  final summaries = <CreditCardBillSummary>[];
  for (final bill in bills) {
    summaries.add(await service.billSummary(bill));
  }
  return summaries;
});

final cardAvailableLimitProvider = FutureProvider.family<int, int>((ref, cardId) async {
  ref.watch(dbChangesProvider);
  final service = ref.watch(creditCardServiceProvider);
  final card = await service.getCardById(cardId);
  if (card == null) return 0;
  return service.availableLimitCents(card);
});

final billPayableSummaryProvider = FutureProvider.family<BillPayableSummary?, int>((ref, billId) async {
  ref.watch(dbChangesProvider);
  final service = ref.watch(billsPayableServiceProvider);
  final bill = await service.getById(billId);
  if (bill == null) return null;
  return service.summaryOf(bill);
});

final billReceivableSummaryProvider = FutureProvider.family<BillReceivableSummary?, int>((ref, billId) async {
  ref.watch(dbChangesProvider);
  final service = ref.watch(billsReceivableServiceProvider);
  final bill = await service.getById(billId);
  if (bill == null) return null;
  return service.summaryOf(bill);
});
