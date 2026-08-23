/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 22-08-2026 - 18:21
 * Product Name: Expenzo
 * ________________________________
 */

class ExpenseAccountSummaryModel {
  ExpenseAccountSummaryModel({
    required this.accountSummaryId,
    required this.userId,
    required this.accountMonth,
    required this.initialBalance,
    required this.availableBalance,
    required this.totalIncome,
    required this.totalExpense,
    required this.createdDate,
    required this.updatedDate,
  });

  final int accountSummaryId;
  final int userId;
  final String accountMonth;
  final num initialBalance;
  final num availableBalance;
  final num totalIncome;
  final num totalExpense;
  final String createdDate;
  final String updatedDate;

  factory ExpenseAccountSummaryModel.fromJson(Map<String, dynamic> json) {
    return ExpenseAccountSummaryModel(
      accountSummaryId: json['accountSummaryId'] as int,
      userId: json['userId'] as int,
      accountMonth: json['accountMonth']?.toString() ?? '',
      initialBalance: json['initialBalance'] as num? ?? 0,
      availableBalance: json['availableBalance'] as num? ?? 0,
      totalIncome: json['totalIncome'] as num? ?? 0,
      totalExpense: json['totalExpense'] as num? ?? 0,
      createdDate: json['createdDate']?.toString() ?? '',
      updatedDate: json['updatedDate']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountSummaryId': accountSummaryId,
      'userId': userId,
      'accountMonth': accountMonth,
      'initialBalance': initialBalance,
      'availableBalance': availableBalance,
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
    };
  }
}