import 'package:expense_tracker/providers/expense_tracker_provider.dart';
import 'package:expense_tracker/service/storage_service.dart';
import 'package:expense_tracker/ui/screens/expense_tracker_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = StorageService();
  await storageService.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseTrackerProvider(storageService),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: const ExpenseTrackerScreen(),
      ),
    ),
  );
}
