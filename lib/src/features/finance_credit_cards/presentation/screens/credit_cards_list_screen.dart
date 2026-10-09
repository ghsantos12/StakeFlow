import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../data/database/database.dart';
import '../../../../providers/financial_data_providers.dart';

class CreditCardsListScreen extends ConsumerWidget {
  const CreditCardsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(creditCardsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cartões de crédito')),
      body: cardsAsync.when(
        data: (cards) {
          if (cards.isEmpty) {
            return const EmptyState(
              icon: Icons.credit_card_outlined,
              title: 'Nenhum cartão cadastrado',
              message: 'Cadastre seus cartões de crédito para acompanhar compras, parcelas e faturas.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: cards.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) => _CardTile(card: cards[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/financas/cartoes/novo'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CardTile extends ConsumerWidget {
  const _CardTile({required this.card});
  final CreditCardRow card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableAsync = ref.watch(cardAvailableLimitProvider(card.id));
    final color = Color(card.colorValue);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => context.push('/financas/cartoes/${card.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(Icons.credit_card, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(card.name, style: Theme.of(context).textTheme.titleSmall),
                    if (card.issuerBank != null)
                      Text(card.issuerBank!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              )),
                    Text('Fecha dia ${card.closingDay} · Vence dia ${card.dueDay}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            )),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Limite disponível', style: Theme.of(context).textTheme.bodySmall),
                  availableAsync.when(
                    data: (v) => Text(Money.format(v), style: Theme.of(context).textTheme.titleSmall),
                    loading: () => const SizedBox(
                        width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2)),
                    error: (_, _) => const Text('—'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
