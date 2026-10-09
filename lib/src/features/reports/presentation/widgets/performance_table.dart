import 'package:flutter/material.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/widgets/money_text.dart';

class PerformanceRow {
  const PerformanceRow({
    required this.label,
    required this.betCount,
    required this.stakeCents,
    required this.profitCents,
    required this.roi,
    required this.hitRate,
  });

  final String label;
  final int betCount;
  final int stakeCents;
  final int profitCents;
  final double roi;
  final double hitRate;
}

class PerformanceTable extends StatelessWidget {
  const PerformanceTable({super.key, required this.rows});

  final List<PerformanceRow> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: Text('Sem dados neste período.')),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        columns: const [
          DataColumn(label: Text('')),
          DataColumn(label: Text('Apostas')),
          DataColumn(label: Text('Stake total')),
          DataColumn(label: Text('Lucro líquido')),
          DataColumn(label: Text('ROI')),
          DataColumn(label: Text('Acerto')),
        ],
        rows: [
          for (final r in rows)
            DataRow(cells: [
              DataCell(Text(r.label)),
              DataCell(Text('${r.betCount}')),
              DataCell(Text(Money.format(r.stakeCents))),
              DataCell(MoneyText(r.profitCents, signed: true)),
              DataCell(Text('${r.roi.toStringAsFixed(1)}%')),
              DataCell(Text('${r.hitRate.toStringAsFixed(1)}%')),
            ]),
        ],
      ),
    );
  }
}
