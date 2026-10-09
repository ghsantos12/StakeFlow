import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../../domain/models/enums.dart';
import 'tables/accounts_table.dart';
import 'tables/bets_table.dart';
import 'tables/movements_table.dart';
import 'tables/cdb_yields_table.dart';
import 'tables/ledger_entries_table.dart';

import 'daos/accounts_dao.dart';
import 'daos/bets_dao.dart';
import 'daos/movements_dao.dart';
import 'daos/ledger_dao.dart';
import 'daos/cdb_yields_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Accounts, Bets, Movements, CdbYields, LedgerEntries],
  daos: [AccountsDao, BetsDao, MovementsDao, LedgerDao, CdbYieldsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// Construtor para testes: usa um banco de dados em memória.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'stakeflow.sqlite'));
      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }
      return NativeDatabase.createInBackground(file);
    });
  }
}
