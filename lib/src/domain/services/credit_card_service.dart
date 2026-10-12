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
        final amount = i == 1 ? baseShare + remainder : baseShare;
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

  /// Edita descrição/categoria/observações do lançamento (compra) — afeta
  /// todas as parcelas, já que esses dados não são duplicados por parcela.
  /// Não re-divide o valor entre as parcelas; para corrigir o valor de uma
  /// parcela específica, use [updateInstallmentAmount].
  Future<void> updateTransactionInfo({
    required int transactionId,
    required String description,
    int? categoryId,
    String? notes,
  }) async {
    if (description.trim().isEmpty) throw ValidationException('Informe uma descrição.');
    final existing = await _db.cardTransactionsDao.getById(transactionId);
    if (existing == null) throw ValidationException('Lançamento não encontrado.');
    await _db.cardTransactionsDao.updateTransaction(existing.copyWith(
      description: description.trim(),
      categoryId: Value(categoryId),
      notes: Value(notes),
      updatedAt: DateTime.now(),
    ));
  }

  /// Ajusta o valor de uma parcela específica (ex.: para corrigir uma
  /// divergência entre o valor previsto e o cobrado pela fatura real),
  /// sem alterar as demais parcelas da mesma compra.
  Future<void> updateInstallmentAmount({required int installmentId, required int amountCents}) async {
    if (amountCents < 0) throw ValidationException('O valor não pode ser negativo.');
    final existing = await _db.cardInstallmentsDao.getById(installmentId);
    if (existing == null) throw ValidationException('Parcela não encontrada.');
    await _db.cardInstallmentsDao.updateInstallment(existing.copyWith(amountCents: amountCents));
  }

  /// Exclui uma única parcela da fatura (ex.: foi cobrada por engano ou
  /// estornada à parte). Se depois disso a compra não tiver mais nenhuma
  /// parcela em nenhuma fatura, o lançamento da compra também é removido,
  /// para não deixar um registro orfão.
  Future<void> deleteInstallment(int installmentId) async {
    await _db.transaction(() async {
      final installment = await _db.cardInstallmentsDao.getById(installmentId);
      if (installment == null) return;
      await _db.cardInstallmentsDao.deleteOne(installmentId);
      final remaining = await _db.cardInstallmentsDao.getForTransaction(installment.cardTransactionId);
      if (remaining.isEmpty) {
        await _db.cardTransactionsDao.deleteTransaction(installment.cardTransactionId);
      }
    });
  }

  Stream<List<CardInstallmentRow>> watchInstallmentsForBill(int billId) {
    return _db.cardInstallmentsDao.watchForBill(billId);
  }

  /// Data "efetiva" de uma parcela: o mesmo dia da compra original,
  /// projetado no mês desta parcela — é o que determina em qual fatura
  /// ela cai (ver [_firstBillCycle]/[_findOrCreateBill]).
  DateTime installmentDate(CardTransactionRow transaction, int installmentNumber, int closingDay) {
    final firstCycle = _firstBillCycle(transaction.purchaseDate, closingDay);
    final cycle = _addMonths(firstCycle, installmentNumber - 1);
    return _dateForDay(cycle.$1, cycle.$2, transaction.purchaseDate.day);
  }

  /// Altera a data de uma parcela específica — na prática, reancora a
  /// compra inteira nesse novo dia (preservando a posição relativa de
  /// cada parcela: se a parcela 2 passa a cair em 03/09, a 1 cai em 03/08,
  /// a 3 em 03/10, e assim por diante) e reatribui cada parcela à fatura
  /// correta para a nova data, respeitando o dia de fechamento do cartão
  /// — uma parcela pode mudar de fatura como consequência.
  Future<void> rescheduleInstallment({required int installmentId, required DateTime newDate}) async {
    final installment = await _db.cardInstallmentsDao.getById(installmentId);
    if (installment == null) throw ValidationException('Parcela não encontrada.');
    final transaction = await _db.cardTransactionsDao.getById(installment.cardTransactionId);
    if (transaction == null) throw ValidationException('Lançamento não encontrado.');
    final card = await _requireCard(transaction.cardId);

    final newPurchaseCycle = _addMonths((newDate.year, newDate.month), -(installment.installmentNumber - 1));
    final newPurchaseDate = _dateForDay(newPurchaseCycle.$1, newPurchaseCycle.$2, newDate.day);

    await _db.transaction(() async {
      await _db.cardTransactionsDao.updateTransaction(transaction.copyWith(
        purchaseDate: newPurchaseDate,
        updatedAt: DateTime.now(),
      ));

      final allInstallments = await _db.cardInstallmentsDao.getForTransaction(transaction.id);
      final firstCycle = _firstBillCycle(newPurchaseDate, card.closingDay);
      for (final inst in allInstallments) {
        final cycle = _addMonths(firstCycle, inst.installmentNumber - 1);
        final billId = await _findOrCreateBill(transaction.cardId, cycle.$1, cycle.$2, card);
        if (billId != inst.billId) {
          await _db.cardInstallmentsDao.updateInstallment(inst.copyWith(billId: billId));
        }
      }
    });
  }

  Future<List<CardInstallmentRow>> getInstallmentsForBill(int billId) {
    return _db.cardInstallmentsDao.getForBill(billId);
  }

  Future<CardTransactionRow?> getTransactionById(int id) => _db.cardTransactionsDao.getById(id);

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

  /// Resumo de todas as faturas de um cartão, com um ajuste: faturas
  /// futuras já existem no banco antes da hora (criadas antecipadamente
  /// por compras parceladas), então mais de uma poderia ficar com status
  /// "aberta" ao mesmo tempo se cada uma fosse avaliada isoladamente. Só a
  /// que fecha mais perto (a atual) continua "aberta"; as demais, com
  /// fechamento mais distante, ficam "futura" até a atual fechar.
  Future<List<CreditCardBillSummary>> billSummariesForCard(int cardId) async {
    final bills = await getBillsForCard(cardId);
    final summaries = [for (final bill in bills) await billSummary(bill)];

    final openOnes = summaries.where((s) => s.status == CreditCardBillStatus.open).toList()
      ..sort((a, b) => a.bill.closingDate.compareTo(b.bill.closingDate));
    if (openOnes.length <= 1) return summaries;

    final currentBillId = openOnes.first.bill.id;
    return [
      for (final s in summaries)
        if (s.status == CreditCardBillStatus.open && s.bill.id != currentBillId)
          CreditCardBillSummary(
            bill: s.bill,
            totalAmountCents: s.totalAmountCents,
            paidAmountCents: s.paidAmountCents,
            status: CreditCardBillStatus.future,
          )
        else
          s,
    ];
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

  /// Exclui a fatura inteira: cada parcela que está nela (cascateando para
  /// a compra, se não restar mais nenhuma parcela em nenhuma outra
  /// fatura), qualquer pagamento já registrado para ela (e o lançamento
  /// correspondente no extrato) e, por fim, a própria fatura. Parcelas de
  /// uma mesma compra que caem em outras faturas não são afetadas.
  Future<void> deleteBill(int billId) async {
    await _db.transaction(() async {
      final installments = await _db.cardInstallmentsDao.getForBill(billId);
      for (final installment in installments) {
        await _db.cardInstallmentsDao.deleteOne(installment.id);
        final remaining = await _db.cardInstallmentsDao.getForTransaction(installment.cardTransactionId);
        if (remaining.isEmpty) {
          await _db.cardTransactionsDao.deleteTransaction(installment.cardTransactionId);
        }
      }

      final payments = await _db.creditCardBillPaymentsDao.getForBill(billId);
      for (final payment in payments) {
        await _db.ledgerDao.deleteForCreditCardBillPayment(payment.id);
      }
      await _db.creditCardBillPaymentsDao.deleteForBill(billId);

      await _db.creditCardBillsDao.deleteBill(billId);
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
