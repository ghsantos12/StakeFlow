import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../domain/services/analytics_calculations.dart';

class PatrimonyChart extends StatefulWidget {
  const PatrimonyChart({super.key, required this.points});

  final List<PatrimonyPoint> points;

  @override
  State<PatrimonyChart> createState() => _PatrimonyChartState();
}

class _PatrimonyChartState extends State<PatrimonyChart> {
  bool _showTotal = true;
  bool _showBank = false;
  bool _showBookmakers = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (widget.points.length < 2) {
      return SizedBox(
        height: 220,
        child: Center(
          child: Text(
            'Sem dados suficientes para o gráfico neste período.',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
        ),
      );
    }

    final totalColor = scheme.primary;
    const bankColor = Color(0xFF16A34A);
    const bookmakersColor = Color(0xFFF59E0B);

    double toReais(int cents) => cents / 100;

    final minY = widget.points
        .expand((p) => [p.totalCents, p.bankCents, p.bookmakersCents])
        .reduce((a, b) => a < b ? a : b);
    final maxY = widget.points
        .expand((p) => [p.totalCents, p.bankCents, p.bookmakersCents])
        .reduce((a, b) => a > b ? a : b);
    final padding = ((maxY - minY).abs() * 0.1).clamp(100, 1 << 30).toDouble();

    List<FlSpot> spotsFor(int Function(PatrimonyPoint) selector) => [
          for (var i = 0; i < widget.points.length; i++)
            FlSpot(i.toDouble(), toReais(selector(widget.points[i]))),
        ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: [
            _legendChip('Patrimônio total', totalColor, _showTotal, (v) => setState(() => _showTotal = v)),
            _legendChip('Saldo bancário', bankColor, _showBank, (v) => setState(() => _showBank = v)),
            _legendChip(
                'Casas de apostas', bookmakersColor, _showBookmakers, (v) => setState(() => _showBookmakers = v)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 240,
          child: LineChart(
            LineChartData(
              minY: toReais(minY) - padding / 100,
              maxY: toReais(maxY) + padding / 100,
              gridData: const FlGridData(drawVerticalLine: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 56,
                    getTitlesWidget: (value, meta) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text(
                        Money.formatCompact((value * 100).round()),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    interval: (widget.points.length / 5).floor().clamp(1, 1 << 30).toDouble(),
                    getTitlesWidget: (value, meta) {
                      final i = value.round();
                      if (i < 0 || i >= widget.points.length) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(formatDate(widget.points[i].date), style: const TextStyle(fontSize: 10)),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (spots) => spots.map((s) {
                    final i = s.x.round();
                    final date = formatDate(widget.points[i].date);
                    return LineTooltipItem(
                      '$date\n${Money.format((s.y * 100).round())}',
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                    );
                  }).toList(),
                ),
              ),
              lineBarsData: [
                if (_showTotal) _line(spotsFor((p) => p.totalCents), totalColor),
                if (_showBank) _line(spotsFor((p) => p.bankCents), bankColor),
                if (_showBookmakers) _line(spotsFor((p) => p.bookmakersCents), bookmakersColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LineChartBarData _line(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: false,
      color: color,
      barWidth: 2.5,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  Widget _legendChip(String label, Color color, bool selected, ValueChanged<bool> onChanged) {
    return FilterChip(
      label: Text(label),
      avatar: CircleAvatar(backgroundColor: color, radius: 6),
      selected: selected,
      onSelected: onChanged,
      visualDensity: VisualDensity.compact,
    );
  }
}
