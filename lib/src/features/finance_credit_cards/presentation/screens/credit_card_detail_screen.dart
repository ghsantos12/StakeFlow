import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../domain/models/enums.dart';
import '../../../../providers/financial_data_providers.dart';
import '../../../../providers/service_providers.dart';
import '../widgets/bill_status_label.dart';

class CreditCardDetailScreen extends ConsumerWidget {
  const CreditCardDetailScreen({super.key, required this.cardId});
  final int cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardAsync = ref.watch(creditCardServiceProvider).watchCardById(cardId);
    final billsAsync = ref.watch(creditCardBillsProvider(cardId));
    final availableAsync = ref.watch(cardAvailableLimitProvider(cardId));

    return StreamBuilder(
      stream: cardAsync,
      builder: (context, cardSnapshot) {
        final card = cardSnapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text(card?.name ?? 'Cartão'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => context.push('/financas/cartoes/$cardId/editar'),
              ),
            ],
          ),
          body: card == null
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: IndicatorTile(
                            label: 'Limite total',
                            value: Text(Money.format(card.creditLimitCents)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: IndicatorTile(
                            label: 'Limite disponível',
                            value: availableAsync.when(
                              data: (v) => MoneyText(v),
                              loading: () => const Text('...'),
                              error: (_, _) => const Text('—'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Faturas', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    billsAsync.when(
                      data: (bills) {
                        if (bills.isEmpty) {
                          return const EmptyState(
                            icon: Icons.receipt_outlined,
                            title: 'Nenhuma fatura ainda',
                            message: 'As faturas aparecem aqui conforme você registra compras.',
                          );
                        }
                        final sorted = [...bills]
                          ..sort((a, b) {
                            final ay = a.bill.referenceYear, am = a.bill.referenceMonth;
                            final by = b.bill.referenceYear, bm = b.bill.referenceMonth;
                            return by != ay ? by - ay : bm - am;
                          });
                        return Column(
                          children: [
                            for (final summary in sorted)
                              Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  onTap: () => context.push('/financas/cartoes/$cardId/fatura/${summary.bill.id}'),
                                  leading: CircleAvatar(
                                    backgroundColor: creditCardBillStatusColor(summary.status).withValues(alpha: 0.15),
                                    child: Icon(Icons.receipt_long, color: creditCardBillStatusColor(summary.status)),
                                  ),
                                  title: Text(monthLabel(summary.bill.referenceYear, summary.bill.referenceMonth)),
                                  subtitle: Text('Vence em ${formatDate(summary.bill.dueDate)} · ${summary.status.label}'),
                                  trailing: MoneyText(summary.totalAmountCents),
                                ),
                              ),
                          ],
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Text('Erro: $e'),
                    ),
                  ],
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/financas/cartoes/$cardId/nova-compra'),
            icon: const Icon(Icons.add),
            label: const Text('Nova compra'),
          ),
        );
      },
    );
  }
}
