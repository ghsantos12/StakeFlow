import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core_providers.dart';

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.watch(settingsRepositoryProvider).themeMode;

  Future<void> setThemeMode(ThemeMode mode) async {
    await ref.read(settingsRepositoryProvider).setThemeMode(mode);
    state = mode;
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class BlockInsufficientBalanceNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(settingsRepositoryProvider).blockInsufficientBalance;

  Future<void> setValue(bool value) async {
    await ref.read(settingsRepositoryProvider).setBlockInsufficientBalance(value);
    state = value;
  }
}

final blockInsufficientBalanceProvider =
    NotifierProvider<BlockInsufficientBalanceNotifier, bool>(BlockInsufficientBalanceNotifier.new);

class AnnualCdiRateNotifier extends Notifier<double> {
  @override
  double build() => ref.watch(settingsRepositoryProvider).annualCdiRatePercent;

  Future<void> setValue(double value) async {
    await ref.read(settingsRepositoryProvider).setAnnualCdiRatePercent(value);
    state = value;
  }
}

final annualCdiRateProvider =
    NotifierProvider<AnnualCdiRateNotifier, double>(AnnualCdiRateNotifier.new);

class BiometricEnabledNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(settingsRepositoryProvider).biometricEnabled;

  Future<void> setValue(bool value) async {
    await ref.read(settingsRepositoryProvider).setBiometricEnabled(value);
    state = value;
  }
}

final biometricEnabledProvider =
    NotifierProvider<BiometricEnabledNotifier, bool>(BiometricEnabledNotifier.new);
