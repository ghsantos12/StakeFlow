import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Persiste preferências do aplicativo (tema, segurança, parâmetros de
/// cálculo) usando SharedPreferences para dados simples e
/// FlutterSecureStorage para o PIN (armazenado como hash, nunca em texto
/// puro).
class SettingsRepository {
  SettingsRepository(this._prefs);

  final SharedPreferences _prefs;
  static const _secureStorage = FlutterSecureStorage();

  static const _kThemeMode = 'theme_mode';
  static const _kBlockInsufficientBalance = 'block_insufficient_balance';
  static const _kAnnualCdiRate = 'annual_cdi_rate';
  static const _kBiometricEnabled = 'biometric_enabled';
  static const _kPinHash = 'pin_hash';
  static const _kLastModule = 'last_module';

  static Future<SettingsRepository> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SettingsRepository(prefs);
  }

  ThemeMode get themeMode {
    final value = _prefs.getString(_kThemeMode);
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_kThemeMode, mode.name);
  }

  /// Se verdadeiro (padrão), o app bloqueia movimentações/apostas que
  /// excedam o saldo disponível da conta de origem.
  bool get blockInsufficientBalance => _prefs.getBool(_kBlockInsufficientBalance) ?? true;

  Future<void> setBlockInsufficientBalance(bool value) async {
    await _prefs.setBool(_kBlockInsufficientBalance, value);
  }

  /// Taxa anual do CDI (%) usada apenas para estimativas de rendimento.
  double get annualCdiRatePercent => _prefs.getDouble(_kAnnualCdiRate) ?? 10.5;

  Future<void> setAnnualCdiRatePercent(double value) async {
    await _prefs.setDouble(_kAnnualCdiRate, value);
  }

  bool get biometricEnabled => _prefs.getBool(_kBiometricEnabled) ?? false;

  Future<void> setBiometricEnabled(bool value) async {
    await _prefs.setBool(_kBiometricEnabled, value);
  }

  Future<bool> hasPin() async {
    final hash = await _secureStorage.read(key: _kPinHash);
    return hash != null && hash.isNotEmpty;
  }

  Future<void> setPin(String pin) async {
    final hash = sha256.convert(utf8.encode(pin)).toString();
    await _secureStorage.write(key: _kPinHash, value: hash);
  }

  Future<void> clearPin() async {
    await _secureStorage.delete(key: _kPinHash);
  }

  Future<bool> verifyPin(String pin) async {
    final hash = await _secureStorage.read(key: _kPinHash);
    if (hash == null) return false;
    final candidate = sha256.convert(utf8.encode(pin)).toString();
    return candidate == hash;
  }

  /// Último módulo acessado ('apostas' ou 'financas'), usado para abrir
  /// direto nele na próxima vez que o app for iniciado.
  String get lastModule => _prefs.getString(_kLastModule) ?? 'apostas';

  Future<void> setLastModule(String module) async {
    await _prefs.setString(_kLastModule, module);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
    await _secureStorage.deleteAll();
  }
}
