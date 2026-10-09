/// Funções puras de cálculo para os relatórios do módulo financeiro,
/// seguindo o mesmo padrão de `analytics_calculations.dart` (sem
/// dependência do banco, para ficarem fáceis de validar isoladamente).
library;

import '../../data/database/database.dart';
import '../models/enums.dart';

class MonthlyIncomeExpense {
  const MonthlyIncomeExpense({
    required this.year,
    required this.month,
    required this.incomeCents,
    required this.expenseCents,
  });

  final int year;
  final int month;
  final int incomeCents;
  final int expenseCents;

  int get netCents => incomeCents - expenseCents;
}

class CategoryTotal {
  const CategoryTotal({
    required this.categoryId,
    required this.categoryName,
    required this.totalCents,
  });

  final int? categoryId;
  final String categoryName;
  final int totalCents;
}

class CashFlowSummary {
  const CashFlowSummary({
    required this.totalIncomeCents,
    required this.totalExpenseCents,
    required this.startingBalanceCents,
    required this.endingBalanceCents,
  });

  final int totalIncomeCents;
  final int totalExpenseCents;
  final int startingBalanceCents;
  final int endingBalanceCents;

  int get netCents => totalIncomeCents - totalExpenseCents;
}

bool _inRange(DateTime date, DateTime? from, DateTime? to) {
  if (from != null && date.isBefore(DateTime(from.year, from.month, from.day))) return false;
  if (to != null) {
    final end = DateTime(to.year, to.month, to.day, 23, 59, 59);
    if (date.isAfter(end)) return false;
  }
  return true;
}

/// Receitas e despesas "reais" do módulo financeiro: apenas movimentações
/// de receita/despesa (não transferências internas nem ajustes, que não
/// devem ser contabilizados como ganho ou perda).
List<MonthlyIncomeExpense> monthlyIncomeExpense(
  List<MovementRow> movements, {
  DateTime? from,
  DateTime? to,
}) {
  final filtered = movements.where((m) => _inRange(m.occurredAt, from, to));
  final map = <(int, int), (int, int)>{};
  for (final m in filtered) {
    if (m.type != MovementType.income && m.type != MovementType.expense) continue;
    final key = (m.occurredAt.year, m.occurredAt.month);
    final current = map[key] ?? (0, 0);
    if (m.type == MovementType.income) {
      map[key] = (current.$1 + m.amountCents, current.$2);
    } else {
      map[key] = (current.$1, current.$2 + m.amountCents);
    }
  }
  final keys = map.keys.toList()..sort((a, b) => a.$1 != b.$1 ? a.$1 - b.$1 : a.$2 - b.$2);
  return [
    for (final k in keys)
      MonthlyIncomeExpense(year: k.$1, month: k.$2, incomeCents: map[k]!.$1, expenseCents: map[k]!.$2),
  ];
}

List<CategoryTotal> expensesByCategory(
  List<MovementRow> movements,
  List<FinancialCategoryRow> categories, {
  DateTime? from,
  DateTime? to,
}) {
  return _totalsByCategory(movements, categories, MovementType.expense, from: from, to: to);
}

List<CategoryTotal> incomeByCategory(
  List<MovementRow> movements,
  List<FinancialCategoryRow> categories, {
  DateTime? from,
  DateTime? to,
}) {
  return _totalsByCategory(movements, categories, MovementType.income, from: from, to: to);
}

List<CategoryTotal> _totalsByCategory(
  List<MovementRow> movements,
  List<FinancialCategoryRow> categories,
  MovementType type, {
  DateTime? from,
  DateTime? to,
}) {
  final namesById = {for (final c in categories) c.id: c.name};
  final filtered = movements.where((m) => m.type == type && _inRange(m.occurredAt, from, to));
  final totals = <int?, int>{};
  for (final m in filtered) {
    totals[m.categoryId] = (totals[m.categoryId] ?? 0) + m.amountCents;
  }
  final result = [
    for (final entry in totals.entries)
      CategoryTotal(
        categoryId: entry.key,
        categoryName: entry.key == null ? 'Sem categoria' : (namesById[entry.key] ?? 'Categoria removida'),
        totalCents: entry.value,
      ),
  ];
  result.sort((a, b) => b.totalCents.compareTo(a.totalCents));
  return result;
}

CashFlowSummary cashFlowSummary(
  List<MovementRow> movements, {
  required int currentBalanceCents,
  DateTime? from,
  DateTime? to,
}) {
  final filtered = movements.where((m) => _inRange(m.occurredAt, from, to));
  var income = 0;
  var expense = 0;
  for (final m in filtered) {
    if (m.type == MovementType.income || m.type == MovementType.yield) {
      income += m.amountCents;
    } else if (m.type == MovementType.expense) {
      expense += m.amountCents;
    }
  }
  final ending = currentBalanceCents;
  final starting = ending - income + expense;
  return CashFlowSummary(
    totalIncomeCents: income,
    totalExpenseCents: expense,
    startingBalanceCents: starting,
    endingBalanceCents: ending,
  );
}
