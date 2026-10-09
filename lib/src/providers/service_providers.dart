import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core_providers.dart';
import '../domain/services/account_service.dart';
import '../domain/services/bet_service.dart';
import '../domain/services/movement_service.dart';
import '../domain/services/cdb_service.dart';
import '../domain/services/analytics_service.dart';
import '../domain/services/backup_service.dart';
import '../domain/services/update_service.dart';

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
