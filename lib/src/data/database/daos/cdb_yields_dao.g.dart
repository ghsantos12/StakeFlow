// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cdb_yields_dao.dart';

// ignore_for_file: type=lint
mixin _$CdbYieldsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $CdbYieldsTable get cdbYields => attachedDatabase.cdbYields;
  CdbYieldsDaoManager get managers => CdbYieldsDaoManager(this);
}

class CdbYieldsDaoManager {
  final _$CdbYieldsDaoMixin _db;
  CdbYieldsDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$CdbYieldsTableTableManager get cdbYields =>
      $$CdbYieldsTableTableManager(_db.attachedDatabase, _db.cdbYields);
}
