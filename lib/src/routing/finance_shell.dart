import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/update_dialog.dart';
import '../providers/service_providers.dart';
import '../providers/settings_providers.dart';

/// Shell (navegação inferior) do módulo de Gestão Financeira pessoal —
/// espelha [AppShell] (módulo de apostas), com suas próprias 5 abas.
class FinanceShell extends ConsumerStatefulWidget {
  const FinanceShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<FinanceShell> createState() => _FinanceShellState();
}

class _FinanceShellState extends ConsumerState<FinanceShell> {
  @override
  void initState() {
    super.initState();
    ref.read(lastModuleProvider.notifier).set('financas');
    ref.read(categoryServiceProvider).ensureDefaultCategories();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkForUpdate());
  }

  Future<void> _checkForUpdate() async {
    final update = await ref.read(updateServiceProvider).checkForUpdate();
    if (update != null && mounted) {
      await showUpdateDialog(context, update);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: (index) {
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Início'),
          NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Extrato'),
          NavigationDestination(
              icon: Icon(Icons.credit_card_outlined), selectedIcon: Icon(Icons.credit_card), label: 'Cartões'),
          NavigationDestination(
              icon: Icon(Icons.event_note_outlined), selectedIcon: Icon(Icons.event_note), label: 'Contas'),
          NavigationDestination(icon: Icon(Icons.more_horiz_outlined), selectedIcon: Icon(Icons.more_horiz), label: 'Mais'),
        ],
      ),
    );
  }
}
