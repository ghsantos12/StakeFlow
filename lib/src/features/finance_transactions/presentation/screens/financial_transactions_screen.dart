import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../data/database/database.dart';
import '../../../../domain/models/enums.dart';
import '../../../../providers/data_providers.dart';
import '../../../../providers/financial_data_providers.dart';
import '../../../../features/transactions/presentation/widgets/movement_type_label.dart';

/// Extrato do módulo financeiro: mostra todas as movimentações das contas
/// bancárias (inclusive as geradas pelo módulo de apostas, como saques de
/// casas de apostas — que aparecem aqui como transferência interna, não
/// como receita), com filtro por categoria.
class FinancialTransactionsScreen extends ConsumerStatefulWidget {
  const FinancialTransactionsScreen({super.key});

  @override
  ConsumerState<FinancialTransactionsScreen> createState() => _FinancialTransactionsScreenState();
}

class _FinancialTransactionsScreenState extends ConsumerState<FinancialTransactionsScreen> {
  String _search = '';
  int? _categoryFilter;

  @override
  Widget build(BuildContext context) {
    final movementsAsync = ref.watch(movementsStreamProvider);
    final categoriesAsync = ref.watch(categoriesStreamProvider);
    final accountsAsync = ref.watch(accountsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Extrato'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _openCategoryFilter(context, categoriesAsync.value ?? []),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Pesquisar por descrição...',
                prefixIcon: Icon(Icons.search),
                isDense: true,
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),
          Expanded(
            child: movementsAsync.when(
              data: (movements) {
                final accounts = accountsAsync.value ?? [];
                final categories = categoriesAsync.value ?? [];
                final namesById = {for (final a in accounts) a.id: a.name};
                final categoryNames = {for (final c in categories) c.id: c.name};

                var filtered = movements.where((m) {
                  if (_categoryFilter != null && m.categoryId != _categoryFilter) return false;
                  if (_search.isEmpty) return true;
                  final desc = (m.description ?? '').toLowerCase();
                  return desc.contains(_search.toLowerCase());
                }).toList();

                if (filtered.isEmpty) {
                  return EmptyState(
                    icon: Icons.receipt_long_outlined,
                    title: movements.isEmpty ? 'Nenhuma movimentação registrada' : 'Nenhum resultado',
                    message: movements.isEmpty
                        ? 'Registre receitas, despesas e transferências.'
                        : 'Ajuste a busca ou o filtro de categoria.',
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final m = filtered[index];
                    return _TransactionTile(
                      movement: m,
                      namesById: namesById,
                      categoryName: m.categoryId != null ? categoryNames[m.categoryId] : null,
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Erro: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/financas/extrato/novo'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _openCategoryFilter(BuildContext context, List<FinancialCategoryRow> categories) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Filtrar por categoria', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final c in categories)
                        ChoiceChip(
                          label: Text(c.name),
                          selected: _categoryFilter == c.id,
                          onSelected: (sel) => setSheetState(() => _categoryFilter = sel ? c.id : null),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => setSheetState(() => _categoryFilter = null),
                          child: const Text('Limpar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: const Text('Aplicar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.movement, required this.namesById, this.categoryName});

  final MovementRow movement;
  final Map<int, String> namesById;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final source = movement.sourceAccountId != null ? namesById[movement.sourceAccountId!] : null;
    final destination =
        movement.destinationAccountId != null ? namesById[movement.destinationAccountId!] : null;
    final isPositive = movement.type == MovementType.income ||
        movement.type == MovementType.yield ||
        movement.type == MovementType.externalDeposit;

    final subtitleParts = [
      ?categoryName,
      if (source != null) 'De: $source',
      if (destination != null) 'Para: $destination',
    ];

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => context.push('/financas/extrato/${movement.id}'),
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
                    Text(
                      movement.description?.isNotEmpty == true
                          ? movement.description!
                          : movementTypeLabel(movement.type),
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitleParts.isEmpty ? formatDateTime(movement.occurredAt) : subtitleParts.join(' · '),
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
              Text(
                '${isPositive ? '+' : '-'}${Money.format(movement.amountCents)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isPositive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
