import 'package:flutter/material.dart';

enum RangePreset {
  last7Days,
  last30Days,
  last90Days,
  currentYear,
  allTime,
  custom,
}

extension RangePresetX on RangePreset {
  String get label {
    switch (this) {
      case RangePreset.last7Days:
        return 'Últimos 7 dias';
      case RangePreset.last30Days:
        return 'Últimos 30 dias';
      case RangePreset.last90Days:
        return 'Últimos 90 dias';
      case RangePreset.currentYear:
        return 'Ano atual';
      case RangePreset.allTime:
        return 'Todo o período';
      case RangePreset.custom:
        return 'Intervalo personalizado';
    }
  }
}

/// Resolve um preset de período em um intervalo concreto de datas.
/// Retorna null para "todo o período" (sem limite inferior/superior).
DateTimeRange? resolveRange(RangePreset preset, {DateTimeRange? custom}) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  switch (preset) {
    case RangePreset.last7Days:
      return DateTimeRange(start: today.subtract(const Duration(days: 6)), end: today);
    case RangePreset.last30Days:
      return DateTimeRange(start: today.subtract(const Duration(days: 29)), end: today);
    case RangePreset.last90Days:
      return DateTimeRange(start: today.subtract(const Duration(days: 89)), end: today);
    case RangePreset.currentYear:
      return DateTimeRange(start: DateTime(now.year, 1, 1), end: today);
    case RangePreset.allTime:
      return null;
    case RangePreset.custom:
      return custom;
  }
}
