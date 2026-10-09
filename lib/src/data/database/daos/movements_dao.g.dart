// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movements_dao.dart';

// ignore_for_file: type=lint
mixin _$MovementsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $MovementsTable get movements => attachedDatabase.movements;
  MovementsDaoManager get managers => MovementsDaoManager(this);
}

class MovementsDaoManager {
  final _$MovementsDaoMixin _db;
  MovementsDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$MovementsTableTableManager get movements =>
      $$MovementsTableTableManager(_db.attachedDatabase, _db.movements);
}
