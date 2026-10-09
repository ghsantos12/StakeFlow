import '../../data/database/database.dart';
import '../models/enums.dart';
import 'account_service.dart';
import 'bills_payable_service.dart';
import 'bills_receivable_service.dart';
import 'credit_card_service.dart';
import 'daily_series.dart';

class ForecastEvent {
  const ForecastEvent({
    required this.date,
    required this.description,
    required this.amountCents,
    required this.kind,
  });

  final DateTime date;
  final String description;

  /// Valor com sinal: positivo é entrada prevista, negativo é saída.
  final int amountCents;

  /// 'payable' | 'receivable' | 'cardBill'.
  final String kind;
}

class ForecastPoint {
  const ForecastPoint({required this.date, required this.balanceCents});
  final DateTime date;
  final int balanceCents;
}

class ForecastSummary {
  const ForecastSummary({
    required this.currentBalanceCents,
    required this.endOfMonthCents,
    required this.nextMonthCents,
    required this.in3MonthsCents,
    required this.in6MonthsCents,
    required this.in12MonthsCents,
    required this.totalExpectedExpensesCents,
    required this.totalExpectedIncomeCents,
    required this.lowestProjectedBalanceCents,
    required this.points,
    required this.events,
  });

  final int currentBalanceCents;
  final int endOfMonthCents;
  final int nextMonthCents;
  final int in3MonthsCents;
  final int in6MonthsCents;
  final int in12MonthsCents;
  final int totalExpectedExpensesCents;
  final int totalExpectedIncomeCents;
  final int lowestProjectedBalanceCents;
  final List<ForecastPoint> points;
  final List<ForecastEvent> events;
}

/// Projeta o saldo bancário futuro a partir de contas a pagar/receber
/// pendentes e faturas de cartão em aberto — nunca a partir de lucro
/// futuro de apostas (que não é garantido) nem do limite do cartão (que
/// não é dinheiro disponível). Rendimento futuro de CDB, quando estimado,
/// é um cenário separado (ver [CdbEstimationService]), não entra aqui.
class ForecastService {
  ForecastService(
    this._db,
    this._accountService,
    this._billsPayableService,
    this._billsReceivableService,
    this._creditCardService,
  );

  final AppDatabase _db;
  final AccountService _accountService;
  final BillsPayableService _billsPayableService;
  final BillsReceivableService _billsReceivableService;
  final CreditCardService _creditCardService;

  /// [accountId] nulo projeta o saldo consolidado de todas as contas
  /// bancárias; informado, projeta apenas aquela conta.
  Future<ForecastSummary> forecast({int? accountId, int horizonMonths = 12}) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final horizonEnd = DateTime(today.year, today.month + horizonMonths, today.day);

    final startingBalance = await _startingBalance(accountId);
    final events = await _collectEvents(accountId);

    final deltas = bucketDeltasByDay(events.map((e) => (e.date, e.amountCents)));
    final base = startingBalance + sumDeltasBefore(deltas, today);
    final series = cumulativeSeriesForRange(
      deltas: deltas,
      baseBeforeRange: base,
      from: today,
      to: horizonEnd,
    );
    final days = dayRange(today, horizonEnd);
    final points = [
      for (var i = 0; i < days.length; i++) ForecastPoint(date: days[i], balanceCents: series[i]),
    ];

    DateTime addMonths(DateTime d, int months) => DateTime(d.year, d.month + months, d.day);
    int balanceAt(DateTime target) {
      var result = startingBalance;
      for (var i = 0; i < points.length; i++) {
        if (points[i].date.isAfter(target)) break;
        result = points[i].balanceCents;
      }
      return result;
    }

    final endOfMonth = DateTime(today.year, today.month + 1, 1).subtract(const Duration(days: 1));

    final totalExpenses = events.where((e) => e.amountCents < 0).fold<int>(0, (s, e) => s + e.amountCents);
    final totalIncome = events.where((e) => e.amountCents > 0).fold<int>(0, (s, e) => s + e.amountCents);
    final lowest = points.isEmpty
        ? startingBalance
        : points.map((p) => p.balanceCents).reduce((a, b) => a < b ? a : b);

    return ForecastSummary(
      currentBalanceCents: startingBalance,
      endOfMonthCents: balanceAt(endOfMonth),
      nextMonthCents: balanceAt(addMonths(endOfMonth, 1)),
      in3MonthsCents: balanceAt(addMonths(today, 3)),
      in6MonthsCents: balanceAt(addMonths(today, 6)),
      in12MonthsCents: balanceAt(addMonths(today, 12)),
      totalExpectedExpensesCents: totalExpenses,
      totalExpectedIncomeCents: totalIncome,
      lowestProjectedBalanceCents: lowest,
      points: points,
      events: events..sort((a, b) => a.date.compareTo(b.date)),
    );
  }

  Future<int> _startingBalance(int? accountId) async {
    if (accountId != null) {
      final account = await _accountService.getById(accountId);
      if (account == null) return 0;
      return _accountService.balanceOf(account);
    }
    final accounts = await _db.accountsDao.getAll();
    var total = 0;
    for (final account in accounts) {
      if (account.type != AccountType.bank) continue;
      total += await _accountService.balanceOf(account);
    }
    return total;
  }

  Future<List<ForecastEvent>> _collectEvents(int? accountId) async {
    final events = <ForecastEvent>[];

    for (final bill in await _billsPayableService.getAll()) {
      if (bill.cancelled) continue;
      if (accountId != null && bill.accountId != null && bill.accountId != accountId) continue;
      final paid = await _billsPayableService.paidAmountCents(bill.id);
      final remaining = bill.amountCents - paid;
      if (remaining <= 0) continue;
      events.add(ForecastEvent(
        date: bill.dueDate,
        description: bill.description,
        amountCents: -remaining,
        kind: 'payable',
      ));
    }

    for (final bill in await _billsReceivableService.getAll()) {
      if (bill.cancelled) continue;
      if (accountId != null && bill.accountId != null && bill.accountId != accountId) continue;
      final received = await _billsReceivableService.receivedAmountCents(bill.id);
      final remaining = bill.amountCents - received;
      if (remaining <= 0) continue;
      events.add(ForecastEvent(
        date: bill.dueDate,
        description: bill.description,
        amountCents: remaining,
        kind: 'receivable',
      ));
    }

    for (final card in await _creditCardService.getCards()) {
      if (accountId != null && card.defaultPaymentAccountId != null && card.defaultPaymentAccountId != accountId) {
        continue;
      }
      for (final bill in await _creditCardService.getBillsForCard(card.id)) {
        final summary = await _creditCardService.billSummary(bill);
        if (summary.remainingCents <= 0) continue;
        events.add(ForecastEvent(
          date: bill.dueDate,
          description: 'Fatura ${card.name}',
          amountCents: -summary.remainingCents,
          kind: 'cardBill',
        ));
      }
    }

    return events;
  }
}
