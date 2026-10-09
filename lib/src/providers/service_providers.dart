import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core_providers.dart';
import '../domain/services/account_service.dart';
import '../domain/services/bet_service.dart';
import '../domain/services/movement_service.dart';
import '../domain/services/cdb_service.dart';
import '../domain/services/analytics_service.dart';
import '../domain/services/backup_service.dart';
import '../domain/services/update_service.dart';
import '../domain/services/category_service.dart';
import '../domain/services/credit_card_service.dart';
import '../domain/services/bills_payable_service.dart';
import '../domain/services/bills_receivable_service.dart';
import '../domain/services/forecast_service.dart';
import '../domain/services/financial_analytics_service.dart';

final accountServiceProvider = Provider<AccountService>((ref) {
  return AccountService(ref.watch(databaseProvider));
});

final betServiceProvider = Provider<BetService>((ref) {
  return BetService(ref.watch(databaseProvider), ref.watch(settingsRepositoryProvider));
});

final movementServiceProvider = Provider<MovementService>((ref) {
  return MovementService(ref.watch(databaseProvider), ref.watch(settingsRepositoryProvider));
});

final cdbYieldServiceProvider = Provider<CdbYieldService>((ref) {
  return CdbYieldService(ref.watch(databaseProvider));
});

final cdbEstimationServiceProvider = Provider<CdbEstimationService>((ref) {
  return CdbEstimationService();
});

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService(ref.watch(databaseProvider));
});

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(ref.watch(databaseProvider));
});

final updateServiceProvider = Provider<UpdateService>((ref) {
  return UpdateService();
});

final categoryServiceProvider = Provider<CategoryService>((ref) {
  return CategoryService(ref.watch(databaseProvider));
});

final creditCardServiceProvider = Provider<CreditCardService>((ref) {
  return CreditCardService(ref.watch(databaseProvider), ref.watch(settingsRepositoryProvider));
});

final billsPayableServiceProvider = Provider<BillsPayableService>((ref) {
  return BillsPayableService(ref.watch(databaseProvider), ref.watch(movementServiceProvider));
});

final billsReceivableServiceProvider = Provider<BillsReceivableService>((ref) {
  return BillsReceivableService(ref.watch(databaseProvider), ref.watch(movementServiceProvider));
});

final forecastServiceProvider = Provider<ForecastService>((ref) {
  return ForecastService(
    ref.watch(databaseProvider),
    ref.watch(accountServiceProvider),
    ref.watch(billsPayableServiceProvider),
    ref.watch(billsReceivableServiceProvider),
    ref.watch(creditCardServiceProvider),
  );
});

final financialAnalyticsServiceProvider = Provider<FinancialAnalyticsService>((ref) {
  return FinancialAnalyticsService(ref.watch(databaseProvider), ref.watch(accountServiceProvider));
});
