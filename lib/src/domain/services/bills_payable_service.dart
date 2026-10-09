import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../data/database/database.dart';
import '../models/enums.dart';
import '../models/exceptions.dart';
import 'movement_service.dart';

class BillPayableSummary {
  const BillPayableSummary({
    required this.bill,
    required this.paidAmountCents,
    required this.status,
  });

  final BillPayableRow bill;
  final int paidAmountCents;
  final BillStatus status;

  int get remainingCents => bill.amountCents - paidAmountCents;
}

/// Gerencia contas a pagar. O valor já pago nunca é armazenado — é sempre
/// a soma das movimentações (`Movements.amountCents`) vinculadas via
/// `payableId`, criadas através de [MovementService] para que a baixa já
/// apareça automaticamente no extrato e debite a conta bancária.
///
/// Recorrências são materializadas de uma vez na criação (um lote de
/// linhas compartilhando [BillPayableRow.recurrenceGroupId]), sem
/// depender de um job em segundo plano.
class BillsPayableService {
  BillsPayableService(this._db, this._movementService);

  final AppDatabase _db;
  final MovementService _movementService;
  static const _uuid = Uuid();
  static const int _maxUnboundedOccurrences = 24;

  Stream<List<BillPayableRow>> watchAll() => _db.billsPayableDao.watchAll();
  Future<List<BillPayableRow>> getAll() => _db.billsPayableDao.getAll();
  Future<BillPayableRow?> getById(int id) => _db.billsPayableDao.getById(id);

  Future<int> paidAmountCents(int billId) async {
    final movements = await _db.movementsDao.getAll();
    return movements.where((m) => m.payableId == billId).fold<int>(0, (s, m) => s + m.amountCents);
  }

  BillStatus computeStatus({
    required BillPayableRow bill,
    required int paidCents,
    DateTime? now,
  }) {
    if (bill.cancelled) return BillStatus.cancelled;
    if (paidCents >= bill.amountCents && bill.amountCents > 0) return BillStatus.paid;
    if (paidCents > 0) return BillStatus.partiallyPaid;
    final reference = now ?? DateTime.now();
    if (reference.isAfter(bill.dueDate)) return BillStatus.overdue;
    return BillStatus.pending;
  }

  Future<BillPayableSummary> summaryOf(BillPayableRow bill) async {
    final paid = await paidAmountCents(bill.id);
    return BillPayableSummary(
      bill: bill,
      paidAmountCents: paid,
      status: computeStatus(bill: bill, paidCents: paid),
    );
  }

  /// Cria uma conta a pagar. Se [recurrenceFrequency] for informado, gera
  /// um lote de ocorrências futuras de uma vez (até [recurrenceEndDate]
  /// ou [recurrenceOccurrences], ou um limite padrão de 24 ocorrências
  /// quando a recorrência não tem fim definido).
  Future<int> create({
    required String description,
    required int amountCents,
    int? categoryId,
    int? accountId,
    required DateTime dueDate,
    DateTime? competenceDate,
    String? notes,
    RecurrenceFrequency? recurrenceFrequency,
    DateTime? recurrenceEndDate,
    int? recurrenceOccurrences,
  }) async {
    _validate(description, amountCents);

    final now = DateTime.now();
    final recurrenceGroupId = recurrenceFrequency != null ? _uuid.v4() : null;
    final dueDates = recurrenceFrequency == null
        ? [dueDate]
        : _materializeDueDates(
            start: dueDate,
            frequency: recurrenceFrequency,
            endDate: recurrenceEndDate,
            occurrences: recurrenceOccurrences,
          );

    int? firstId;
    for (final d in dueDates) {
      final id = await _db.billsPayableDao.insertBill(BillsPayableCompanion.insert(
        description: description.trim(),
        amountCents: amountCents,
        categoryId: Value(categoryId),
        accountId: Value(accountId),
        dueDate: d,
        competenceDate: Value(competenceDate),
        notes: Value(notes),
        recurrenceFrequency: Value(recurrenceFrequency),
        recurrenceGroupId: Value(recurrenceGroupId),
        createdAt: now,
        updatedAt: now,
      ));
      firstId ??= id;
    }
    return firstId!;
  }

  Future<void> update(BillPayableRow row) async {
    _validate(row.description, row.amountCents);
    await _db.billsPayableDao.updateBill(row.copyWith(updatedAt: DateTime.now()));
  }

  Future<void> cancel(int id) async {
    final bill = await getById(id);
    if (bill == null) return;
    await _db.billsPayableDao.updateBill(bill.copyWith(cancelled: true, updatedAt: DateTime.now()));
  }

  Future<void> delete(int id) async {
    await _db.billsPayableDao.deleteBill(id);
  }

  /// Registra o pagamento (total ou parcial) de uma conta a pagar: cria a
  /// movimentação de despesa correspondente (que debita a conta e
  /// aparece no extrato) vinculada a esta conta a pagar.
  Future<void> pay({
    required int billId,
    required int accountId,
    required int amountCents,
    required DateTime paidAt,
  }) async {
    if (amountCents <= 0) throw ValidationException('O valor deve ser maior que zero.');
    final bill = await getById(billId);
    if (bill == null) throw ValidationException('Conta a pagar não encontrada.');

    await _movementService.saveMovement(
      type: MovementType.expense,
      sourceAccountId: accountId,
      amountCents: amountCents,
      occurredAt: paidAt,
      description: 'Pagamento: ${bill.description}',
      categoryId: bill.categoryId,
      payableId: billId,
    );
  }

  void _validate(String description, int amountCents) {
    if (description.trim().isEmpty) throw ValidationException('Informe uma descrição.');
    if (amountCents <= 0) throw ValidationException('O valor deve ser maior que zero.');
  }

  List<DateTime> _materializeDueDates({
    required DateTime start,
    required RecurrenceFrequency frequency,
    DateTime? endDate,
    int? occurrences,
  }) {
    final dates = <DateTime>[];
    var current = start;
    var count = 0;
    final maxCount = occurrences ?? _maxUnboundedOccurrences;
    while (count < maxCount) {
      if (endDate != null && current.isAfter(endDate)) break;
      dates.add(current);
      count++;
      current = _nextOccurrence(current, frequency);
    }
    return dates;
  }

  DateTime _nextOccurrence(DateTime date, RecurrenceFrequency frequency) {
    switch (frequency) {
      case RecurrenceFrequency.weekly:
        return date.add(const Duration(days: 7));
      case RecurrenceFrequency.biweekly:
        return date.add(const Duration(days: 14));
      case RecurrenceFrequency.monthly:
        return _addMonthsToDate(date, 1);
      case RecurrenceFrequency.yearly:
        return DateTime(date.year + 1, date.month, date.day);
    }
  }

  DateTime _addMonthsToDate(DateTime date, int months) {
    final totalMonths = date.year * 12 + (date.month - 1) + months;
    final year = totalMonths ~/ 12;
    final month = (totalMonths % 12) + 1;
    final lastDay = DateTime(year, month + 1, 0).day;
    final day = date.day > lastDay ? lastDay : date.day;
    return DateTime(year, month, day);
  }
}
