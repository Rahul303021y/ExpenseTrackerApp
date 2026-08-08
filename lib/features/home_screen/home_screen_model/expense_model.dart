class Expense {
  final int expenseId;
  final int userId;
  final String title;
  final String description;
  final double amount;
  final String category;
  final DateTime expenseDate;
  final String periodOfDay;
  final DateTime createdDate;
  final DateTime? updatedDate;
  final String paymentMode;
  final int transactionType;
  final String? invoiceUuid;

  Expense({
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
    this.invoiceUuid,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      expenseId: json['expenseId'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      category: json['category'],
      expenseDate: DateTime.parse(json['expenseDate']),
      periodOfDay: json['periodOfDay'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: json['updatedDate'] != null
          ? DateTime.parse(json['updatedDate'])
          : null,
      paymentMode: json['paymentMode'],
      transactionType: json['transactionType'],
      invoiceUuid: json['invoiceUuid'],
    );
  }
}
