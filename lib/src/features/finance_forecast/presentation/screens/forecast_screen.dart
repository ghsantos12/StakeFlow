import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../domain/models/enums.dart';
import '../../../../domain/services/forecast_service.dart';
import '../../../../providers/data_providers.dart';
import '../../../../providers/financial_data_providers.dart';
import '../../../../providers/service_providers.dart';
import '../../../../providers/settings_providers.dart';
import '../../../reports/presentation/widgets/simple_line_chart.dart';

class ForecastScreen extends ConsumerWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountsStreamProvider);
    final selectedAccountId = ref.watch(forecastAccountProvider);
    final forecastAsync = ref.watch(forecastProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Previsão de saldo')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          accountsAsync.when(
            data: (accounts) {
              final banks = accounts.where((a) => a.type == AccountType.bank).toList();
              return DropdownButtonFormField<int?>(
                initialValue: banks.any((a) => a.id == selectedAccountId) ? selectedAccountId : null,
                decoration: const InputDecoration(labelText: 'Conta'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Todas as contas (consolidado)')),
                  for (final a in banks) DropdownMenuItem(value: a.id, child: Text(a.name)),
                ],
                onChanged: (v) => ref.read(forecastAccountProvider.notifier).select(v),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          forecastAsync.when(
            data: (forecast) => _ForecastBody(forecast: forecast, accountId: selectedAccountId),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Text('Erro ao calcular previsão: $e'),
          ),
        ],
      ),
    );
  }
}

class _ForecastBody extends ConsumerWidget {
  const _ForecastBody({required this.forecast, required this.accountId});
  final ForecastSummary forecast;
  final int? accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            IndicatorTile(label: 'Saldo atual', value: MoneyText(forecast.currentBalanceCents)),
            IndicatorTile(label: 'Fim do mês', value: MoneyText(forecast.endOfMonthCents)),
            IndicatorTile(label: 'Próximo mês', value: MoneyText(forecast.nextMonthCents)),
            IndicatorTile(label: 'Em 3 meses', value: MoneyText(forecast.in3MonthsCents)),
            IndicatorTile(label: 'Em 6 meses', value: MoneyText(forecast.in6MonthsCents)),
            IndicatorTile(label: 'Em 12 meses', value: MoneyText(forecast.in12MonthsCents)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: IndicatorTile(
                label: 'Total previsto de entradas',
                value: MoneyText(forecast.totalExpectedIncomeCents),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: IndicatorTile(
                label: 'Total previsto de saídas',
                value: Text('-${Money.format(forecast.totalExpectedExpensesCents.abs())}'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        IndicatorTile(
          label: 'Menor saldo projetado no período',
          value: MoneyText(forecast.lowestProjectedBalanceCents),
        ),
        const SizedBox(height: 20),
        Text('Saldo projetado (12 meses)', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SectionCard(
          child: SimpleLineChart(
            values: [for (final p in forecast.points) p.balanceCents],
            labels: [for (final p in forecast.points) formatDateShort(p.date)],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'A projeção considera apenas contas a pagar/receber e faturas de cartão pendentes. '
          'Não inclui lucro futuro de apostas nem o limite do cartão como dinheiro disponível.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.outline),
        ),
        const SizedBox(height: 20),
        _CdbScenario(accountId: accountId, forecast: forecast),
        const SizedBox(height: 20),
        Text('Eventos previstos', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (forecast.events.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text('Nenhum evento pendente neste período.'),
          )
        else
          Card(
            child: Column(
              children: [
                for (final e in forecast.events)
                  ListTile(
                    leading: Icon(
                      e.amountCents >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                      color: e.amountCents >= 0 ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                    ),
                    title: Text(e.description),
                    subtitle: Text(formatDate(e.date)),
                    trailing: MoneyText(e.amountCents, signed: true),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CdbScenario extends ConsumerWidget {
  const _CdbScenario({required this.accountId, required this.forecast});
  final int? accountId;
  final ForecastSummary forecast;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (accountId == null) {
      return SectionCard(
        child: Text(
          'Selecione uma conta específica com percentual de CDI configurado para ver a estimativa de '
          'rendimento de CDB neste período.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }
    final accountsAsync = ref.watch(accountsStreamProvider);
    return accountsAsync.when(
      data: (accounts) {
        final account = accounts.where((a) => a.id == accountId).firstOrNull;
        if (account == null || account.cdiPercent == null) {
          return SectionCard(
            child: Text(
              'Esta conta não tem percentual de CDI configurado — sem estimativa de CDB para o período.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        }
        final estimation = ref.watch(cdbEstimationServiceProvider);
        final annualRate = ref.watch(annualCdiRateProvider);
        var balance = forecast.currentBalanceCents;
        var totalYield = 0;
        for (final point in forecast.points) {
          totalYield += estimation.estimateDailyYieldCents(
            currentBalanceCents: balance,
            annualCdiRatePercent: annualRate,
            accountCdiPercent: account.cdiPercent!,
            day: point.date,
          );
          balance = point.balanceCents + totalYield;
        }
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.savings_outlined, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Cenário estimado: rendimento de CDB',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Estimativa informativa (${account.cdiPercent!.toStringAsFixed(0)}% do CDI), não garantida — '
                'considera apenas dias úteis e não altera o saldo real.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Rendimento estimado no período: '),
                  MoneyText(totalYield, signed: true),
                ],
              ),
              Row(
                children: [
                  const Text('Saldo final estimado com CDB: '),
                  MoneyText(balance, signed: true),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
