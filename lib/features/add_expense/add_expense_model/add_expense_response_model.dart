/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 23-08-2026 - 18:34
 * Product Name: Expenzo
 * ________________________________
 */

class AddExpenseResponseModel {
  final int expenseId;
  final int userId;
  final String title;
  final String description;
  final double amount;
  final String category;
  final String expenseDate;
  final String periodOfDay;
  final String createdDate;
  final String? updatedDate;
  final String paymentMode;
  final int transactionType;

  AddExpenseResponseModel({
    required this.expenseId,
    required this.userId,
    required this.title,
    required this.description,
    required this.amount,
    required this.category,
    required this.expenseDate,
    required this.periodOfDay,
    required this.createdDate,
    this.updatedDate,
    required this.paymentMode,
    required this.transactionType,
  });

  factory AddExpenseResponseModel.fromJson(Map<String, dynamic> json) {
    return AddExpenseResponseModel(
      expenseId: json["expenseId"],
      userId: json["userId"],
      title: json["title"],
      description: json["description"] ?? "",
      amount: (json["amount"] as num).toDouble(),
      category: json["category"],
      expenseDate: json["expenseDate"],
      periodOfDay: json["periodOfDay"],
      createdDate: json["createdDate"],
      updatedDate: json["updatedDate"],
      paymentMode: json["paymentMode"],
      transactionType: json["transactionType"],
    );
  }
}