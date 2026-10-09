import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../domain/models/enums.dart';
import '../../../../providers/data_providers.dart';
import '../../../../providers/financial_data_providers.dart';
import '../../../../providers/service_providers.dart';
import '../widgets/bill_status_label.dart';

class CreditCardBillDetailScreen extends ConsumerWidget {
  const CreditCardBillDetailScreen({super.key, required this.cardId, required this.billId});
  final int cardId;
  final int billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billsAsync = ref.watch(creditCardBillsProvider(cardId));

    return Scaffold(
      appBar: AppBar(title: const Text('Fatura')),
      body: billsAsync.when(
        data: (bills) {
          final summary = bills.where((b) => b.bill.id == billId).firstOrNull;
          if (summary == null) return const Center(child: Text('Fatura não encontrada.'));
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              Row(
                children: [
                  Expanded(child: IndicatorTile(label: 'Total', value: MoneyText(summary.totalAmountCents))),
                  const SizedBox(width: 12),
                  Expanded(child: IndicatorTile(label: 'Pago', value: MoneyText(summary.paidAmountCents))),
                  const SizedBox(width: 12),
                  Expanded(child: IndicatorTile(label: 'Restante', value: MoneyText(summary.remainingCents))),
                ],
              ),
              const SizedBox(height: 12),
              SectionCard(
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 10, color: creditCardBillStatusColor(summary.status)),
                    const SizedBox(width: 8),
                    Text(summary.status.label),
                    const Spacer(),
                    Text('Fecha em ${formatDate(summary.bill.closingDate)}'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (summary.remainingCents > 0)
                FilledButton.icon(
                  onPressed: () => _openPaymentDialog(context, ref, summary.remainingCents),
                  icon: const Icon(Icons.payments_outlined),
                  label: const Text('Pagar fatura'),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('Erro: $e'),
      ),
    );
  }

  Future<void> _openPaymentDialog(BuildContext context, WidgetRef ref, int remainingCents) async {
    final amountController = TextEditingController(text: (remainingCents / 100).toStringAsFixed(2));
    int? accountId;
    var paidAt = DateTime.now();

    final accounts = (await ref.read(accountsStreamProvider.future));
    final bankAccounts = accounts.where((a) => a.type == AccountType.bank).toList();
    if (bankAccounts.isNotEmpty) accountId = bankAccounts.first.id;

    if (!context.mounted) return;
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Pagar fatura'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<int>(
                    initialValue: accountId,
                    decoration: const InputDecoration(labelText: 'Conta bancária'),
                    items: [for (final a in bankAccounts) DropdownMenuItem(value: a.id, child: Text(a.name))],
                    onChanged: (v) => setState(() => accountId = v),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Data do pagamento'),
                    subtitle: Text(formatDate(paidAt)),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: paidAt,
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => paidAt = picked);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
                FilledButton(
                  onPressed: () async {
                    final amount = Money.parseToCents(amountController.text);
                    if (amount == null || amount <= 0 || accountId == null) {
                      showAppSnackBar(context, 'Preencha os dados corretamente', isError: true);
                      return;
                    }
                    try {
                      await ref.read(creditCardServiceProvider).payBill(
                            billId: billId,
                            accountId: accountId!,
                            amountCents: amount,
                            paidAt: paidAt,
                          );
                      if (context.mounted) Navigator.of(context).pop();
                    } catch (e) {
                      if (context.mounted) showAppSnackBar(context, 'Erro: $e', isError: true);
                    }
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
