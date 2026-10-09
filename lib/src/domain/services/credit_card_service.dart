import 'package:drift/drift.dart';
import '../../data/database/database.dart';
import '../../data/repositories/settings_repository.dart';
import '../models/enums.dart';
import '../models/exceptions.dart';

class CreditCardBillSummary {
  const CreditCardBillSummary({
    required this.bill,
    required this.totalAmountCents,
    required this.paidAmountCents,
    required this.status,
  });

  final CreditCardBillRow bill;
  final int totalAmountCents;
  final int paidAmountCents;
  final CreditCardBillStatus status;

  int get remainingCents => totalAmountCents - paidAmountCents;
}

/// Gerencia cartões de crédito: compras (com parcelamento), faturas
/// (calculadas a partir das parcelas, nunca armazenadas em cache) e
/// pagamentos de fatura, que debitam a conta bancária escolhida através
/// do mesmo ledger usado pelo resto do app.
class CreditCardService {
  CreditCardService(this._db, this._settings);

  final AppDatabase _db;
  final SettingsRepository _settings;

  // ---- Cartões ----

  Stream<List<CreditCardRow>> watchCards({bool includeArchived = false}) {
    return _db.creditCardsDao.watchAll(includeArchived: includeArchived);
  }

  Future<List<CreditCardRow>> getCards({bool includeArchived = false}) {
    return _db.creditCardsDao.getAll(includeArchived: includeArchived);
  }

  Future<CreditCardRow?> getCardById(int id) => _db.creditCardsDao.getById(id);
  Stream<CreditCardRow?> watchCardById(int id) => _db.creditCardsDao.watchById(id);

  Future<int> createCard({
    required String name,
    String? issuerBank,
    required int creditLimitCents,
    required int closingDay,
    required int dueDay,
    int? defaultPaymentAccountId,
    int colorValue = 0xFF7C3AED,
  }) {
    _validateCardDays(closingDay, dueDay);
    if (name.trim().isEmpty) throw ValidationException('Informe um nome para o cartão.');
    return _db.creditCardsDao.insertCard(CreditCardsCompanion.insert(
      name: name.trim(),
      issuerBank: Value(issuerBank),
      creditLimitCents: Value(creditLimitCents),
      closingDay: closingDay,
      dueDay: dueDay,
      defaultPaymentAccountId: Value(defaultPaymentAccountId),
      colorValue: Value(colorValue),
      createdAt: DateTime.now(),
    ));
  }

  Future<void> updateCard(CreditCardRow row) async {
    _validateCardDays(row.closingDay, row.dueDay);
    if (row.name.trim().isEmpty) throw ValidationException('Informe um nome para o cartão.');
    await _db.creditCardsDao.updateCard(row);
  }

  Future<void> archiveCard(int id) async {
    final card = await getCardById(id);
    if (card == null) return;
    await _db.creditCardsDao.updateCard(card.copyWith(isArchived: true));
  }

  void _validateCardDays(int closingDay, int dueDay) {
    if (closingDay < 1 || closingDay > 31) {
      throw ValidationException('Dia de fechamento inválido.');
    }
    if (dueDay < 1 || dueDay > 31) {
      throw ValidationException('Dia de vencimento inválido.');
    }
  }

  // ---- Limite ----

  Future<int> usedLimitCents(int cardId) async {
    final bills = await _db.creditCardBillsDao.getForCard(cardId);
    var used = 0;
    for (final bill in bills) {
      final total = await billTotalCents(bill.id);
      final paid = await billPaidCents(bill.id);
      final remaining = total - paid;
      if (remaining > 0) used += remaining;
    }
    return used;
  }

  Future<int> availableLimitCents(CreditCardRow card) async {
    final used = await usedLimitCents(card.id);
    final available = card.creditLimitCents - used;
    return available < 0 ? 0 : available;
  }

  // ---- Lançamentos (compras, estornos, ajustes, encargos) ----

