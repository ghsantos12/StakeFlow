import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/pickers.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../domain/models/exceptions.dart';
import '../../../../providers/service_providers.dart';

class CdbYieldsScreen extends ConsumerWidget {
  const CdbYieldsScreen({super.key, required this.accountId});

  final int accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(cdbYieldServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rendimentos de CDB')),
      body: StreamBuilder(
        stream: service.watchForAccount(accountId),
        builder: (context, snapshot) {
          final yields = snapshot.data ?? [];
          if (yields.isEmpty) {
            return const EmptyState(
              icon: Icons.savings_outlined,
              title: 'Nenhum rendimento lançado',
              message: 'Registre aqui os rendimentos de CDB efetivamente creditados pelo banco.',
            );
          }
          final total = yields.fold<int>(0, (s, y) => s + y.amountCents);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text('Total acumulado: '),
                    MoneyText(total, signed: true, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  itemCount: yields.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final y = yields[index];
                    return Card(
                      child: ListTile(
                        title: Text(y.description ?? 'Rendimento CDB'),
                        subtitle: Text(formatDate(y.date)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MoneyText(y.amountCents, signed: true),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, size: 20),
                              onPressed: () async {
                                final confirmed = await confirmDialog(
                                  context,
                                  title: 'Excluir rendimento',
                                  message: 'Esta ação não pode ser desfeita.',
                                  confirmLabel: 'Excluir',
                                );
                                if (confirmed) await service.deleteYield(y.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _openAddDialog(BuildContext context, WidgetRef ref) async {
    final amountController = TextEditingController();
    final descriptionController = TextEditingController(text: 'Rendimento CDB');
    var date = DateTime.now();

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Lançar rendimento'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Valor (R\$)'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Data'),
                    subtitle: Text(formatDate(date)),
                    trailing: const Icon(Icons.edit_calendar_outlined),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2015),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => date = picked);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
                FilledButton(
                  onPressed: () async {
                    final cents = Money.parseToCents(amountController.text);
                    if (cents == null || cents <= 0) {
                      showAppSnackBar(context, 'Informe um valor válido', isError: true);
                      return;
                    }
                    try {
                      await ref.read(cdbYieldServiceProvider).addYield(
                            accountId: accountId,
                            date: date,
                            amountCents: cents,
                            description: descriptionController.text.trim().isEmpty
                                ? null
                                : descriptionController.text.trim(),
                          );
                      if (context.mounted) Navigator.of(context).pop();
                    } on ValidationException catch (e) {
                      if (context.mounted) showAppSnackBar(context, e.message, isError: true);
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
}
