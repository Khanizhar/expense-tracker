import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense_tracker_provider.dart';
import 'package:expense_tracker/ui/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10),
            onPressed: (context) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddExpenseScreen(
                    expense: expense,
                  );
                },
              ),
            ),
            icon: Icons.edit,
          ),
          SlidableAction(
            backgroundColor: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10),
            onPressed: (context) => context
                .read<ExpenseTrackerProvider>()
                .removeExpense(expense: expense),
            icon: Icons.delete,
          ),
        ],
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text(expense.date.day.toString())),
          title: Text(expense.category),
          subtitle: Text(expense.description),
          trailing: Text(
            '\$${expense.amount.toInt()}',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
