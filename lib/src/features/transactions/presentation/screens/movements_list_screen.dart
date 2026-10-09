import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../data/database/database.dart';
import '../../../../domain/models/enums.dart';
import '../../../../providers/data_providers.dart';
import '../widgets/movement_type_label.dart';

class MovementsListScreen extends ConsumerWidget {
  const MovementsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movementsAsync = ref.watch(movementsStreamProvider);
    final accountsAsync = ref.watch(accountsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Movimentações')),
      body: movementsAsync.when(
        data: (allMovements) {
          // Receita/despesa/rendimento são lançamentos exclusivos do módulo
          // financeiro — não aparecem aqui para não misturar despesas
          // pessoais com as movimentações de apostas.
          final movements = allMovements
              .where((m) =>
                  m.type != MovementType.income &&
                  m.type != MovementType.expense &&
                  m.type != MovementType.yield)
              .toList();
          if (movements.isEmpty) {
            return const EmptyState(
              icon: Icons.swap_horiz_outlined,
              title: 'Nenhuma movimentação registrada',
              message: 'Registre depósitos, saques, transferências e ajustes de saldo.',
            );
          }
          final accounts = accountsAsync.value ?? [];
          final namesById = {for (final a in accounts) a.id: a.name};
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: movements.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final m = movements[index];
              return _MovementTile(movement: m, namesById: namesById);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/movements/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _MovementTile extends StatelessWidget {
  const _MovementTile({required this.movement, required this.namesById});

  final MovementRow movement;
  final Map<int, String> namesById;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final source = movement.sourceAccountId != null ? namesById[movement.sourceAccountId!] : null;
    final destination =
        movement.destinationAccountId != null ? namesById[movement.destinationAccountId!] : null;
    final subtitle = [
      if (source != null) 'De: $source',
      if (destination != null) 'Para: $destination',
    ].join('  ·  ');

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => context.push('/movements/${movement.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: scheme.primaryContainer,
                child: Icon(movementTypeIcon(movement.type), color: scheme.onPrimaryContainer, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movementTypeLabel(movement.type), style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 2),
                    Text(
                      subtitle.isEmpty ? formatDateTime(movement.occurredAt) : subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      formatDateTime(movement.occurredAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(Money.format(movement.amountCents), style: Theme.of(context).textTheme.bodyMedium),
                  if (movement.feeCents > 0)
                    Text('Taxa: ${Money.format(movement.feeCents)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
