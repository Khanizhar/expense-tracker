import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/providers/expense_tracker_provider.dart';
import 'package:expense_tracker/service/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageService extends Mock implements StorageService {}

void main() {
  late MockStorageService mockStorageService;
  setUp(() {
    mockStorageService = MockStorageService();
  });
  test(
      'When ExpenseTrackerProvider object created then selected month is todays month',
      () {
    when(() => mockStorageService.getAllExpenses()).thenReturn(<Expense>[]);
    final sut = ExpenseTrackerProvider(mockStorageService);
    expect(sut.selectedMonthDate.month, DateTime.now().month);
  });

  test(
      'When ExpenseTrackerProvider object created then expenses is empty initially',
      () {
    when(() => mockStorageService.getAllExpenses()).thenReturn(<Expense>[]);
    final sut = ExpenseTrackerProvider(mockStorageService);
    expect(sut.expenses.isEmpty, isTrue);
  });

  test('addExpense working as expected', () {
    when(() => mockStorageService.getAllExpenses()).thenReturn(<Expense>[]);
    final sut = ExpenseTrackerProvider(mockStorageService);
    expect(sut.expenses.isEmpty, isTrue);
    sut.addExpense(
        expense: Expense(
            id: '1',
            description: 'test',
            amount: 12,
            date: DateTime.now(),
            category: 'dummy'));
    expect(sut.expenses.length, 1);
  });

  test('removeExpense working as expected', () {
    final mockExpense = Expense(
        id: '1',
        description: 'test',
        amount: 12,
        date: DateTime.now(),
        category: 'dummy');
    when(() => mockStorageService.getAllExpenses())
        .thenReturn(<Expense>[mockExpense]);

    final sut = ExpenseTrackerProvider(mockStorageService);
    expect(sut.expenses.length, 1);
    sut.removeExpense(expense: mockExpense);
    expect(sut.expenses.length, 0);
  });
}
