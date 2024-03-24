import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/models/expense_category.dart';
import 'package:expense_tracker/providers/expense_tracker_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  final Expense? expense;
  const AddExpenseScreen({super.key, this.expense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  final dateFormat = DateFormat('dd-MM-yyyy');
  late TextEditingController descriptionController =
      TextEditingController(text: widget.expense?.description);

  late TextEditingController amountController =
      TextEditingController(text: widget.expense?.amount.toString());

  late TextEditingController dateController = TextEditingController(
      text: dateFormat.format(widget.expense?.date ?? DateTime.now()));

  late String? selectedCategory = widget.expense?.category;
  @override
  void initState() {
    super.initState();
    if (widget.expense == null) {
      dateController.text = dateFormat.format(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: widget.expense == null
            ? const Text('Add Expense')
            : const Text('Edit Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                key: const Key('amount_field'),
                keyboardType: TextInputType.number,
                controller: amountController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Expense Amount';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'Enter Amount', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              TextFormField(
                readOnly: true,
                controller: dateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Select Date';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Please Select Date',
                    suffixIcon: IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: const Icon(Icons.calendar_month)),
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Description';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'Enter Description',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField(
                hint: const Text('Select Category'),
                value: selectedCategory,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Select Expense Category';
                  }
                  return null;
                },
                items: ExpenseCategory.categories
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.name,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  selectedCategory = value as String;
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final updateCase = widget.expense != null;
                        if (updateCase) {
                          _updateExpense();
                        } else {
                          _addExpense();
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: widget.expense == null
                        ? const Text('Add Expense')
                        : const Text('Update Expense'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addExpense() {
    final expense = Expense(
      id: DateTime.now().toString(),
      description: descriptionController.text,
      amount: double.parse(amountController.text),
      category: selectedCategory!,
      date: dateFormat.parse(dateController.text),
    );
    context.read<ExpenseTrackerProvider>().addExpense(expense: expense);
  }

  void _updateExpense() {
    widget.expense?.description = descriptionController.text;
    widget.expense?.amount = double.parse(amountController.text);
    widget.expense?.category = selectedCategory!;
    widget.expense?.date = dateFormat.parse(dateController.text);
    context
        .read<ExpenseTrackerProvider>()
        .updateExpense(expense: widget.expense!);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = dateFormat.parse(dateController.text);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000).subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        dateController.text = dateFormat.format(picked);
      });
    }
  }
}
