// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_dao.dart';

// ignore_for_file: type=lint
mixin _$LedgerDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $BetsTable get bets => attachedDatabase.bets;
  $MovementsTable get movements => attachedDatabase.movements;
  $CdbYieldsTable get cdbYields => attachedDatabase.cdbYields;
  $LedgerEntriesTable get ledgerEntries => attachedDatabase.ledgerEntries;
  LedgerDaoManager get managers => LedgerDaoManager(this);
}

class LedgerDaoManager {
  final _$LedgerDaoMixin _db;
  LedgerDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$BetsTableTableManager get bets =>
      $$BetsTableTableManager(_db.attachedDatabase, _db.bets);
  $$MovementsTableTableManager get movements =>
      $$MovementsTableTableManager(_db.attachedDatabase, _db.movements);
  $$CdbYieldsTableTableManager get cdbYields =>
      $$CdbYieldsTableTableManager(_db.attachedDatabase, _db.cdbYields);
  $$LedgerEntriesTableTableManager get ledgerEntries =>
      $$LedgerEntriesTableTableManager(_db.attachedDatabase, _db.ledgerEntries);
}
