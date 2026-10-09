import 'package:drift/drift.dart';
import '../../data/database/database.dart';
import '../models/enums.dart';
import '../models/exceptions.dart';

class BookmakerSummary {
  BookmakerSummary({required this.availableCents, required this.committedCents});
  final int availableCents;
  final int committedCents;
  int get totalCents => availableCents + committedCents;
}

class PatrimonySummary {
  PatrimonySummary({
    required this.bankCents,
    required this.bookmakersAvailableCents,
    required this.bookmakersCommittedCents,
  });

  final int bankCents;
  final int bookmakersAvailableCents;
  final int bookmakersCommittedCents;

  int get bookmakersTotalCents => bookmakersAvailableCents + bookmakersCommittedCents;
  int get totalCents => bankCents + bookmakersTotalCents;
}

class AccountService {
  AccountService(this._db);
  final AppDatabase _db;

  Stream<List<AccountRow>> watchAccounts({bool includeArchived = false}) {
    return _db.accountsDao.watchAll(includeArchived: includeArchived);
  }

  Future<List<AccountRow>> getAccounts({bool includeArchived = false}) {
    return _db.accountsDao.getAll(includeArchived: includeArchived);
  }

  Future<AccountRow?> getById(int id) => _db.accountsDao.getById(id);

  Stream<AccountRow?> watchById(int id) => _db.accountsDao.watchById(id);

  /// Saldo calculado = saldo inicial + soma de todos os lançamentos do
  /// extrato (ledger) para a conta. Nunca é editado diretamente.
  Future<int> balanceOf(AccountRow account) async {
    final ledgerSum = await _db.ledgerDao.sumForAccount(account.id);
    return account.initialBalanceCents + ledgerSum;
  }

  Future<int> committedOf(int accountId) async {
    final openBets = await _db.betsDao.getOpenBetsForAccount(accountId);
    var sum = 0;
    for (final bet in openBets) {
      sum += bet.stakeCents;
    }
    return sum;
  }

  Future<BookmakerSummary> bookmakerSummary(AccountRow account) async {
    final available = await balanceOf(account);
    final committed = await committedOf(account.id);
    return BookmakerSummary(availableCents: available, committedCents: committed);
  }

  Future<PatrimonySummary> currentPatrimonySummary() async {
    final accounts = await getAccounts();
    var bank = 0;
    var available = 0;
    var committed = 0;
    for (final account in accounts) {
      final balance = await balanceOf(account);
      if (account.type == AccountType.bank) {
        bank += balance;
      } else {
        available += balance;
        committed += await committedOf(account.id);
      }
    }
    return PatrimonySummary(
      bankCents: bank,
      bookmakersAvailableCents: available,
      bookmakersCommittedCents: committed,
    );
  }

  Future<int> createAccount({
    required String name,
    required AccountType type,
    String? institution,
    int initialBalanceCents = 0,
    double? cdiPercent,
    CdbAccountingType? cdbAccountingType,
    DateTime? cdbTrackingStartDate,
    int cdbAccumulatedBeforeTrackingCents = 0,
  }) {
    if (name.trim().isEmpty) {
      throw ValidationException('Informe um nome para a conta.');
    }
    return _db.accountsDao.insertAccount(AccountsCompanion.insert(
      name: name.trim(),
      type: type,
      institution: Value(institution),
      initialBalanceCents: Value(initialBalanceCents),
      createdAt: DateTime.now(),
      cdiPercent: Value(cdiPercent),
      cdbAccountingType: Value(cdbAccountingType),
      cdbTrackingStartDate: Value(cdbTrackingStartDate),
      cdbAccumulatedBeforeTrackingCents: Value(cdbAccumulatedBeforeTrackingCents),
    ));
  }

  Future<void> updateAccount(AccountRow row) async {
    if (row.name.trim().isEmpty) {
      throw ValidationException('Informe um nome para a conta.');
    }
    await _db.accountsDao.updateAccount(row);
  }

  Future<void> archiveAccount(AccountRow row) async {
    await _db.accountsDao.updateAccount(row.copyWith(isArchived: true));
  }

  /// Remove uma conta permanentemente. Só é permitido se não houver
  /// nenhuma aposta, movimentação ou lançamento vinculado — isso evita
  /// órfãos no extrato e preserva a integridade do histórico financeiro.
  Future<void> deleteAccount(int accountId) async {
    final bets = await (_db.select(_db.bets)..where((t) => t.accountId.equals(accountId))).get();
    if (bets.isNotEmpty) {
      throw ValidationException(
          'Não é possível excluir: existem apostas vinculadas a esta conta.');
    }
    final movements = await _db.movementsDao.getAll();
    final hasMovement = movements.any(
        (m) => m.sourceAccountId == accountId || m.destinationAccountId == accountId);
    if (hasMovement) {
      throw ValidationException(
          'Não é possível excluir: existem movimentações vinculadas a esta conta.');
    }
    final ledgerEntries = await _db.ledgerDao.getForAccount(accountId);
    if (ledgerEntries.isNotEmpty) {
      throw ValidationException(
          'Não é possível excluir: existem lançamentos vinculados a esta conta.');
    }
    await _db.accountsDao.deleteAccount(accountId);
  }
}
