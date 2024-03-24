import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/models/expense_category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePieChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensePieChart(this.expenses, {super.key});

  @override
  Widget build(BuildContext context) {
    if (expenses.length < 2) {
      return const SizedBox.shrink();
    }
    final categories = List.from(ExpenseCategory.categories);
    for (var category in categories) {
      category.totalExpense = expenses
          .where((element) => element.category == category.name)
          .fold(
              0,
              (previousValue, element) =>
                  previousValue + element.amount.toInt());
    }
    categories.removeWhere((category) => category.totalExpense == 0);
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 0,
          centerSpaceColor: Colors.grey.shade100,
          sections: categories
              .map((category) => PieChartSectionData(
                    radius: 150,
                    value: category.totalExpense.toDouble(),
                    title: '${category.name}\n(\$ ${category.totalExpense})',
                    color: category.color,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
