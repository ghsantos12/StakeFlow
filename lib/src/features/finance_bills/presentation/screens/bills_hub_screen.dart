import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../data/database/database.dart';
import '../../../../domain/models/enums.dart';
import '../../../../providers/financial_data_providers.dart';
import '../../../finance_credit_cards/presentation/widgets/bill_status_label.dart';

/// Hub de contas a pagar e a receber, em abas.
class BillsHubScreen extends StatelessWidget {
  const BillsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contas a pagar/receber'),
          bottom: const TabBar(tabs: [Tab(text: 'A pagar'), Tab(text: 'A receber')]),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Consumer(
                builder: (context, ref, _) {
                  final selected = ref.watch(billsDateFilterProvider);
                  return Wrap(
                    spacing: 8,
                    children: [
                      for (final filter in BillsDateFilter.values)
                        ChoiceChip(
                          label: Text(filter.label),
                          selected: selected == filter,
                          onSelected: (_) => ref.read(billsDateFilterProvider.notifier).select(filter),
                        ),
                    ],
                  );
                },
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [_PayableTab(), _ReceivableTab()],
              ),
            ),
          ],
        ),
        floatingActionButton: Builder(builder: (context) {
          final index = DefaultTabController.of(context).index;
          return FloatingActionButton(
            onPressed: () => context.push(index == 0 ? '/financas/contas/pagar/novo' : '/financas/contas/receber/novo'),
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}

class _PayableTab extends ConsumerWidget {
  const _PayableTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billsAsync = ref.watch(billsPayableStreamProvider);
    final filter = ref.watch(billsDateFilterProvider);
    return billsAsync.when(
      data: (allBills) {
        final bills = allBills.where((b) => filter.matches(b.dueDate)).toList();
        if (bills.isEmpty) {
          return EmptyState(
            icon: Icons.event_busy_outlined,
            title: allBills.isEmpty ? 'Nenhuma conta a pagar' : 'Nenhuma conta neste período',
            message: allBills.isEmpty
                ? 'Cadastre despesas futuras para acompanhar vencimentos.'
                : 'Ajuste o filtro de período para ver outras contas.',
          );
        }
        final sorted = [...bills]..sort((a, b) => a.dueDate.compareTo(b.dueDate));
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          itemCount: sorted.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) => _PayableTile(bill: sorted[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }
}

class _PayableTile extends ConsumerWidget {
  const _PayableTile({required this.bill});
  final BillPayableRow bill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(billPayableSummaryProvider(bill.id));
    return Card(
      child: ListTile(
        onTap: () => context.push('/financas/contas/pagar/${bill.id}'),
        title: Text(bill.description),
        subtitle: Text('Vence em ${formatDate(bill.dueDate)}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MoneyText(bill.amountCents),
            summaryAsync.when(
              data: (s) => s == null
                  ? const SizedBox.shrink()
                  : Text(s.status.label, style: TextStyle(fontSize: 11, color: billStatusColor(s.status))),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceivableTab extends ConsumerWidget {
  const _ReceivableTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billsAsync = ref.watch(billsReceivableStreamProvider);
    final filter = ref.watch(billsDateFilterProvider);
    return billsAsync.when(
      data: (allBills) {
        final bills = allBills.where((b) => filter.matches(b.dueDate)).toList();
        if (bills.isEmpty) {
          return EmptyState(
            icon: Icons.event_available_outlined,
            title: allBills.isEmpty ? 'Nenhuma conta a receber' : 'Nenhuma conta neste período',
            message: allBills.isEmpty
                ? 'Cadastre receitas futuras para acompanhar previsões.'
                : 'Ajuste o filtro de período para ver outras contas.',
          );
        }
        final sorted = [...bills]..sort((a, b) => a.dueDate.compareTo(b.dueDate));
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          itemCount: sorted.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) => _ReceivableTile(bill: sorted[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
    );
  }
}

class _ReceivableTile extends ConsumerWidget {
  const _ReceivableTile({required this.bill});
  final BillReceivableRow bill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(billReceivableSummaryProvider(bill.id));
    return Card(
      child: ListTile(
        onTap: () => context.push('/financas/contas/receber/${bill.id}'),
        title: Text(bill.description),
        subtitle: Text('Previsto para ${formatDate(bill.dueDate)}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MoneyText(bill.amountCents),
            summaryAsync.when(
              data: (s) => s == null
                  ? const SizedBox.shrink()
                  : Text(s.status.label, style: TextStyle(fontSize: 11, color: billStatusColor(s.status))),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
