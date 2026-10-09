import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/app.dart';
import 'src/data/database/database.dart';
import 'src/data/repositories/settings_repository.dart';
import 'src/providers/core_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsRepository = await SettingsRepository.create();
  final database = AppDatabase();
  final initialLocation = settingsRepository.lastModule == 'financas' ? '/financas' : '/';

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
        settingsRepositoryProvider.overrideWithValue(settingsRepository),
      ],
      child: StakeFlowApp(initialLocation: initialLocation),
    ),
  );
}
