import 'package:expense_tracker/data/hive_helper.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  late Box<Expense> _expenseBox;
  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseAdapter());
    _expenseBox = await Hive.openBox<Expense>(HiveBoxes.expenseBox);
  }

  List<Expense> getAllExpenses() => _expenseBox.values.toList();
  void addExpense(Expense expense) => _expenseBox.put(expense.id, expense);

  void deleteExpense(Expense expense) => expense.delete(); 
}
