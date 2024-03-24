import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense_tracker_provider.dart';
import 'package:expense_tracker/ui/screens/expense_tracker_screen.dart';
import 'package:expense_tracker/ui/widgets/expense_card.dart';
import 'package:expense_tracker/ui/widgets/no_expense_found.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockExpenseTrackerProvider extends Mock
    implements ExpenseTrackerProvider {}

void main() {
  testWidgets(
      'ExpenseTrackerScreen show NoExpenseFound if there is no expense Data',
      (tester) async {
    final ExpenseTrackerProvider mockExpenseTrackerProvider =
        MockExpenseTrackerProvider();
    when(() => mockExpenseTrackerProvider.expenses).thenReturn(<Expense>[]);

    await tester.pumpWidget(ChangeNotifierProvider.value(
      value: mockExpenseTrackerProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: const ExpenseTrackerScreen(),
      ),
    ));

    expect(find.byType(NoExpenseFound), findsOneWidget);
  });

  testWidgets(
      'ExpenseTrackerScreen show 1 Expense card if there only 1 expense Data',
      (tester) async {
    final ExpenseTrackerProvider mockExpenseTrackerProvider =
        MockExpenseTrackerProvider();
    when(() => mockExpenseTrackerProvider.expenses).thenReturn(<Expense>[
      Expense(
          id: '1',
          description: 'test',
          amount: 12,
          date: DateTime.now(),
          category: 'dummy')
    ]);

    await tester.pumpWidget(ChangeNotifierProvider.value(
      value: mockExpenseTrackerProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: const ExpenseTrackerScreen(),
      ),
    ));

    expect(find.byType(NoExpenseFound), findsNothing);
    expect(find.byType(ExpenseCard), findsOneWidget);
    expect(find.byType(PieChart), findsNothing);
  });

  testWidgets(
      'ExpenseTrackerScreen show PieChart (i.e. expense summary) if there are 2 or more expense Data',
      (tester) async {
    final ExpenseTrackerProvider mockExpenseTrackerProvider =
        MockExpenseTrackerProvider();
    when(() => mockExpenseTrackerProvider.expenses).thenReturn(<Expense>[
      Expense(
          id: '1',
          description: 'test',
          amount: 12,
          date: DateTime.now(),
          category: 'Education'),
      Expense(
          id: '2',
          description: 'test',
          amount: 12,
          date: DateTime.now(),
          category: 'Education'),
    ]);

    await tester.pumpWidget(ChangeNotifierProvider.value(
      value: mockExpenseTrackerProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: const ExpenseTrackerScreen(),
      ),
    ));

    expect(find.byType(ExpenseCard), findsNWidgets(2));
    expect(find.byType(PieChart), findsOneWidget);
  });
}
