import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../data/database/database.dart';
import '../../../../domain/models/enums.dart';
import '../../../../providers/core_providers.dart';
import '../../../../providers/data_providers.dart';
import '../../../../providers/service_providers.dart';

final _accountLedgerProvider = FutureProvider.family<List<LedgerEntryRow>, int>((ref, accountId) async {
  ref.watch(dbChangesProvider);
  final db = ref.watch(databaseProvider);
  final entries = await db.ledgerDao.getForAccount(accountId);
  return entries.reversed.toList();
});

class AccountDetailScreen extends ConsumerWidget {
  const AccountDetailScreen({super.key, required this.accountId});

  final int accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountAsync = ref.watch(accountServiceProvider).watchById(accountId);

    return StreamBuilder<AccountRow?>(
      stream: accountAsync,
      builder: (context, snapshot) {
        final account = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text(account?.name ?? 'Conta'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => context.push('/settings/accounts/$accountId/edit'),
              ),
            ],
          ),
          body: account == null
              ? const Center(child: CircularProgressIndicator())
              : _AccountDetailBody(account: account),
        );
      },
    );
  }
}

class _AccountDetailBody extends ConsumerWidget {
  const _AccountDetailBody({required this.account});
  final AccountRow account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmaker = account.type == AccountType.bookmaker;
    final balanceAsync = ref.watch(accountBalanceProvider(account.id));
    final summaryAsync = isBookmaker ? ref.watch(bookmakerSummaryProvider(account.id)) : null;
    final ledgerAsync = ref.watch(_accountLedgerProvider(account.id));

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        Row(
          children: [
            Expanded(
              child: IndicatorTile(
                label: isBookmaker ? 'Saldo disponível' : 'Saldo atual',
                value: balanceAsync.when(
                  data: (b) => MoneyText(b, style: const TextStyle(fontSize: 20)),
                  loading: () => const Text('...'),
                  error: (_, _) => const Text('—'),
                ),
              ),
            ),
            if (isBookmaker) ...[
              const SizedBox(width: 12),
              Expanded(
                child: IndicatorTile(
                  label: 'Comprometido',
                  value: summaryAsync!.when(
                    data: (s) => MoneyText(s?.committedCents ?? 0, style: const TextStyle(fontSize: 20)),
                    loading: () => const Text('...'),
                    error: (_, _) => const Text('—'),
                  ),
                ),
              ),
            ],
          ],
        ),
        if (account.type == AccountType.bank) ...[
          const SizedBox(height: 12),
          SectionCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rendimento de CDB', style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 4),
                      Text(
                        account.cdiPercent != null ? '${account.cdiPercent!.toStringAsFixed(0)}% do CDI' : 'Não configurado',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => context.push('/settings/accounts/${account.id}/cdb-yields'),
                  child: const Text('Ver rendimentos'),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 20),
        Text('Extrato da conta', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ledgerAsync.when(
          data: (entries) {
            if (entries.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: Text('Nenhum lançamento ainda.')),
              );
            }
            return Column(
              children: [
                for (final e in entries)
                  Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(e.description ?? ledgerTypeLabel(e.type)),
                      subtitle: Text(formatDateTime(e.occurredAt)),
                      trailing: MoneyText(e.amountCents, signed: true),
                    ),
                  ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Erro: $e'),
        ),
      ],
    );
  }
}

String ledgerTypeLabel(LedgerEntryType type) {
  switch (type) {
    case LedgerEntryType.externalDeposit:
      return 'Depósito externo';
    case LedgerEntryType.externalWithdrawal:
      return 'Retirada externa';
    case LedgerEntryType.depositToBookmaker:
      return 'Depósito em casa de apostas';
    case LedgerEntryType.withdrawalFromBookmaker:
      return 'Saque de casa de apostas';
    case LedgerEntryType.transferBetweenAccounts:
      return 'Transferência';
    case LedgerEntryType.adjustment:
      return 'Ajuste de saldo';
    case LedgerEntryType.betPlaced:
      return 'Aposta registrada';
    case LedgerEntryType.betSettledWin:
      return 'Aposta ganha';
    case LedgerEntryType.betSettledLoss:
      return 'Aposta perdida';
    case LedgerEntryType.betSettledVoid:
      return 'Aposta anulada';
    case LedgerEntryType.betSettledCashout:
      return 'Cashout';
    case LedgerEntryType.cdbYield:
      return 'Rendimento CDB';
    case LedgerEntryType.fee:
      return 'Taxa';
    case LedgerEntryType.income:
      return 'Receita';
    case LedgerEntryType.expense:
      return 'Despesa';
    case LedgerEntryType.yield:
      return 'Rendimento';
    case LedgerEntryType.creditCardBillPayment:
      return 'Pagamento de fatura';
  }
}
