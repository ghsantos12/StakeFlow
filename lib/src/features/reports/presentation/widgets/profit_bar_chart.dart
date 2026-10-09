import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/money.dart';

/// Gráfico de barras genérico para séries de lucro/prejuízo (verde para
/// valores positivos, vermelho para negativos).
class ProfitBarChart extends StatelessWidget {
  const ProfitBarChart({super.key, required this.values, required this.labels});

  final List<int> values;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text('Sem dados neste período.')),
      );
    }
    final maxAbs = values.map((v) => v.abs()).reduce((a, b) => a > b ? a : b).toDouble();
    final bound = maxAbs == 0 ? 100.0 : maxAbs / 100 * 1.2;

    return SizedBox(
      height: 240,
      child: BarChart(
        BarChartData(
          minY: -bound,
          maxY: bound,
          gridData: const FlGridData(drawVerticalLine: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 56,
                getTitlesWidget: (value, meta) => Text(
                  Money.formatCompact((value * 100).round()),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: (labels.length / 6).floor().clamp(1, 1 << 30).toDouble(),
                getTitlesWidget: (value, meta) {
                  final i = value.round();
                  if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(labels[i], style: const TextStyle(fontSize: 10)),
                  );
                },
              ),
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${labels[groupIndex]}\n${Money.format((rod.toY * 100).round())}',
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                );
              },
            ),
          ),
          barGroups: [
            for (var i = 0; i < values.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: values[i] / 100,
                    color: ProfitColors.forCents(context, values[i]),
                    width: (240 / values.length).clamp(4, 22),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
