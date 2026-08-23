import 'expense_model.dart';

class ExpenseData {
  final int count;
  final List<Expense> expenseList;

  ExpenseData({
    required this.count,
    required this.expenseList,
  });

  factory ExpenseData.fromJson(Map<String, dynamic> json) {
    return ExpenseData(
      count: json['count'],
      expenseList: (json['expenseList'] as List)
          .map((e) => Expense.fromJson(e))
          .toList(),
    );
  }
}