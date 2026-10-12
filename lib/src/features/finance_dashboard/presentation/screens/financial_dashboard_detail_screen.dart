import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../data/database/database.dart';
import '../../../../domain/models/enums.dart';
import '../../../../domain/services/financial_analytics_service.dart';
import '../../../../providers/data_providers.dart';
import '../../../../providers/financial_data_providers.dart';
import '../../../transactions/presentation/widgets/movement_type_label.dart';

/// Qual card do dashboard financeiro originou a navegação para esta tela
/// de detalhe — determina o que é listado.
enum DashboardMetric { balance, income, expense, payable, receivable, cardBills }

DashboardMetric? dashboardMetricFromName(String name) {
  for (final m in DashboardMetric.values) {
    if (m.name == name) return m;
  }
  return null;
}

extension on DashboardMetric {
  String get title {
    switch (this) {
      case DashboardMetric.balance:
        return 'Saldo total das contas';
      case DashboardMetric.income:
        return 'Receitas do mês';
      case DashboardMetric.expense:
        return 'Despesas do mês';
      case DashboardMetric.payable:
        return 'Contas a pagar';
      case DashboardMetric.receivable:
        return 'Contas a receber';
      case DashboardMetric.cardBills:
        return 'Faturas em aberto';
    }
  }
}

class FinancialDashboardDetailScreen extends ConsumerWidget {
  const FinancialDashboardDetailScreen({super.key, required this.metric});
  final DashboardMetric metric;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(metric.title)),
      body: switch (metric) {
        DashboardMetric.balance => const _BalanceDetail(),
        DashboardMetric.income => const _MovementsDetail(type: MovementType.income),
        DashboardMetric.expense => const _MovementsDetail(type: MovementType.expense),
        DashboardMetric.payable => const _PayableDetail(),
        DashboardMetric.receivable => const _ReceivableDetail(),
        DashboardMetric.cardBills => const _CardBillsDetail(),
      },
    );
  }
}

