import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../data/database/database.dart';
import '../../data/repositories/settings_repository.dart';
import '../models/enums.dart';
import '../models/exceptions.dart';

/// Centraliza depósitos, saques, transferências e ajustes de saldo.
///
/// Regra central: se a movimentação tem conta de origem, ela é debitada em
/// `amount + fee` (a taxa é um custo adicional que sai da origem); a conta
/// de destino recebe exatamente `amount`. Quando não há conta de origem
/// (depósito externo), a taxa é descontada do próprio crédito ao destino.
/// A taxa é sempre armazenada em [MovementRow.feeCents] para ser exibida
/// separadamente nos relatórios como despesa financeira.
class MovementService {
  MovementService(this._db, this._settings);

  final AppDatabase _db;
  final SettingsRepository _settings;
  static const _uuid = Uuid();

  Stream<List<MovementRow>> watchAll() => _db.movementsDao.watchAll();
  Future<List<MovementRow>> getAll() => _db.movementsDao.getAll();
  Future<MovementRow?> getById(int id) => _db.movementsDao.getById(id);

  Future<int> saveMovement({
    int? movementId,
    required MovementType type,
    int? sourceAccountId,
    int? destinationAccountId,
    required int amountCents,
    int feeCents = 0,
    required DateTime occurredAt,
    String? description,
    String? adjustmentReason,
    int? categoryId,
    bool reconciled = false,
    int? payableId,
    int? receivableId,
  }) async {
    _validate(
      type: type,
      sourceAccountId: sourceAccountId,
      destinationAccountId: destinationAccountId,
      amountCents: amountCents,
      feeCents: feeCents,
      adjustmentReason: adjustmentReason,
    );

    return _db.transaction<int>(() async {
      final now = DateTime.now();
      if (movementId != null) {
        await _db.ledgerDao.deleteForMovement(movementId);
      }

      if (type == MovementType.adjustment) {
        final account = await _requireAccount(sourceAccountId!);
        if (amountCents < 0) {
          await _checkAvailable(account, -amountCents);
        }
      } else if (sourceAccountId != null) {
        final account = await _requireAccount(sourceAccountId);
        await _checkAvailable(account, amountCents + feeCents);
      }

      final int id;
      if (movementId == null) {
        id = await _db.movementsDao.insertMovement(MovementsCompanion.insert(
          type: type,
          sourceAccountId: Value(sourceAccountId),
          destinationAccountId: Value(destinationAccountId),
          amountCents: amountCents,
          feeCents: Value(feeCents),
          occurredAt: occurredAt,
          description: Value(description),
          adjustmentReason: Value(adjustmentReason),
          categoryId: Value(categoryId),
          reconciled: Value(reconciled),
          payableId: Value(payableId),
          receivableId: Value(receivableId),
          createdAt: now,
          updatedAt: now,
        ));
      } else {
        id = movementId;
        final existing = await _db.movementsDao.getById(movementId);
        if (existing == null) throw ValidationException('Movimentação não encontrada.');
        await _db.movementsDao.updateMovement(existing.copyWith(
          type: type,
          sourceAccountId: Value(sourceAccountId),
          destinationAccountId: Value(destinationAccountId),
          amountCents: amountCents,
          feeCents: feeCents,
          occurredAt: occurredAt,
          description: Value(description),
          adjustmentReason: Value(adjustmentReason),
          categoryId: Value(categoryId),
          reconciled: reconciled,
          payableId: Value(payableId),
          receivableId: Value(receivableId),
          updatedAt: now,
        ));
      }

      final transferGroupId = _uuid.v4();
      final entries = <LedgerEntriesCompanion>[];

      if (type == MovementType.adjustment) {
        entries.add(LedgerEntriesCompanion.insert(
          accountId: sourceAccountId!,
          occurredAt: occurredAt,
          type: LedgerEntryType.adjustment,
          amountCents: amountCents,
          movementId: Value(id),
          transferGroupId: Value(transferGroupId),
          description: Value(description ?? adjustmentReason),
          createdAt: now,
        ));
      } else {
        final ledgerType = _ledgerTypeFor(type);
        if (sourceAccountId != null) {
          entries.add(LedgerEntriesCompanion.insert(
            accountId: sourceAccountId,
            occurredAt: occurredAt,
            type: ledgerType,
            amountCents: -(amountCents + feeCents),
            movementId: Value(id),
            transferGroupId: Value(transferGroupId),
            description: Value(description),
            createdAt: now,
          ));
        }
        if (destinationAccountId != null) {
          final credit = sourceAccountId != null ? amountCents : (amountCents - feeCents);
          entries.add(LedgerEntriesCompanion.insert(
            accountId: destinationAccountId,
            occurredAt: occurredAt,
            type: ledgerType,
            amountCents: credit,
            movementId: Value(id),
            transferGroupId: Value(transferGroupId),
            description: Value(description),
            createdAt: now,
          ));
        }
      }

      await _db.ledgerDao.insertEntries(entries);
      return id;
    });
  }

