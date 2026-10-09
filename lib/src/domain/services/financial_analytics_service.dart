import '../../data/database/database.dart';
import '../models/enums.dart';
import 'account_service.dart';
import 'financial_analytics_calculations.dart';

class CardSpendingTotal {
  const CardSpendingTotal({required this.cardId, required this.cardName, required this.totalCents});
  final int cardId;
  final String cardName;
  final int totalCents;
}

class FinancialDashboardSnapshot {
  const FinancialDashboardSnapshot({
    required this.totalBalanceCents,
    required this.monthIncomeCents,
    required this.monthExpenseCents,
    required this.totalPayableCents,
    required this.totalReceivableCents,
    required this.openCardBillsCents,
  });

  final int totalBalanceCents;
  final int monthIncomeCents;
  final int monthExpenseCents;
  final int totalPayableCents;
  final int totalReceivableCents;
  final int openCardBillsCents;
}

/// Camada fina que carrega os dados do banco para os cálculos puros de
/// `financial_analytics_calculations.dart`, seguindo o mesmo padrão do
/// `AnalyticsService` do módulo de apostas.
class FinancialAnalyticsService {
  FinancialAnalyticsService(this._db, this._accountService);

  final AppDatabase _db;
  final AccountService _accountService;

  Future<List<MonthlyIncomeExpense>> monthlyIncomeExpenseSeries({DateTime? from, DateTime? to}) async {
    final movements = await _db.movementsDao.getAll();
    return monthlyIncomeExpense(movements, from: from, to: to);
  }

  Future<List<CategoryTotal>> expensesByCategorySeries({DateTime? from, DateTime? to}) async {
    final movements = await _db.movementsDao.getAll();
    final categories = await _db.financialCategoriesDao.getAll();
    return expensesByCategory(movements, categories, from: from, to: to);
  }

  Future<List<CategoryTotal>> incomeByCategorySeries({DateTime? from, DateTime? to}) async {
    final movements = await _db.movementsDao.getAll();
    final categories = await _db.financialCategoriesDao.getAll();
    return incomeByCategory(movements, categories, from: from, to: to);
  }

  Future<CashFlowSummary> cashFlow({DateTime? from, DateTime? to}) async {
    final movements = await _db.movementsDao.getAll();
    final accounts = await _db.accountsDao.getAll();
    var balance = 0;
    for (final account in accounts) {
      balance += await _accountService.balanceOf(account);
    }
    return cashFlowSummary(movements, currentBalanceCents: balance, from: from, to: to);
  }

  Future<List<CardSpendingTotal>> spendingByCard({DateTime? from, DateTime? to}) async {
    final cards = await _db.creditCardsDao.getAll(includeArchived: true);
    final transactions = await _db.cardTransactionsDao.getAll();
    final result = <CardSpendingTotal>[];
    for (final card in cards) {
      final total = transactions
          .where((t) => t.cardId == card.id)
          .where((t) => from == null || !t.purchaseDate.isBefore(from))
          .where((t) => to == null || !t.purchaseDate.isAfter(to))
          .fold<int>(0, (s, t) => s + (t.type.isCredit ? -t.totalAmountCents : t.totalAmountCents));
      if (total != 0) {
        result.add(CardSpendingTotal(cardId: card.id, cardName: card.name, totalCents: total));
      }
    }
    result.sort((a, b) => b.totalCents.compareTo(a.totalCents));
    return result;
  }

  Future<FinancialDashboardSnapshot> dashboardSnapshot() async {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);

    final accounts = await _accountService.getAccounts();
    var totalBalance = 0;
    for (final account in accounts) {
      totalBalance += await _accountService.balanceOf(account);
    }

    final monthly = await monthlyIncomeExpenseSeries(from: monthStart, to: now);
    final thisMonth = monthly.where((m) => m.year == now.year && m.month == now.month);
    final monthIncome = thisMonth.fold<int>(0, (s, m) => s + m.incomeCents);
    final monthExpense = thisMonth.fold<int>(0, (s, m) => s + m.expenseCents);

    final payables = await _db.billsPayableDao.getAll();
    var totalPayable = 0;
    for (final bill in payables.where((b) => !b.cancelled)) {
      final movements = await _db.movementsDao.getAll();
      final paid = movements.where((m) => m.payableId == bill.id).fold<int>(0, (s, m) => s + m.amountCents);
      final remaining = bill.amountCents - paid;
      if (remaining > 0) totalPayable += remaining;
    }

    final receivables = await _db.billsReceivableDao.getAll();
    var totalReceivable = 0;
    for (final bill in receivables.where((b) => !b.cancelled)) {
      final movements = await _db.movementsDao.getAll();
      final received = movements.where((m) => m.receivableId == bill.id).fold<int>(0, (s, m) => s + m.amountCents);
      final remaining = bill.amountCents - received;
      if (remaining > 0) totalReceivable += remaining;
    }

    final bills = await _db.creditCardBillsDao.getAll();
    var openCardBills = 0;
    for (final bill in bills) {
      final installments = await _db.cardInstallmentsDao.getForBill(bill.id);
      final total = installments.fold<int>(0, (s, i) => s + i.amountCents);
      final payments = await _db.creditCardBillPaymentsDao.getForBill(bill.id);
      final paid = payments.fold<int>(0, (s, p) => s + p.amountCents);
      final remaining = total - paid;
      if (remaining > 0) openCardBills += remaining;
    }

    return FinancialDashboardSnapshot(
      totalBalanceCents: totalBalance,
      monthIncomeCents: monthIncome,
      monthExpenseCents: monthExpense,
      totalPayableCents: totalPayable,
      totalReceivableCents: totalReceivable,
      openCardBillsCents: openCardBills,
    );
  }
}