class _BalanceDetail extends ConsumerWidget {
  const _BalanceDetail();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(financialAccountsStreamProvider);
    return accountsAsync.when(
      data: (accounts) {
        if (accounts.isEmpty) {
          return const EmptyState(
            icon: Icons.account_balance_outlined,
            title: 'Nenhuma conta bancária',
            message: 'Cadastre uma conta bancária para acompanhar o saldo aqui.',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          itemCount: accounts.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) => _AccountBalanceTile(account: accounts[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }
}

class _AccountBalanceTile extends ConsumerWidget {
  const _AccountBalanceTile({required this.account});
  final AccountRow account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(accountBalanceProvider(account.id));
    return Card(
      child: ListTile(
        onTap: () => context.push('/accounts/${account.id}'),
        leading: const Icon(Icons.account_balance_outlined),
        title: Text(account.name),
        subtitle: account.institution != null ? Text(account.institution!) : null,
        trailing: balanceAsync.when(
          data: (balance) => MoneyText(balance, style: Theme.of(context).textTheme.titleMedium),
          loading: () => const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
          error: (_, _) => const Icon(Icons.error_outline),
        ),
      ),
    );
  }
}

class _MovementsDetail extends ConsumerWidget {
  const _MovementsDetail({required this.type});
  final MovementType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movementsAsync = ref.watch(dashboardMonthMovementsProvider(type));
    return movementsAsync.when(
      data: (movements) {
        if (movements.isEmpty) {
          return EmptyState(
            icon: movementTypeIcon(type),
            title: type == MovementType.income ? 'Nenhuma receita este mês' : 'Nenhuma despesa este mês',
            message: 'Lançamentos aparecem aqui conforme você os registra no extrato.',
          );
        }
        final total = movements.fold<int>(0, (s, m) => s + m.amountCents);
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          itemCount: movements.length + 1,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Total do mês: ${Money.format(total)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              );
            }
            final m = movements[index - 1];
            return Card(
              child: ListTile(
                onTap: () => context.push('/financas-item/movimentacao/${m.id}'),
                leading: Icon(movementTypeIcon(m.type)),
                title: Text(
                  m.description?.isNotEmpty == true ? m.description! : movementTypeLabel(m.type),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(formatDateTime(m.occurredAt)),
                trailing: MoneyText(m.amountCents),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }
}

class _PayableDetail extends ConsumerWidget {
  const _PayableDetail();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payablesAsync = ref.watch(dashboardDuePayablesProvider);
    final cardBillsAsync = ref.watch(dashboardDueCardBillsProvider);

    return payablesAsync.when(
      data: (payables) {
        return cardBillsAsync.when(
          data: (cardBills) {
            if (payables.isEmpty && cardBills.isEmpty) {
              return const EmptyState(
                icon: Icons.event_busy_outlined,
                title: 'Nenhuma conta a pagar neste período',
                message: 'Contas a pagar e faturas de cartão pendentes aparecem aqui.',
              );
            }
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              children: [
                if (payables.isNotEmpty) ...[
                  Text('Contas cadastradas', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  for (final p in payables) _DuePayableTile(due: p),
                  const SizedBox(height: 20),
                ],
                if (cardBills.isNotEmpty) ...[
                  Text('Faturas de cartão', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  for (final c in cardBills) _DueCardBillTile(due: c),
                ],
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Erro: $e')),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }
}

class _ReceivableDetail extends ConsumerWidget {
  const _ReceivableDetail();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receivablesAsync = ref.watch(dashboardDueReceivablesProvider);
    return receivablesAsync.when(
      data: (receivables) {
        if (receivables.isEmpty) {
          return const EmptyState(
            icon: Icons.event_available_outlined,
            title: 'Nenhuma conta a receber neste período',
            message: 'Contas a receber pendentes aparecem aqui.',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          itemCount: receivables.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) => _DueReceivableTile(due: receivables[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }
}

class _CardBillsDetail extends ConsumerWidget {
  const _CardBillsDetail();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardBillsAsync = ref.watch(dashboardDueCardBillsProvider);
    return cardBillsAsync.when(
      data: (cardBills) {
        if (cardBills.isEmpty) {
          return const EmptyState(
            icon: Icons.credit_card_outlined,
            title: 'Nenhuma fatura em aberto neste período',
            message: 'Faturas de cartão com saldo pendente aparecem aqui.',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          itemCount: cardBills.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) => _DueCardBillTile(due: cardBills[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }
}

class _DuePayableTile extends StatelessWidget {
  const _DuePayableTile({required this.due});
  final DuePayableBill due;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () => context.push('/financas-item/conta-pagar/${due.bill.id}'),
        leading: const Icon(Icons.event_note_outlined),
        title: Text(due.bill.description, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text('Vence em ${formatDate(due.bill.dueDate)}'),
        trailing: MoneyText(due.remainingCents),
      ),
    );
  }
}

class _DueReceivableTile extends StatelessWidget {
  const _DueReceivableTile({required this.due});
  final DueReceivableBill due;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => context.push('/financas-item/conta-receber/${due.bill.id}'),
        leading: const Icon(Icons.request_quote_outlined),
        title: Text(due.bill.description, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text('Previsto para ${formatDate(due.bill.dueDate)}'),
        trailing: MoneyText(due.remainingCents),
      ),
    );
  }
}

class _DueCardBillTile extends StatelessWidget {
  const _DueCardBillTile({required this.due});
  final DueCardBill due;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () => context.push('/financas-item/fatura/${due.cardId}/${due.bill.id}'),
        leading: const Icon(Icons.credit_card_outlined),
        title: Text(due.cardName),
        subtitle: Text('Vence em ${formatDate(due.bill.dueDate)}'),
        trailing: MoneyText(due.remainingCents),
      ),
    );
  }
}
