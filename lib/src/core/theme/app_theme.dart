import 'package:flutter/material.dart';

/// Cores semânticas para lucro/prejuízo, usadas em todo o app.
class ProfitColors {
  ProfitColors._();

  static const Color profitLight = Color(0xFF1E8E5A);
  static const Color profitDark = Color(0xFF4ADE80);
  static const Color lossLight = Color(0xFFD64545);
  static const Color lossDark = Color(0xFFF87171);
  static const Color neutralLight = Color(0xFF6B7280);
  static const Color neutralDark = Color(0xFF9CA3AF);

  static Color profit(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? profitDark : profitLight;
  static Color loss(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? lossDark : lossLight;
  static Color neutral(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? neutralDark : neutralLight;

  static Color forCents(BuildContext context, int cents) {
    if (cents > 0) return profit(context);
    if (cents < 0) return loss(context);
    return neutral(context);
  }
}

class AppTheme {
  AppTheme._();

  static const Color _seed = Color(0xFF2563EB);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.light);
    return _base(scheme);
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark);
    return _base(scheme);
  }

  static ThemeData _base(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      visualDensity: VisualDensity.standard,
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainer,
        indicatorColor: scheme.primaryContainer,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            overflow: TextOverflow.visible,
          );
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
