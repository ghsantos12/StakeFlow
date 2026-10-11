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

/// Contas bancárias visíveis ao módulo financeiro — exclui casas de
/// apostas e contas marcadas como exclusivas para dinheiro de apostas.
/// Usado em todos os seletores de conta do módulo financeiro.
final financialAccountsStreamProvider = StreamProvider<List<AccountRow>>((ref) {
  return ref.watch(accountServiceProvider).watchFinancialAccounts();
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

/// Filtro por vencimento das contas a pagar/receber (e faturas de
/// cartão) — compartilhado entre o dashboard financeiro e o hub de
/// contas a pagar/receber.
enum BillsDateFilter { all, currentMonth, nextMonth }

extension BillsDateFilterX on BillsDateFilter {
  String get label {
    switch (this) {
      case BillsDateFilter.all:
        return 'Todas';
      case BillsDateFilter.currentMonth:
        return 'Mês atual';
      case BillsDateFilter.nextMonth:
        return 'Mês que vem';
    }
  }

  bool matches(DateTime dueDate) {
    if (this == BillsDateFilter.all) return true;
    final now = DateTime.now();
    final target = this == BillsDateFilter.currentMonth
        ? (now.year, now.month)
        : (DateTime(now.year, now.month + 1).year, DateTime(now.year, now.month + 1).month);
    return dueDate.year == target.$1 && dueDate.month == target.$2;
  }
}

class _BillsDateFilterNotifier extends Notifier<BillsDateFilter> {
  @override
  BillsDateFilter build() => BillsDateFilter.all;

  void select(BillsDateFilter filter) => state = filter;
}

final billsDateFilterProvider = NotifierProvider<_BillsDateFilterNotifier, BillsDateFilter>(
  _BillsDateFilterNotifier.new,
);

final financialDashboardSnapshotProvider = FutureProvider<FinancialDashboardSnapshot>((ref) async {
  ref.watch(dbChangesProvider);
  final filter = ref.watch(billsDateFilterProvider);
  return ref.watch(financialAnalyticsServiceProvider).dashboardSnapshot(dueDateFilter: filter.matches);
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

class BillInstallmentDetail {
  const BillInstallmentDetail({required this.installment, required this.transaction});
  final CardInstallmentRow installment;
  final CardTransactionRow transaction;
}

/// Parcelas de uma fatura, já com a compra (transação) de origem de cada
/// uma — para a tela de detalhe da fatura mostrar descrição/categoria
/// junto do valor de cada parcela.
final billInstallmentDetailsProvider = FutureProvider.family<List<BillInstallmentDetail>, int>((ref, billId) async {
  ref.watch(dbChangesProvider);
  final service = ref.watch(creditCardServiceProvider);
  final installments = await service.getInstallmentsForBill(billId);
  final details = <BillInstallmentDetail>[];
  for (final installment in installments) {
    final tx = await service.getTransactionById(installment.cardTransactionId);
    if (tx != null) details.add(BillInstallmentDetail(installment: installment, transaction: tx));
  }
  return details;
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
