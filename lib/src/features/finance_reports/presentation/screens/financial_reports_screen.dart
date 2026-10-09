import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../core/widgets/range_filter_bar.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../domain/services/analytics_calculations.dart';
import '../../../../domain/services/financial_analytics_calculations.dart';
import '../../../../providers/financial_data_providers.dart';
import '../../../../providers/service_providers.dart';
import '../../../reports/presentation/widgets/profit_bar_chart.dart';
import '../../../reports/presentation/widgets/simple_line_chart.dart';

class FinancialReportsScreen extends ConsumerWidget {
  const FinancialReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Relatórios financeiros'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Visão geral'),
            Tab(text: 'Categorias'),
            Tab(text: 'Cartões'),
            Tab(text: 'Patrimônio'),
          ]),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: RangeFilterBar(provider: financialReportsRangeProvider),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final bundleAsync = ref.watch(financialReportsBundleProvider);
                  return bundleAsync.when(
                    data: (bundle) => TabBarView(
                      children: [
                        _OverviewTab(bundle: bundle),
                        _CategoriesTab(bundle: bundle),
                        _CardsTab(bundle: bundle),
                        const _PatrimonyTab(),
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
  final FinancialReportsBundle bundle;

  @override
  Widget build(BuildContext context) {
    final cf = bundle.cashFlow;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        Text('Fluxo de caixa no período', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            IndicatorTile(label: 'Receitas', value: MoneyText(cf.totalIncomeCents)),
            IndicatorTile(label: 'Despesas', value: Text('-${Money.format(cf.totalExpenseCents)}')),
            IndicatorTile(label: 'Resultado', value: MoneyText(cf.netCents, signed: true)),
            IndicatorTile(label: 'Saldo atual', value: MoneyText(cf.endingBalanceCents)),
          ],
        ),
        const SizedBox(height: 20),
        Text('Receitas x despesas por mês', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(
          child: ProfitBarChart(
            values: [for (final m in bundle.monthly) m.netCents],
            labels: [for (final m in bundle.monthly) monthLabel(m.year, m.month)],
          ),
        ),
      ],
    );
  }
}

class _CategoriesTab extends StatelessWidget {
  const _CategoriesTab({required this.bundle});
  final FinancialReportsBundle bundle;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        Text('Despesas por categoria', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (bundle.expensesByCategory.isEmpty)
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Sem despesas neste período.'))
        else
          SectionCard(child: _CategoryBreakdown(totals: bundle.expensesByCategory)),
        const SizedBox(height: 20),
        Text('Receitas por categoria', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (bundle.incomeByCategory.isEmpty)
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Sem receitas neste período.'))
        else
          SectionCard(child: _CategoryBreakdown(totals: bundle.incomeByCategory)),
      ],
    );
  }
}

class _CategoryBreakdown extends StatelessWidget {
  const _CategoryBreakdown({required this.totals});
  final List<CategoryTotal> totals;

  @override
  Widget build(BuildContext context) {
    final total = totals.fold<int>(0, (s, t) => s + t.totalCents);
    return Column(
      children: [
        for (final t in totals)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(t.categoryName)),
                    Text(Money.format(t.totalCents)),
                    const SizedBox(width: 8),
                    Text(
                      total == 0 ? '0%' : '${((t.totalCents / total) * 100).round()}%',
                      style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: total == 0 ? 0 : t.totalCents / total,
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CardsTab extends StatelessWidget {
  const _CardsTab({required this.bundle});
  final FinancialReportsBundle bundle;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        Text('Gastos por cartão no período', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (bundle.cardSpending.isEmpty)
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Sem lançamentos de cartão neste período.'))
        else
          Card(
            child: Column(
              children: [
                for (final c in bundle.cardSpending)
                  ListTile(
                    leading: const Icon(Icons.credit_card_outlined),
                    title: Text(c.cardName),
                    trailing: MoneyText(c.totalCents),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PatrimonyTab extends ConsumerWidget {
  const _PatrimonyTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(financialReportsRangeProvider).resolve();
    final seriesAsync = ref.watch(_bankBalanceSeriesProvider((from: range?.start, to: range?.end)));
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        Text('Evolução do saldo bancário', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        seriesAsync.when(
          data: (series) => SectionCard(
            child: SimpleLineChart(
              values: [for (final d in series) d.valueCents],
              labels: [for (final d in series) formatDateShort(d.date)],
              color: const Color(0xFF16A34A),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Erro: $e'),
        ),
      ],
    );
  }
}

final _bankBalanceSeriesProvider =
    FutureProvider.family<List<DatedValue>, ({DateTime? from, DateTime? to})>((ref, range) async {
  final service = ref.watch(analyticsServiceProvider);
  return service.bankBalanceSeries(from: range.from, to: range.to);
});
