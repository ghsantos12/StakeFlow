import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Hub "Mais" do módulo financeiro: acesso a contas bancárias (compartilhadas
/// com o módulo de apostas), categorias, previsão de saldo e relatórios.
class FinanceMoreScreen extends StatelessWidget {
  const FinanceMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mais')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          ListTile(
            leading: const Icon(Icons.account_balance_outlined),
            title: const Text('Contas bancárias'),
            subtitle: const Text('Compartilhadas com o módulo de apostas'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/accounts'),
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: const Text('Categorias'),
            subtitle: const Text('Despesas e receitas, com subcategorias'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/financas/mais/categorias'),
          ),
          ListTile(
            leading: const Icon(Icons.show_chart_outlined),
            title: const Text('Previsão de saldo'),
            subtitle: const Text('Projeção com base em contas e faturas pendentes'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/financas/mais/previsao'),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_outlined),
            title: const Text('Relatórios'),
            subtitle: const Text('Receitas, despesas, cartões e patrimônio'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/financas/mais/relatorios'),
          ),
        ],
      ),
    );
  }
}
