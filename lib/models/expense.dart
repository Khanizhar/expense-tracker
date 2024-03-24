import 'package:hive_flutter/adapters.dart';

part 'expense.g.dart';
@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String description;
  @HiveField(2)
  double amount;
  @HiveField(3)
   DateTime date;
   @HiveField(4)
  String category;

  Expense(
      {required this.id,
      required this.description,
      required this.amount,
      required this.date,
      required this.category});
}