  Future<void> deleteMovement(int movementId) async {
    await _db.transaction(() async {
      await _db.ledgerDao.deleteForMovement(movementId);
      await _db.movementsDao.deleteMovement(movementId);
    });
  }

  void _validate({
    required MovementType type,
    required int? sourceAccountId,
    required int? destinationAccountId,
    required int amountCents,
    required int feeCents,
    required String? adjustmentReason,
  }) {
    if (feeCents < 0) throw ValidationException('A taxa não pode ser negativa.');

    switch (type) {
      case MovementType.adjustment:
        if (sourceAccountId == null) throw ValidationException('Selecione a conta do ajuste.');
        if (adjustmentReason == null || adjustmentReason.trim().isEmpty) {
          throw ValidationException('Informe a justificativa do ajuste.');
        }
        if (amountCents == 0) throw ValidationException('O valor do ajuste não pode ser zero.');
        return;
      case MovementType.externalDeposit:
      case MovementType.income:
      case MovementType.yield:
        if (destinationAccountId == null) {
          throw ValidationException('Selecione a conta de destino.');
        }
        break;
      case MovementType.externalWithdrawal:
      case MovementType.expense:
        if (sourceAccountId == null) {
          throw ValidationException('Selecione a conta de origem.');
        }
        break;
      case MovementType.depositToBookmaker:
      case MovementType.withdrawalFromBookmaker:
      case MovementType.transferBetweenAccounts:
        if (sourceAccountId == null || destinationAccountId == null) {
          throw ValidationException('Selecione as contas de origem e destino.');
        }
        if (sourceAccountId == destinationAccountId) {
          throw ValidationException('As contas de origem e destino devem ser diferentes.');
        }
        break;
    }
    if (amountCents <= 0) {
      throw ValidationException('O valor deve ser maior que zero.');
    }
  }

  Future<AccountRow> _requireAccount(int accountId) async {
    final account = await _db.accountsDao.getById(accountId);
    if (account == null) throw ValidationException('Conta não encontrada.');
    return account;
  }

  Future<void> _checkAvailable(AccountRow account, int requiredCents) async {
    if (!_settings.blockInsufficientBalance) return;
    final balance = account.initialBalanceCents + await _db.ledgerDao.sumForAccount(account.id);
    if (balance < requiredCents) {
      throw InsufficientBalanceException(account.name, balance, requiredCents);
    }
  }

  LedgerEntryType _ledgerTypeFor(MovementType type) {
    switch (type) {
      case MovementType.externalDeposit:
        return LedgerEntryType.externalDeposit;
      case MovementType.externalWithdrawal:
        return LedgerEntryType.externalWithdrawal;
      case MovementType.depositToBookmaker:
        return LedgerEntryType.depositToBookmaker;
      case MovementType.withdrawalFromBookmaker:
        return LedgerEntryType.withdrawalFromBookmaker;
      case MovementType.transferBetweenAccounts:
        return LedgerEntryType.transferBetweenAccounts;
      case MovementType.adjustment:
        return LedgerEntryType.adjustment;
      case MovementType.income:
        return LedgerEntryType.income;
      case MovementType.expense:
        return LedgerEntryType.expense;
      case MovementType.yield:
        return LedgerEntryType.yield;
    }
  }
}
