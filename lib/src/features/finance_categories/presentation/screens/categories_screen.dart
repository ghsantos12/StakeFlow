import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../data/database/database.dart';
import '../../../../domain/models/enums.dart';
import '../../../../domain/models/exceptions.dart';
import '../../../../providers/financial_data_providers.dart';
import '../../../../providers/service_providers.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      body: categoriesAsync.when(
        data: (categories) {
          if (categories.isEmpty) {
            return const EmptyState(
              icon: Icons.category_outlined,
              title: 'Nenhuma categoria',
              message: 'Toque no botão abaixo para criar sua primeira categoria.',
            );
          }
          final expense = categories.where((c) => c.kind == CategoryKind.expense && c.parentCategoryId == null).toList();
          final income = categories.where((c) => c.kind == CategoryKind.income && c.parentCategoryId == null).toList();
          final byParent = <int, List<FinancialCategoryRow>>{};
          for (final c in categories.where((c) => c.parentCategoryId != null)) {
            byParent.putIfAbsent(c.parentCategoryId!, () => []).add(c);
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              Text('Despesas', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              for (final c in expense)
                _CategoryTile(
                  category: c,
                  subcategories: byParent[c.id] ?? const [],
                  onEdit: (cat) => _openForm(context, ref, editing: cat),
                  onAddSubcategory: () => _openForm(context, ref, parentCategoryId: c.id),
                  onArchive: (cat) => _archive(context, ref, cat),
                ),
              const SizedBox(height: 20),
              Text('Receitas', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              for (final c in income)
                _CategoryTile(
                  category: c,
                  subcategories: byParent[c.id] ?? const [],
                  onEdit: (cat) => _openForm(context, ref, editing: cat),
                  onAddSubcategory: () => _openForm(context, ref, parentCategoryId: c.id),
                  onArchive: (cat) => _archive(context, ref, cat),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _openForm(BuildContext context, WidgetRef ref, {FinancialCategoryRow? editing, int? parentCategoryId}) async {
    final categories = await ref.read(categoriesStreamProvider.future);
    final nameController = TextEditingController(text: editing?.name ?? '');
    var kind = editing?.kind ?? CategoryKind.expense;
    var parentId = editing?.parentCategoryId ?? parentCategoryId;
    var colorValue = editing?.colorValue ?? 0xFF2563EB;

    if (!context.mounted) return;
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final possibleParents = categories.where((c) => c.parentCategoryId == null && c.kind == kind && c.id != editing?.id).toList();
            return AlertDialog(
              title: Text(editing == null ? 'Nova categoria' : 'Editar categoria'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                  const SizedBox(height: 12),
                  SegmentedButton<CategoryKind>(
                    segments: const [
                      ButtonSegment(value: CategoryKind.expense, label: Text('Despesa')),
                      ButtonSegment(value: CategoryKind.income, label: Text('Receita')),
                    ],
                    selected: {kind},
                    onSelectionChanged: (s) => setState(() {
                      kind = s.first;
                      parentId = null;
                    }),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int?>(
                    initialValue: possibleParents.any((c) => c.id == parentId) ? parentId : null,
                    decoration: const InputDecoration(labelText: 'Categoria pai (opcional)'),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Nenhuma (categoria principal)')),
                      for (final c in possibleParents) DropdownMenuItem(value: c.id, child: Text(c.name)),
                    ],
                    onChanged: (v) => setState(() => parentId = v),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final c in const [0xFF2563EB, 0xFFDC2626, 0xFF16A34A, 0xFFEA580C, 0xFF9333EA, 0xFF0891B2])
                        GestureDetector(
                          onTap: () => setState(() => colorValue = c),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Color(c),
                            child: colorValue == c ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
                FilledButton(
                  onPressed: () async {
                    try {
                      final service = ref.read(categoryServiceProvider);
                      if (editing == null) {
                        await service.createCategory(
                          name: nameController.text,
                          kind: kind,
                          parentCategoryId: parentId,
                          colorValue: colorValue,
                        );
                      } else {
                        await service.updateCategory(editing.copyWith(
                          name: nameController.text.trim(),
                          kind: kind,
                          colorValue: colorValue,
                        ));
                      }
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

  Future<void> _archive(BuildContext context, WidgetRef ref, FinancialCategoryRow category) async {
    final confirmed = await confirmDialog(
      context,
      title: 'Arquivar categoria',
      message: 'A categoria "${category.name}" deixará de aparecer em novos lançamentos.',
      confirmLabel: 'Arquivar',
    );
    if (!confirmed) return;
    await ref.read(categoryServiceProvider).archiveCategory(category.id);
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.category,
    required this.subcategories,
    required this.onEdit,
    required this.onAddSubcategory,
    required this.onArchive,
  });
  final FinancialCategoryRow category;
  final List<FinancialCategoryRow> subcategories;
  final void Function(FinancialCategoryRow category) onEdit;
  final VoidCallback onAddSubcategory;
  final void Function(FinancialCategoryRow category) onArchive;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: CircleAvatar(backgroundColor: Color(category.colorValue), radius: 12),
        title: Text(category.name),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              onEdit(category);
            } else if (value == 'subcategory') {
              onAddSubcategory();
            } else if (value == 'archive') {
              onArchive(category);
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'edit', child: Text('Editar')),
            PopupMenuItem(value: 'subcategory', child: Text('Nova subcategoria')),
            PopupMenuItem(value: 'archive', child: Text('Arquivar')),
          ],
        ),
        children: [
          for (final sub in subcategories)
            ListTile(
              leading: const SizedBox(width: 12),
              title: Text(sub.name),
              trailing: IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () => onEdit(sub),
              ),
            ),
          if (subcategories.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('Sem subcategorias', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ),
        ],
      ),
    );
  }
}
