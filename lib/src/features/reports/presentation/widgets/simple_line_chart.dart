import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/money.dart';

class SimpleLineChart extends StatelessWidget {
  const SimpleLineChart({
    super.key,
    required this.values,
    required this.labels,
    this.color,
  });

  final List<int> values;
  final List<String> labels;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (values.length < 2) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text('Sem dados suficientes neste período.')),
      );
    }
    final lineColor = color ?? Theme.of(context).colorScheme.primary;
    final minY = values.reduce((a, b) => a < b ? a : b);
    final maxY = values.reduce((a, b) => a > b ? a : b);
    final pad = ((maxY - minY).abs() * 0.1).clamp(100, 1 << 30).toDouble();

    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minY: minY / 100 - pad / 100,
          maxY: maxY / 100 + pad / 100,
          gridData: const FlGridData(drawVerticalLine: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 56,
                getTitlesWidget: (value, meta) =>
                    Text(Money.formatCompact((value * 100).round()), style: const TextStyle(fontSize: 10)),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: (labels.length / 5).floor().clamp(1, 1 << 30).toDouble(),
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
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (spots) => spots.map((s) {
                final i = s.x.round();
                return LineTooltipItem(
                  '${labels[i]}\n${Money.format((s.y * 100).round())}',
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                );
              }).toList(),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [for (var i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i] / 100)],
              isCurved: false,
              color: lineColor,
              barWidth: 2.5,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: true, color: lineColor.withValues(alpha: 0.12)),
            ),
          ],
        ),
      ),
    );
  }
}
