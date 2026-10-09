import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../data/database/database.dart';
import '../../../../domain/models/enums.dart';
import '../../../../providers/data_providers.dart';
import '../widgets/bet_status_badge.dart';

enum BetSortBy { date, stake, odds, result }

class BetsListScreen extends ConsumerStatefulWidget {
  const BetsListScreen({super.key});

  @override
  ConsumerState<BetsListScreen> createState() => _BetsListScreenState();
}

class _BetsListScreenState extends ConsumerState<BetsListScreen> {
  String _search = '';
  DateTimeRange? _range;
  int? _accountId;
  String? _sport;
  BetStatus? _status;
  BetSortBy _sortBy = BetSortBy.date;
  bool _descending = true;

  @override
  Widget build(BuildContext context) {
    final betsAsync = ref.watch(betsStreamProvider);
    final accountsAsync = ref.watch(accountsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Apostas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _openFilters(context, accountsAsync.value ?? []),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar por evento...',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),
          Expanded(
            child: betsAsync.when(
              data: (bets) {
                final accounts = accountsAsync.value ?? [];
                final namesById = {for (final a in accounts) a.id: a.name};
                var filtered = bets.where((b) {
                  if (_search.isNotEmpty && !b.event.toLowerCase().contains(_search.toLowerCase())) {
                    return false;
                  }
                  if (_range != null) {
                    final day = DateTime(b.placedAt.year, b.placedAt.month, b.placedAt.day);
                    if (day.isBefore(_range!.start) || day.isAfter(_range!.end)) return false;
                  }
                  if (_accountId != null && b.accountId != _accountId) return false;
                  if (_sport != null && b.sport != _sport) return false;
                  if (_status != null && b.status != _status) return false;
                  return true;
                }).toList();

                filtered.sort((a, b) {
                  int cmp;
                  switch (_sortBy) {
                    case BetSortBy.date:
                      cmp = a.placedAt.compareTo(b.placedAt);
                      break;
                    case BetSortBy.stake:
                      cmp = a.stakeCents.compareTo(b.stakeCents);
                      break;
                    case BetSortBy.odds:
                      cmp = a.oddsScaled.compareTo(b.oddsScaled);
                      break;
                    case BetSortBy.result:
                      cmp = (a.resultCents ?? 0).compareTo(b.resultCents ?? 0);
                      break;
                  }
                  return _descending ? -cmp : cmp;
                });

                if (filtered.isEmpty) {
                  return EmptyState(
                    icon: Icons.receipt_long_outlined,
                    title: bets.isEmpty ? 'Nenhuma aposta registrada' : 'Nenhum resultado',
                    message: bets.isEmpty
                        ? 'Toque em "Nova aposta" para começar a registrar seu histórico.'
                        : 'Ajuste os filtros ou a pesquisa para ver outras apostas.',
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final bet = filtered[index];
                    return _BetTile(bet: bet, accountName: namesById[bet.accountId] ?? '—');
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
        onPressed: () => context.push('/bets/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _openFilters(BuildContext context, List<AccountRow> accounts) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Filtrar e ordenar', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final status in BetStatus.values)
                        ChoiceChip(
                          label: Text(betStatusLabel(status)),
                          selected: _status == status,
                          onSelected: (sel) => setSheetState(() => _status = sel ? status : null),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final account in accounts)
                        ChoiceChip(
                          label: Text(account.name),
                          selected: _accountId == account.id,
                          onSelected: (sel) => setSheetState(() => _accountId = sel ? account.id : null),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final sport in kDefaultSports)
                        ChoiceChip(
                          label: Text(sport),
                          selected: _sport == sport,
                          onSelected: (sel) => setSheetState(() => _sport = sel ? sport : null),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<BetSortBy>(
                    initialValue: _sortBy,
                    decoration: const InputDecoration(labelText: 'Ordenar por'),
                    items: const [
                      DropdownMenuItem(value: BetSortBy.date, child: Text('Data')),
                      DropdownMenuItem(value: BetSortBy.stake, child: Text('Stake')),
                      DropdownMenuItem(value: BetSortBy.odds, child: Text('Odd')),
                      DropdownMenuItem(value: BetSortBy.result, child: Text('Resultado')),
                    ],
                    onChanged: (v) => setSheetState(() => _sortBy = v ?? BetSortBy.date),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Ordem decrescente'),
                    value: _descending,
                    onChanged: (v) => setSheetState(() => _descending = v),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => setSheetState(() {
                            _status = null;
                            _accountId = null;
                            _sport = null;
                            _range = null;
                          }),
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

class _BetTile extends StatelessWidget {
  const _BetTile({required this.bet, required this.accountName});

  final BetRow bet;
  final String accountName;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => context.push('/bets/${bet.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              BetStatusBadge(status: bet.status),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(bet.event, maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 2),
                    Text(
                      '$accountName · ${bet.sport} · ${formatDateTime(bet.placedAt)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(Money.format(bet.stakeCents), style: Theme.of(context).textTheme.bodyMedium),
                  Text('@ ${(bet.oddsScaled / 1000).toStringAsFixed(2)}',
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
