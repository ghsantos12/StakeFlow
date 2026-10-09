// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bets_dao.dart';

// ignore_for_file: type=lint
mixin _$BetsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $BetsTable get bets => attachedDatabase.bets;
  BetsDaoManager get managers => BetsDaoManager(this);
}

class BetsDaoManager {
  final _$BetsDaoMixin _db;
  BetsDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$BetsTableTableManager get bets =>
      $$BetsTableTableManager(_db.attachedDatabase, _db.bets);
}
