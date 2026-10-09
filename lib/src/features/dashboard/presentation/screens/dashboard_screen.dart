import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/range_filter_bar.dart';
import '../../../../providers/data_providers.dart';
import '../../../../providers/settings_providers.dart';
import '../../../../domain/services/analytics_service.dart';
import '../widgets/patrimony_chart.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshotAsync = ref.watch(dashboardSnapshotProvider);
    final patrimonyAsync = ref.watch(dashboardPatrimonyHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StakeFlow'),
        actions: [
          IconButton(
            tooltip: 'Trocar para Gestão Financeira',
            icon: const Icon(Icons.swap_horiz),
            onPressed: () async {
              await ref.read(lastModuleProvider.notifier).set('financas');
              if (context.mounted) context.go('/financas');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/bets/new'),
        icon: const Icon(Icons.add),
        label: const Text('Nova aposta'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardSnapshotProvider);
          ref.invalidate(dashboardPatrimonyHistoryProvider);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          children: [
            snapshotAsync.when(
              data: (s) => _IndicatorsGrid(snapshot: s),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Text('Erro ao carregar indicadores: $e'),
            ),
            const SizedBox(height: 24),
            Text('Evolução do patrimônio', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            RangeFilterBar(provider: dashboardRangeProvider),
            const SizedBox(height: 12),
            SectionCard(
              child: patrimonyAsync.when(
                data: (points) => PatrimonyChart(points: points),
                loading: () => const SizedBox(
                  height: 220,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => SizedBox(height: 220, child: Center(child: Text('Erro: $e'))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IndicatorsGrid extends StatelessWidget {
  const _IndicatorsGrid({required this.snapshot});

  final DashboardSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final s = snapshot;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.25,
      children: [
        IndicatorTile(
          label: 'Patrimônio total',
          icon: Icons.account_balance_wallet_outlined,
          value: MoneyText(s.totalPatrimonyCents, style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Saldo bancário',
          icon: Icons.account_balance_outlined,
          value: MoneyText(s.bankBalanceCents, style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Disponível nas casas',
          icon: Icons.casino_outlined,
          value: MoneyText(s.bookmakersAvailableCents, style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Comprometido em apostas',
          icon: Icons.lock_clock_outlined,
          value: MoneyText(s.bookmakersCommittedCents, style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Lucro acumulado (apostas)',
          icon: Icons.trending_up,
          value: MoneyText(s.accumulatedBetsProfitCents, signed: true, style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Lucro total acumulado',
          icon: Icons.stacked_line_chart,
          value: MoneyText(s.totalAccumulatedProfitCents, signed: true, style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Resultado hoje',
          icon: Icons.today_outlined,
          value: MoneyText(s.todayBetsProfitCents, signed: true, style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Resultado no mês',
          icon: Icons.calendar_month_outlined,
          value: MoneyText(s.monthBetsProfitCents, signed: true, style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'ROI (apostas encerradas)',
          icon: Icons.percent,
          value: Text('${s.roiClosedBets.toStringAsFixed(1)}%'),
        ),
        IndicatorTile(
          label: 'Taxa de acerto',
          icon: Icons.check_circle_outline,
          value: Text('${s.hitRate.toStringAsFixed(1)}%'),
        ),
        IndicatorTile(
          label: 'Apostas realizadas',
          icon: Icons.format_list_numbered,
          value: Text('${s.totalBetsCount}'),
        ),
        IndicatorTile(
          label: 'Rendimento CDB (mês)',
          icon: Icons.savings_outlined,
          value: MoneyText(s.monthCdbYieldCents, signed: true, style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Rendimento CDB acumulado',
          icon: Icons.account_balance_outlined,
          value: MoneyText(s.accumulatedCdbYieldCents, signed: true, style: const TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}
