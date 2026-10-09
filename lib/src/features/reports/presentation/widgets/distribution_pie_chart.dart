import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../domain/services/analytics_calculations.dart';
import '../../../../domain/models/enums.dart';
import '../../../bets/presentation/widgets/bet_status_badge.dart';

class DistributionPieChart extends StatelessWidget {
  const DistributionPieChart({super.key, required this.distribution});

  final ResultDistribution distribution;

  @override
  Widget build(BuildContext context) {
    if (distribution.total == 0) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('Sem apostas encerradas neste período.')),
      );
    }

    final entries = <(BetStatus, int)>[
      (BetStatus.won, distribution.wonCount),
      (BetStatus.lost, distribution.lostCount),
      (BetStatus.voided, distribution.voidedCount),
      (BetStatus.cashedOut, distribution.cashedOutCount),
    ].where((e) => e.$2 > 0).toList();

    return Row(
      children: [
        SizedBox(
          width: 160,
          height: 160,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 36,
              sections: [
                for (final e in entries)
                  PieChartSectionData(
                    value: e.$2.toDouble(),
                    color: betStatusColor(e.$1),
                    title: '${((e.$2 / distribution.total) * 100).round()}%',
                    radius: 28,
                    titleStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final e in entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 5, backgroundColor: betStatusColor(e.$1)),
                      const SizedBox(width: 8),
                      Text('${betStatusLabel(e.$1)}: ${e.$2}'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
