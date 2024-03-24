import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/service/storage_service.dart';
import 'package:flutter/material.dart';

class ExpenseTrackerProvider extends ChangeNotifier {
  final StorageService _storageService;
  ExpenseTrackerProvider(StorageService storageService)
      : _storageService = storageService {
    allExpenses = _storageService.getAllExpenses();
  }
  DateTime _selectedMonth = DateTime.now();
  DateTime get selectedMonthDate => _selectedMonth;
  set selectedMonthDate(DateTime newMonth) {
    _selectedMonth = newMonth;
    notifyListeners();
  }

  List<Expense> allExpenses = [];

  List<Expense> get expenses {
    return allExpenses
        .where((expense) => expense.date.month == selectedMonthDate.month)
        .toList()..sort((a,b)=>a.date.compareTo(b.date));
  }

  void addExpense({required Expense expense}) {
    allExpenses.add(expense);
    _storageService.addExpense(expense);
    notifyListeners();
  }

  void updateExpense({required Expense expense}) {
    expense.save();
    notifyListeners();
  }

  void removeExpense({required Expense expense}) {
    allExpenses.remove(expense);
    _storageService.deleteExpense(expense);
    notifyListeners();
  }
}
