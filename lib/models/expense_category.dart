// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ExpenseCategory {
  final String name;
  int totalExpense;
  final Color color;
  ExpenseCategory({
    required this.name,
    this.totalExpense = 0,
    required this.color,
  });

  static final List<ExpenseCategory> categories = [
    ExpenseCategory(name: 'Food', color: Colors.orange.shade50),
    ExpenseCategory(name: 'Healthcare', color: Colors.green.shade50),
    ExpenseCategory(name: 'Entertainment', color: Colors.red.shade50),
    ExpenseCategory(name: 'Clothing', color: Colors.blue.shade50),
    ExpenseCategory(name: 'Education', color: Colors.pink.shade50),
    ExpenseCategory(name: 'Travel', color: Colors.yellow.shade50),
    ExpenseCategory(name: 'Miscellaneous', color: Colors.purple.shade50),
  ];
}
