import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/money.dart';

/// Texto monetário com cor automática (verde/vermelho/neutro) quando
/// [signed] é verdadeiro — usado para indicadores de lucro/prejuízo.
class MoneyText extends StatelessWidget {
  const MoneyText(
    this.cents, {
    super.key,
    this.signed = false,
    this.style,
    this.compact = false,
  });

  final int cents;
  final bool signed;
  final TextStyle? style;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final text = compact ? Money.formatCompact(cents) : Money.format(cents);
    final display = signed && cents > 0 ? '+$text' : text;
    final color = signed ? ProfitColors.forCents(context, cents) : null;
    return Text(
      display,
      style: (style ?? const TextStyle()).copyWith(color: color),
    );
  }
}
