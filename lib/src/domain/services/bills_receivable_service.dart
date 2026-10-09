import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../data/database/database.dart';
import '../models/enums.dart';
import '../models/exceptions.dart';
import 'movement_service.dart';

class BillReceivableSummary {
  const BillReceivableSummary({
    required this.bill,
    required this.receivedAmountCents,
    required this.status,
  });

  final BillReceivableRow bill;
  final int receivedAmountCents;
  final BillStatus status;

  int get remainingCents => bill.amountCents - receivedAmountCents;
}

/// Espelha [BillsPayableService] para receitas futuras. O valor já
/// recebido é sempre a soma das movimentações vinculadas via
/// `receivableId`.
class BillsReceivableService {
  BillsReceivableService(this._db, this._movementService);

  final AppDatabase _db;
  final MovementService _movementService;
  static const _uuid = Uuid();
  static const int _maxUnboundedOccurrences = 24;

  Stream<List<BillReceivableRow>> watchAll() => _db.billsReceivableDao.watchAll();
  Future<List<BillReceivableRow>> getAll() => _db.billsReceivableDao.getAll();
  Future<BillReceivableRow?> getById(int id) => _db.billsReceivableDao.getById(id);

  Future<int> receivedAmountCents(int billId) async {
    final movements = await _db.movementsDao.getAll();
    return movements.where((m) => m.receivableId == billId).fold<int>(0, (s, m) => s + m.amountCents);
  }

  BillStatus computeStatus({
    required BillReceivableRow bill,
    required int receivedCents,
    DateTime? now,
  }) {
    if (bill.cancelled) return BillStatus.cancelled;
    if (receivedCents >= bill.amountCents && bill.amountCents > 0) return BillStatus.paid;
    if (receivedCents > 0) return BillStatus.partiallyPaid;
    final reference = now ?? DateTime.now();
    if (reference.isAfter(bill.dueDate)) return BillStatus.overdue;
    return BillStatus.pending;
  }

  Future<BillReceivableSummary> summaryOf(BillReceivableRow bill) async {
    final received = await receivedAmountCents(bill.id);
    return BillReceivableSummary(
      bill: bill,
      receivedAmountCents: received,
      status: computeStatus(bill: bill, receivedCents: received),
    );
  }

  Future<int> create({
    required String description,
    required int amountCents,
    int? categoryId,
    int? accountId,
    required DateTime dueDate,
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
      final id = await _db.billsReceivableDao.insertBill(BillsReceivableCompanion.insert(
        description: description.trim(),
        amountCents: amountCents,
        categoryId: Value(categoryId),
        accountId: Value(accountId),
        dueDate: d,
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

  Future<void> update(BillReceivableRow row) async {
    _validate(row.description, row.amountCents);
    await _db.billsReceivableDao.updateBill(row.copyWith(updatedAt: DateTime.now()));
  }

  Future<void> cancel(int id) async {
    final bill = await getById(id);
    if (bill == null) return;
    await _db.billsReceivableDao.updateBill(bill.copyWith(cancelled: true, updatedAt: DateTime.now()));
  }

  Future<void> delete(int id) async {
    await _db.billsReceivableDao.deleteBill(id);
  }

  /// Registra o recebimento (total ou parcial) de uma conta a receber:
  /// cria a movimentação de receita correspondente, que credita a conta
  /// e aparece no extrato.
  Future<void> receive({
    required int billId,
    required int accountId,
    required int amountCents,
    required DateTime receivedAt,
  }) async {
    if (amountCents <= 0) throw ValidationException('O valor deve ser maior que zero.');
    final bill = await getById(billId);
    if (bill == null) throw ValidationException('Conta a receber não encontrada.');

    await _movementService.saveMovement(
      type: MovementType.income,
      destinationAccountId: accountId,
      amountCents: amountCents,
      occurredAt: receivedAt,
      description: 'Recebimento: ${bill.description}',
      categoryId: bill.categoryId,
      receivableId: billId,
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
