import '../../data/database/database.dart';
import '../models/enums.dart';
import 'account_service.dart';
import 'analytics_calculations.dart';
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

  /// IDs das contas bancárias "do módulo financeiro" (exclui casas de
  /// apostas e contas marcadas como exclusivas para dinheiro de apostas).
  Future<Set<int>> _financialAccountIds() async {
    final accounts = await _accountService.getFinancialAccounts();
    return accounts.map((a) => a.id).toSet();
  }

  Future<List<MonthlyIncomeExpense>> monthlyIncomeExpenseSeries({DateTime? from, DateTime? to}) async {
    final movements = filterByFinancialAccounts(await _db.movementsDao.getAll(), await _financialAccountIds());
    return monthlyIncomeExpense(movements, from: from, to: to);
  }

  Future<List<CategoryTotal>> expensesByCategorySeries({DateTime? from, DateTime? to}) async {
    final movements = filterByFinancialAccounts(await _db.movementsDao.getAll(), await _financialAccountIds());
    final categories = await _db.financialCategoriesDao.getAll();
    return expensesByCategory(movements, categories, from: from, to: to);
  }

  Future<List<CategoryTotal>> incomeByCategorySeries({DateTime? from, DateTime? to}) async {
    final movements = filterByFinancialAccounts(await _db.movementsDao.getAll(), await _financialAccountIds());
    final categories = await _db.financialCategoriesDao.getAll();
    return incomeByCategory(movements, categories, from: from, to: to);
  }

  Future<CashFlowSummary> cashFlow({DateTime? from, DateTime? to}) async {
    final financialAccounts = await _accountService.getFinancialAccounts();
    final movements =
        filterByFinancialAccounts(await _db.movementsDao.getAll(), financialAccounts.map((a) => a.id).toSet());
    var balance = 0;
    for (final account in financialAccounts) {
      balance += await _accountService.balanceOf(account);
    }
    return cashFlowSummary(movements, currentBalanceCents: balance, from: from, to: to);
  }

  /// Evolução do saldo das contas bancárias "do módulo financeiro" (exclui
  /// casas de apostas e contas marcadas como exclusivas para dinheiro de
  /// apostas) — não deve ser confundida com o patrimônio do módulo de
  /// apostas, que inclui essas contas de propósito.
  Future<List<DatedValue>> bankBalanceSeries({DateTime? from, DateTime? to}) async {
    final accounts = await _accountService.getFinancialAccounts();
    final ledger = await _db.ledgerDao.getAllOrderedByDate();
    final points = buildPatrimonyHistory(accounts: accounts, ledger: ledger, bets: const [], from: from, to: to);
    return [for (final p in points) DatedValue(date: p.date, valueCents: p.bankCents)];
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

  /// [dueDateFilter], quando informado, restringe contas a pagar/receber e
  /// faturas de cartão às que vencem num período específico (ex.: mês
  /// atual, mês que vem) — nulo considera todas, sem limite de data.
  Future<FinancialDashboardSnapshot> dashboardSnapshot({bool Function(DateTime dueDate)? dueDateFilter}) async {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    bool matchesDue(DateTime dueDate) => dueDateFilter?.call(dueDate) ?? true;

    final accounts = await _accountService.getFinancialAccounts();
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
    for (final bill in payables.where((b) => !b.cancelled && matchesDue(b.dueDate))) {
      final movements = await _db.movementsDao.getAll();
      final paid = movements.where((m) => m.payableId == bill.id).fold<int>(0, (s, m) => s + m.amountCents);
      final remaining = bill.amountCents - paid;
      if (remaining > 0) totalPayable += remaining;
    }

    final receivables = await _db.billsReceivableDao.getAll();
    var totalReceivable = 0;
    for (final bill in receivables.where((b) => !b.cancelled && matchesDue(b.dueDate))) {
      final movements = await _db.movementsDao.getAll();
      final received = movements.where((m) => m.receivableId == bill.id).fold<int>(0, (s, m) => s + m.amountCents);
      final remaining = bill.amountCents - received;
      if (remaining > 0) totalReceivable += remaining;
    }

    final bills = await _db.creditCardBillsDao.getAll();
    var openCardBills = 0;
    for (final bill in bills.where((b) => matchesDue(b.dueDate))) {
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
      // Faturas de cartão em aberto (incluindo a fatura atual, ainda não
      // fechada) também são dívidas a pagar, não só as contas a pagar
      // cadastradas manualmente.
      totalPayableCents: totalPayable + openCardBills,
      totalReceivableCents: totalReceivable,
      openCardBillsCents: openCardBills,
    );
  }
}
