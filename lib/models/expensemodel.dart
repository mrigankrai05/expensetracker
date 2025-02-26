import 'package:uuid/uuid.dart';

class Expensemodel {
  Expensemodel(
    {
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }): id = Uuid().v4();
  
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
}