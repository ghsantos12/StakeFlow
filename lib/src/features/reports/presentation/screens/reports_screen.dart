import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../core/widgets/range_filter_bar.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../providers/data_providers.dart';
import '../../../dashboard/presentation/widgets/patrimony_chart.dart';
import '../widgets/distribution_pie_chart.dart';
import '../widgets/performance_table.dart';
import '../widgets/profit_bar_chart.dart';
import '../widgets/simple_line_chart.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Relatórios'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Visão geral'),
            Tab(text: 'Apostas'),
            Tab(text: 'CDB'),
          ]),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: RangeFilterBar(provider: reportsRangeProvider),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final bundleAsync = ref.watch(reportsBundleProvider);
                  return bundleAsync.when(
                    data: (bundle) => TabBarView(
                      children: [
                        _OverviewTab(bundle: bundle),
                        _BetsTab(bundle: bundle),
                        _CdbTab(bundle: bundle),
                      ],
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('Erro: $e')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.bundle});
  final ReportsBundle bundle;

  @override
  Widget build(BuildContext context) {
    final ind = bundle.indicators;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        Text('Patrimônio', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(child: PatrimonyChart(points: bundle.patrimony)),
        const SizedBox(height: 20),
        Text('Distribuição de resultados', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(child: DistributionPieChart(distribution: bundle.distribution)),
        const SizedBox(height: 20),
        Text('Indicadores financeiros', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: [
            IndicatorTile(label: 'Total apostado', value: Text(Money.format(ind.totalStakedSettled))),
            IndicatorTile(label: 'Total de retornos', value: Text(Money.format(ind.totalReturns))),
            IndicatorTile(
                label: 'Lucro bruto (ganhas)',
                value: MoneyText(ind.grossProfitWon, signed: true)),
            IndicatorTile(label: 'Prejuízo (perdidas)', value: Text('-${Money.format(ind.lossFromLost)}')),
            IndicatorTile(
                label: 'Resultado em cashouts', value: MoneyText(ind.netResultCashouts, signed: true)),
            IndicatorTile(
                label: 'Lucro líquido operacional',
                value: MoneyText(ind.netOperationalProfitCents, signed: true)),
            IndicatorTile(label: 'ROI', value: Text('${ind.roi.toStringAsFixed(1)}%')),
            IndicatorTile(label: 'Taxa de acerto', value: Text('${ind.hitRate.toStringAsFixed(1)}%')),
            IndicatorTile(label: 'Odd média', value: Text(ind.averageOdds.toStringAsFixed(2))),
            IndicatorTile(label: 'Stake média', value: Text(Money.format(ind.averageStakeCents))),
            IndicatorTile(label: 'Maior lucro', value: MoneyText(ind.biggestWinCents, signed: true)),
            IndicatorTile(label: 'Maior prejuízo', value: MoneyText(ind.biggestLossCents, signed: true)),
            IndicatorTile(
                label: 'Resultado 7 dias', value: MoneyText(ind.last7DaysResultCents, signed: true)),
            IndicatorTile(
                label: 'Resultado 30 dias', value: MoneyText(ind.last30DaysResultCents, signed: true)),
            IndicatorTile(label: 'Apostas encerradas', value: Text('${ind.settledCount}')),
            IndicatorTile(label: 'Apostas em aberto', value: Text('${ind.openCount}')),
            IndicatorTile(label: 'Despesas/taxas', value: Text('-${Money.format(ind.totalFeesCents)}')),
          ],
        ),
      ],
    );
  }
}

class _BetsTab extends StatelessWidget {
  const _BetsTab({required this.bundle});
  final ReportsBundle bundle;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        Text('Lucro e prejuízo diário', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(
          child: ProfitBarChart(
            values: [for (final d in bundle.dailyProfit) d.valueCents],
            labels: [for (final d in bundle.dailyProfit) formatDate(d.date)],
          ),
        ),
        const SizedBox(height: 20),
        Text('Lucro acumulado', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(
          child: SimpleLineChart(
            values: [for (final d in bundle.cumulativeProfit) d.valueCents],
            labels: [for (final d in bundle.cumulativeProfit) formatDate(d.date)],
          ),
        ),
        const SizedBox(height: 20),
        Text('Resultados mensais', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(
          child: ProfitBarChart(
            values: [for (final m in bundle.monthlyResults) m.valueCents],
            labels: [for (final m in bundle.monthlyResults) monthLabel(m.year, m.month)],
          ),
        ),
        const SizedBox(height: 20),
        Text('Desempenho por esporte', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(
          child: PerformanceTable(
            rows: [
              for (final s in bundle.sportPerformance)
                PerformanceRow(
                  label: s.sport,
                  betCount: s.betCount,
                  stakeCents: s.totalStakeCents,
                  profitCents: s.netProfitCents,
                  roi: s.roi,
                  hitRate: s.hitRate,
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text('Desempenho por casa de apostas', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(
          child: PerformanceTable(
            rows: [
              for (final b in bundle.bookmakerPerformance)
                PerformanceRow(
                  label: b.accountName,
                  betCount: b.betCount,
                  stakeCents: b.totalStakeCents,
                  profitCents: b.netProfitCents,
                  roi: b.roi,
                  hitRate: b.hitRate,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CdbTab extends StatelessWidget {
  const _CdbTab({required this.bundle});
  final ReportsBundle bundle;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        Text('Evolução do saldo bancário', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(
          child: SimpleLineChart(
            values: [for (final d in bundle.bankBalance) d.valueCents],
            labels: [for (final d in bundle.bankBalance) formatDate(d.date)],
            color: const Color(0xFF16A34A),
          ),
        ),
        const SizedBox(height: 20),
        Text('Rendimento diário do CDB', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(
          child: ProfitBarChart(
            values: [for (final d in bundle.cdbDaily) d.valueCents],
            labels: [for (final d in bundle.cdbDaily) formatDate(d.date)],
          ),
        ),
        const SizedBox(height: 20),
        Text('Comparativo mensal: apostas vs. CDB', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(
          child: _ComparisonLegendChart(bundle: bundle),
        ),
        const SizedBox(height: 20),
        Text('Rendimento mensal do CDB', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(
          child: ProfitBarChart(
            values: [for (final m in bundle.cdbMonthly) m.valueCents],
            labels: [for (final m in bundle.cdbMonthly) monthLabel(m.year, m.month)],
          ),
        ),
      ],
    );
  }
}

class _ComparisonLegendChart extends StatelessWidget {
  const _ComparisonLegendChart({required this.bundle});
  final ReportsBundle bundle;

  @override
  Widget build(BuildContext context) {
    if (bundle.betsVsCdb.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: Text('Sem dados neste período.')),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final m in bundle.betsVsCdb)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(width: 56, child: Text(monthLabel(m.year, m.month))),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      const Text('Apostas: '),
                      MoneyText(m.betsProfitCents, signed: true),
                      const SizedBox(width: 16),
                      const Text('CDB: '),
                      MoneyText(m.cdbYieldCents, signed: true),
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
