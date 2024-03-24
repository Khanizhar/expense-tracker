import 'package:expense_tracker/providers/expense_tracker_provider.dart';
import 'package:expense_tracker/ui/widgets/expense_card.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/ui/screens/add_expense_screen.dart';
import 'package:expense_tracker/ui/widgets/expense_summary_graph.dart';
import 'package:expense_tracker/ui/widgets/no_expense_found.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({super.key});

  @override
  _ExpenseTrackerScreenState createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {


  @override
  Widget build(BuildContext context) {
    final expenses = context.watch<ExpenseTrackerProvider>().expenses;
    return Scaffold(
      drawer: const Drawer(),
      appBar: _buildAppBar(),
      body: _buildBody(expenses),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExpenseScreen(),
            ),
          );
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text(
        'Expense Tracker',
        style: TextStyle(fontFamily: 'Pacifico'),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            final expenseProvider = context.read<ExpenseTrackerProvider>();
            final picked = await showMonthPicker(
              headerColor: Theme.of(context).colorScheme.inversePrimary,
              selectedMonthTextColor:
                  Theme.of(context).colorScheme.onPrimaryContainer,
              selectedMonthBackgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
              context: context,
              initialDate: expenseProvider.selectedMonthDate,
              firstDate: DateTime(2000).subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null && picked != expenseProvider.selectedMonthDate) {
              expenseProvider.selectedMonthDate = picked;
            }
          },
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }

  Widget _buildBody(List<Expense> expenses) {
    if (expenses.isEmpty) {
      return const NoExpenseFound();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            ExpensePieChart(expenses),
            const SizedBox(height: 8),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: expenses.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == expenses.length) {
                  return const SizedBox(height: 100);
                }
                return ExpenseCard(expense: expenses[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
