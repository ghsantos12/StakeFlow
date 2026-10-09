import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../domain/services/financial_analytics_service.dart';
import '../../../../providers/financial_data_providers.dart';
import '../../../../providers/settings_providers.dart';

class FinancialDashboardScreen extends ConsumerWidget {
  const FinancialDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshotAsync = ref.watch(financialDashboardSnapshotProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão Financeira'),
        actions: [
          IconButton(
            tooltip: 'Trocar para Apostas',
            icon: const Icon(Icons.swap_horiz),
            onPressed: () async {
              await ref.read(lastModuleProvider.notifier).set('apostas');
              if (context.mounted) context.go('/');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(financialDashboardSnapshotProvider),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          children: [
            snapshotAsync.when(
              data: (s) => _DashboardGrid(snapshot: s),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Text('Erro ao carregar indicadores: $e'),
            ),
            const SizedBox(height: 24),
            Text('Ações rápidas', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _QuickAction(
                  icon: Icons.trending_down,
                  label: 'Nova despesa',
                  onTap: () => context.push('/financas/extrato/novo?tipo=expense'),
                ),
                _QuickAction(
                  icon: Icons.trending_up,
                  label: 'Nova receita',
                  onTap: () => context.push('/financas/extrato/novo?tipo=income'),
                ),
                _QuickAction(
                  icon: Icons.swap_horiz,
                  label: 'Transferência',
                  onTap: () => context.push('/financas/extrato/novo?tipo=transferBetweenAccounts'),
                ),
                _QuickAction(
                  icon: Icons.credit_card,
                  label: 'Compra no cartão',
                  onTap: () => context.push('/financas/cartoes'),
                ),
                _QuickAction(
                  icon: Icons.event_note,
                  label: 'Conta a pagar',
                  onTap: () => context.push('/financas/contas/pagar/novo'),
                ),
                _QuickAction(
                  icon: Icons.request_quote,
                  label: 'Conta a receber',
                  onTap: () => context.push('/financas/contas/receber/novo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardGrid extends StatelessWidget {
  const _DashboardGrid({required this.snapshot});
  final FinancialDashboardSnapshot snapshot;

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
          label: 'Saldo total das contas',
          icon: Icons.account_balance_wallet_outlined,
          value: MoneyText(s.totalBalanceCents, style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Receitas do mês',
          icon: Icons.trending_up,
          value: MoneyText(s.monthIncomeCents, signed: true, style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Despesas do mês',
          icon: Icons.trending_down,
          value: Text('-${Money.format(s.monthExpenseCents)}', style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Contas a pagar',
          icon: Icons.event_busy_outlined,
          value: Text(Money.format(s.totalPayableCents), style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Contas a receber',
          icon: Icons.event_available_outlined,
          value: Text(Money.format(s.totalReceivableCents), style: const TextStyle(fontSize: 20)),
        ),
        IndicatorTile(
          label: 'Faturas em aberto',
          icon: Icons.credit_card_outlined,
          value: Text(Money.format(s.openCardBillsCents), style: const TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
    );
  }
}