  Stream<List<CardTransactionRow>> watchTransactionsForCard(int cardId) {
    return _db.cardTransactionsDao.watchForCard(cardId);
  }

  Future<List<CardTransactionRow>> getAllTransactions() => _db.cardTransactionsDao.getAll();

  Future<int> registerTransaction({
    required int cardId,
    required CardTransactionType type,
    required String description,
    required int totalAmountCents,
    required DateTime purchaseDate,
    int? categoryId,
    int installmentsCount = 1,
    bool isRecurring = false,
    String? notes,
  }) async {
    if (description.trim().isEmpty) throw ValidationException('Informe uma descrição.');
    if (totalAmountCents <= 0) throw ValidationException('O valor deve ser maior que zero.');
    if (installmentsCount < 1) throw ValidationException('Número de parcelas inválido.');

    final card = await _requireCard(cardId);

    return _db.transaction<int>(() async {
      final now = DateTime.now();
      final txId = await _db.cardTransactionsDao.insertTransaction(CardTransactionsCompanion.insert(
        cardId: cardId,
        type: type,
        description: description.trim(),
        totalAmountCents: totalAmountCents,
        purchaseDate: purchaseDate,
        categoryId: Value(categoryId),
        installmentsCount: Value(installmentsCount),
        isRecurring: Value(isRecurring),
        notes: Value(notes),
        createdAt: now,
        updatedAt: now,
      ));

      final signedTotal = type.isCredit ? -totalAmountCents : totalAmountCents;
      final baseShare = signedTotal ~/ installmentsCount;
      final remainder = signedTotal - baseShare * installmentsCount;

      final firstCycle = _firstBillCycle(purchaseDate, card.closingDay);
      final companions = <CardInstallmentsCompanion>[];
      for (var i = 1; i <= installmentsCount; i++) {
        final cycle = _addMonths(firstCycle, i - 1);
        final billId = await _findOrCreateBill(cardId, cycle.$1, cycle.$2, card);
        final amount = i == installmentsCount ? baseShare + remainder : baseShare;
        companions.add(CardInstallmentsCompanion.insert(
          cardTransactionId: txId,
          billId: billId,
          installmentNumber: i,
          totalInstallments: installmentsCount,
          amountCents: amount,
          createdAt: now,
        ));
      }
      await _db.cardInstallmentsDao.insertInstallments(companions);
      return txId;
    });
  }

  Future<void> deleteTransaction(int transactionId) async {
    await _db.transaction(() async {
      await _db.cardInstallmentsDao.deleteForTransaction(transactionId);
      await _db.cardTransactionsDao.deleteTransaction(transactionId);
    });
  }

  Future<AccountRow?> _accountById(int id) => _db.accountsDao.getById(id);

  // ---- Faturas ----

  Future<List<CreditCardBillRow>> getBillsForCard(int cardId) {
    return _db.creditCardBillsDao.getForCard(cardId);
  }

  Future<int> billTotalCents(int billId) async {
    final installments = await _db.cardInstallmentsDao.getForBill(billId);
    return installments.fold<int>(0, (s, i) => s + i.amountCents);
  }

  Future<int> billPaidCents(int billId) async {
    final payments = await _db.creditCardBillPaymentsDao.getForBill(billId);
    return payments.fold<int>(0, (s, p) => s + p.amountCents);
  }

  CreditCardBillStatus computeStatus({
    required CreditCardBillRow bill,
    required int totalCents,
    required int paidCents,
    DateTime? now,
  }) {
    final reference = now ?? DateTime.now();
    if (totalCents > 0 && paidCents >= totalCents) return CreditCardBillStatus.paid;
    if (paidCents > 0) return CreditCardBillStatus.partiallyPaid;
    if (reference.isAfter(bill.dueDate)) return CreditCardBillStatus.overdue;
    if (!reference.isBefore(bill.closingDate)) return CreditCardBillStatus.closed;
    return CreditCardBillStatus.open;
  }

