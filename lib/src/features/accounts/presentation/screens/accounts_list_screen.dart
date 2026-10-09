import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../data/database/database.dart';
import '../../../../domain/models/enums.dart';
import '../../../../providers/data_providers.dart';

class AccountsListScreen extends ConsumerWidget {
  const AccountsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Contas')),
      body: accountsAsync.when(
        data: (accounts) {
          if (accounts.isEmpty) {
            return const EmptyState(
              icon: Icons.account_balance_outlined,
              title: 'Nenhuma conta cadastrada',
              message: 'Cadastre sua conta bancária e as casas de apostas que você utiliza.',
            );
          }
          final banks = accounts.where((a) => a.type == AccountType.bank).toList();
          final bookmakers = accounts.where((a) => a.type == AccountType.bookmaker).toList();
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              if (banks.isNotEmpty) ...[
                Text('Contas bancárias', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                for (final a in banks) _AccountTile(account: a),
                const SizedBox(height: 20),
              ],
              if (bookmakers.isNotEmpty) ...[
                Text('Casas de apostas', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                for (final a in bookmakers) _AccountTile(account: a),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/settings/accounts/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AccountTile extends ConsumerWidget {
  const _AccountTile({required this.account});
  final AccountRow account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmaker = account.type == AccountType.bookmaker;
    final balanceAsync = ref.watch(accountBalanceProvider(account.id));
    final summaryAsync = isBookmaker ? ref.watch(bookmakerSummaryProvider(account.id)) : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () => context.push('/settings/accounts/${account.id}'),
        leading: CircleAvatar(
          child: Icon(isBookmaker ? Icons.casino_outlined : Icons.account_balance_outlined),
        ),
        title: Text(account.name),
        subtitle: isBookmaker
            ? summaryAsync?.when(
                data: (s) => s == null
                    ? const Text('—')
                    : Text(
                        'Disponível: ${Money.format(s.availableCents)} · Comprometido: ${Money.format(s.committedCents)}'),
                loading: () => const Text('Carregando...'),
                error: (_, _) => const Text('—'),
              )
            : (account.institution != null ? Text(account.institution!) : null),
        trailing: balanceAsync.when(
          data: (balance) => MoneyText(balance, style: Theme.of(context).textTheme.titleMedium),
          loading: () => const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
          error: (_, _) => const Icon(Icons.error_outline),
        ),
      ),
    );
  }
}
