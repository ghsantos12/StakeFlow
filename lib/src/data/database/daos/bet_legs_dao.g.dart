// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_legs_dao.dart';

// ignore_for_file: type=lint
mixin _$BetLegsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $BetsTable get bets => attachedDatabase.bets;
  $BetLegsTable get betLegs => attachedDatabase.betLegs;
  BetLegsDaoManager get managers => BetLegsDaoManager(this);
}

class BetLegsDaoManager {
  final _$BetLegsDaoMixin _db;
  BetLegsDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$BetsTableTableManager get bets =>
      $$BetsTableTableManager(_db.attachedDatabase, _db.bets);
  $$BetLegsTableTableManager get betLegs =>
      $$BetLegsTableTableManager(_db.attachedDatabase, _db.betLegs);
}
