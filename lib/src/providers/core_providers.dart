import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/database/database.dart';
import '../data/repositories/settings_repository.dart';

/// Instanciados em main() antes de runApp() e injetados via
/// ProviderScope(overrides: [...]), para que toda a árvore de widgets
/// tenha acesso síncrono ao banco de dados e às configurações já
/// carregadas, sem precisar lidar com AsyncValue em todo lugar.
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('databaseProvider deve ser sobrescrito em main()');
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  throw UnimplementedError('settingsRepositoryProvider deve ser sobrescrito em main()');
});

/// Emite um evento sempre que qualquer tabela do banco é alterada.
/// Providers de leitura observam este stream para se recalcular
/// automaticamente após qualquer criação/edição/exclusão.
final dbChangesProvider = StreamProvider<void>((ref) {
  final db = ref.watch(databaseProvider);
  return db.tableUpdates().map((_) {});
});
