import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../domain/models/enums.dart';
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
              const SizedBox(height: 20),
              Text('Lançamentos desta fatura', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Consumer(
                builder: (context, ref, _) {
                  final detailsAsync = ref.watch(billInstallmentDetailsProvider(billId));
                  return detailsAsync.when(
                    data: (details) {
                      if (details.isEmpty) {
                        return const EmptyState(
                          icon: Icons.receipt_long_outlined,
                          title: 'Nenhum lançamento nesta fatura',
                          message: 'Compras no cartão aparecem aqui conforme entram no ciclo.',
                        );
                      }
                      return Column(
                        children: [
                          for (final detail in details) _InstallmentTile(detail: detail),
                        ],
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text('Erro: $e'),
                  );
                },
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
    final amountController = TextEditingController(text: Money.formatInput(remainingCents));
    int? accountId;
    var paidAt = DateTime.now();

    final bankAccounts = await ref.read(financialAccountsStreamProvider.future);
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [CentsInputFormatter()],
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

class _InstallmentTile extends ConsumerWidget {
  const _InstallmentTile({required this.detail});
  final BillInstallmentDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final installment = detail.installment;
    final transaction = detail.transaction;
    final isMultiInstallment = installment.totalInstallments > 1;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(transaction.type.isCredit ? Icons.undo : Icons.shopping_bag_outlined),
        title: Text(transaction.description, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          isMultiInstallment
              ? 'Parcela ${installment.installmentNumber}/${installment.totalInstallments} · ${formatDate(transaction.purchaseDate)}'
              : formatDate(transaction.purchaseDate),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${transaction.type.isCredit ? '+' : '-'}${Money.format(installment.amountCents)}',
              style: TextStyle(
                color: transaction.type.isCredit ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                fontWeight: FontWeight.w600,
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit_info') {
                  _openEditInfoDialog(context, ref);
                } else if (value == 'edit_amount') {
                  _openEditAmountDialog(context, ref);
                } else if (value == 'delete') {
                  _confirmDelete(context, ref);
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'edit_info', child: Text('Editar descrição/categoria')),
                PopupMenuItem(value: 'edit_amount', child: Text('Editar valor desta parcela')),
                PopupMenuItem(value: 'delete', child: Text('Excluir esta parcela')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openEditInfoDialog(BuildContext context, WidgetRef ref) async {
    final descriptionController = TextEditingController(text: detail.transaction.description);
    final categories = await ref.read(categoriesStreamProvider.future);
    final expenseCategories = categories.where((c) => c.kind == CategoryKind.expense && !c.isArchived).toList();
    int? categoryId = detail.transaction.categoryId;

    if (!context.mounted) return;
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Editar lançamento'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int?>(
                    initialValue: expenseCategories.any((c) => c.id == categoryId) ? categoryId : null,
                    decoration: const InputDecoration(labelText: 'Categoria (opcional)'),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Sem categoria')),
                      for (final c in expenseCategories) DropdownMenuItem(value: c.id, child: Text(c.name)),
                    ],
                    onChanged: (v) => setState(() => categoryId = v),
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
                FilledButton(
                  onPressed: () async {
                    try {
                      await ref.read(creditCardServiceProvider).updateTransactionInfo(
                            transactionId: detail.transaction.id,
                            description: descriptionController.text,
                            categoryId: categoryId,
                            notes: detail.transaction.notes,
                          );
                      if (context.mounted) Navigator.of(context).pop();
                    } catch (e) {
                      if (context.mounted) showAppSnackBar(context, 'Erro: $e', isError: true);
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _openEditAmountDialog(BuildContext context, WidgetRef ref) async {
    final amountController = TextEditingController(text: Money.formatInput(detail.installment.amountCents));

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar valor da parcela'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            inputFormatters: [CentsInputFormatter()],
            decoration: const InputDecoration(labelText: 'Valor (R\$)'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () async {
                final amount = Money.parseToCents(amountController.text);
                if (amount == null || amount < 0) {
                  showAppSnackBar(context, 'Valor inválido', isError: true);
                  return;
                }
                try {
                  await ref.read(creditCardServiceProvider).updateInstallmentAmount(
                        installmentId: detail.installment.id,
                        amountCents: amount,
                      );
                  if (context.mounted) Navigator.of(context).pop();
                } catch (e) {
                  if (context.mounted) showAppSnackBar(context, 'Erro: $e', isError: true);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final isMultiInstallment = detail.installment.totalInstallments > 1;
    final confirmed = await confirmDialog(
      context,
      title: 'Excluir parcela',
      message: isMultiInstallment
          ? 'Só esta parcela (${detail.installment.installmentNumber}/${detail.installment.totalInstallments}) será removida desta fatura — as demais parcelas da compra não são afetadas.'
          : 'Esta compra não tem outras parcelas, então o lançamento será excluído por completo.',
      confirmLabel: 'Excluir',
    );
    if (!confirmed) return;
    try {
      await ref.read(creditCardServiceProvider).deleteInstallment(detail.installment.id);
    } catch (e) {
      if (context.mounted) showAppSnackBar(context, 'Erro: $e', isError: true);
    }
  }
}
