/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 07-08-2026 - 19:55
 * Product Name: Expenzo
 * ________________________________
 */

class AddExpenseRequest {
  final int? expenseId;
  final String title;
  final String description;
  final double amount;
  final DateTime expenseDate;
  final String paymentMode;
  final String periodOfDay;
  final String category;
  final int transactionType;
  final String invoiceUuid;

  AddExpenseRequest({
    this.expenseId,
    required this.title,
    required this.description,
    required this.amount,
    required this.expenseDate,
    required this.paymentMode,
    required this.periodOfDay,
    required this.category,
    required this.transactionType,
    required this.invoiceUuid,
  });

  Map<String, dynamic> toJson() {
    return {
      "expenseId": expenseId,
      "title": title,
      "description": description,
      "amount": amount,
      "expenseDate": expenseDate.toIso8601String().split('T').first,
      "paymentMode": paymentMode,
      "periodOfDay": periodOfDay,
      "category": category,
      "transactionType": transactionType,
      "invoiceUuid": invoiceUuid,
    };
  }
}
