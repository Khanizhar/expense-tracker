import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/ui/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets('AddExpenseScreen showing all the required widgets',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const AddExpenseScreen(),
    ));

    expect(find.text('Add Expense'), findsNWidgets(2));
    expect(find.text('Enter Amount'), findsOneWidget);
    expect(find.text('Enter Description'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets(
      'AddExpenseScreen showing the Expense details initially when Expense is being edited',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: AddExpenseScreen(
          expense: Expense(
              id: '1',
              description: 'Test',
              amount: 100,
              date: DateTime.now(),
              category: 'Education'),
        ),
      ),
    );

    expect(find.text('Edit Expense'), findsOneWidget);
    expect(find.text('100.0'), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
    expect(find.text(DateFormat('dd-MM-yyyy').format(DateTime.now())),
        findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Update Expense'), findsOneWidget);
  });

  testWidgets('AddExpenseScreen validation working fine', (tester) async {
    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const AddExpenseScreen(),
    ));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Please Enter Expense Amount'), findsOneWidget);
    expect(find.text('Please Enter Description'), findsOneWidget);
    expect(find.text('Please Select Expense Category'), findsOneWidget);
  });
}