  Future<CreditCardBillSummary> billSummary(CreditCardBillRow bill) async {
    final total = await billTotalCents(bill.id);
    final paid = await billPaidCents(bill.id);
    return CreditCardBillSummary(
      bill: bill,
      totalAmountCents: total,
      paidAmountCents: paid,
      status: computeStatus(bill: bill, totalCents: total, paidCents: paid),
    );
  }

  Future<void> payBill({
    required int billId,
    required int accountId,
    required int amountCents,
    required DateTime paidAt,
  }) async {
    if (amountCents <= 0) throw ValidationException('O valor deve ser maior que zero.');

    await _db.transaction(() async {
      final account = await _accountById(accountId);
      if (account == null) throw ValidationException('Conta não encontrada.');

      if (_settings.blockInsufficientBalance) {
        final balance = account.initialBalanceCents + await _db.ledgerDao.sumForAccount(accountId);
        if (balance < amountCents) {
          throw InsufficientBalanceException(account.name, balance, amountCents);
        }
      }

      final now = DateTime.now();
      final paymentId = await _db.creditCardBillPaymentsDao.insertPayment(CreditCardBillPaymentsCompanion.insert(
        billId: billId,
        accountId: accountId,
        amountCents: amountCents,
        paidAt: paidAt,
        createdAt: now,
      ));
      await _db.ledgerDao.insertEntry(LedgerEntriesCompanion.insert(
        accountId: accountId,
        occurredAt: paidAt,
        type: LedgerEntryType.creditCardBillPayment,
        amountCents: -amountCents,
        creditCardBillPaymentId: Value(paymentId),
        description: const Value('Pagamento de fatura de cartão'),
        createdAt: now,
      ));
    });
  }

  Future<CreditCardRow> _requireCard(int cardId) async {
    final card = await getCardById(cardId);
    if (card == null) throw ValidationException('Cartão não encontrado.');
    return card;
  }

  Future<int> _findOrCreateBill(int cardId, int year, int month, CreditCardRow card) async {
    final existing = await _db.creditCardBillsDao.findByCardAndMonth(cardId, year, month);
    if (existing != null) return existing.id;

    final closingDate = _dateForDay(year, month, card.closingDay);
    final dueCycle = card.dueDay > card.closingDay ? (year, month) : _addMonths((year, month), 1);
    final dueDate = _dateForDay(dueCycle.$1, dueCycle.$2, card.dueDay);

    return _db.creditCardBillsDao.insertBill(CreditCardBillsCompanion.insert(
      cardId: cardId,
      referenceYear: year,
      referenceMonth: month,
      closingDate: closingDate,
      dueDate: dueDate,
      createdAt: DateTime.now(),
    ));
  }

  /// Ciclo (ano, mês) da primeira fatura em que uma compra entra: se a
  /// compra ocorreu até o dia de fechamento, cai na fatura deste mês;
  /// depois do fechamento, rola para o mês seguinte.
  (int, int) _firstBillCycle(DateTime purchaseDate, int closingDay) {
    if (purchaseDate.day <= closingDay) {
      return (purchaseDate.year, purchaseDate.month);
    }
    return _addMonths((purchaseDate.year, purchaseDate.month), 1);
  }

  (int, int) _addMonths((int, int) cycle, int months) {
    final total = cycle.$1 * 12 + (cycle.$2 - 1) + months;
    return (total ~/ 12, (total % 12) + 1);
  }

  /// Constrói uma data para (ano, mês, dia), ajustando o dia para o
  /// último dia válido do mês quando necessário (ex.: dia 31 em fevereiro).
  DateTime _dateForDay(int year, int month, int day) {
    final lastDay = DateTime(year, month + 1, 0).day;
    final clampedDay = day > lastDay ? lastDay : day;
    return DateTime(year, month, clampedDay);
  }
}
