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
import 'tables/financial_categories_table.dart';
import 'tables/credit_cards_table.dart';
import 'tables/credit_card_bills_table.dart';
import 'tables/card_transactions_table.dart';
import 'tables/card_installments_table.dart';
import 'tables/credit_card_bill_payments_table.dart';
import 'tables/bills_payable_table.dart';
import 'tables/bills_receivable_table.dart';

import 'daos/accounts_dao.dart';
import 'daos/bets_dao.dart';
import 'daos/movements_dao.dart';
import 'daos/ledger_dao.dart';
import 'daos/cdb_yields_dao.dart';
import 'daos/financial_categories_dao.dart';
import 'daos/credit_cards_dao.dart';
import 'daos/credit_card_bills_dao.dart';
import 'daos/card_transactions_dao.dart';
import 'daos/card_installments_dao.dart';
import 'daos/credit_card_bill_payments_dao.dart';
import 'daos/bills_payable_dao.dart';
import 'daos/bills_receivable_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Accounts,
    Bets,
    Movements,
    CdbYields,
    LedgerEntries,
    FinancialCategories,
    CreditCards,
    CreditCardBills,
    CardTransactions,
    CardInstallments,
    CreditCardBillPayments,
    BillsPayable,
    BillsReceivable,
  ],
  daos: [
    AccountsDao,
    BetsDao,
    MovementsDao,
    LedgerDao,
    CdbYieldsDao,
    FinancialCategoriesDao,
    CreditCardsDao,
    CreditCardBillsDao,
    CardTransactionsDao,
    CardInstallmentsDao,
    CreditCardBillPaymentsDao,
    BillsPayableDao,
    BillsReceivableDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// Construtor para testes: usa um banco de dados em memória.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) => m.createAll(),
        onUpgrade: (Migrator m, int from, int to) async {
          // v1 -> v2: adiciona o módulo de gestão financeira pessoal, sem
          // apagar nem recriar nada do que já existia (apostas, contas,
          // movimentações, rendimentos de CDB, extrato).
          if (from < 2) {
            await m.addColumn(accounts, accounts.bankAccountKind);
            await m.addColumn(accounts, accounts.colorValue);

            await m.createTable(financialCategories);
            await m.createTable(creditCards);
            await m.createTable(creditCardBills);
            await m.createTable(cardTransactions);
            await m.createTable(cardInstallments);
            await m.createTable(creditCardBillPayments);
            await m.createTable(billsPayable);
            await m.createTable(billsReceivable);

            await m.addColumn(movements, movements.categoryId);
            await m.addColumn(movements, movements.reconciled);
            await m.addColumn(movements, movements.payableId);
            await m.addColumn(movements, movements.receivableId);

            await m.addColumn(ledgerEntries, ledgerEntries.creditCardBillPaymentId);
          }
        },
      );

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
