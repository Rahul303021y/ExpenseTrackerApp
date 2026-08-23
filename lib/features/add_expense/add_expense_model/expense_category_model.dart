/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 18-08-2026 - 15:42
 * Product Name: Expenzo
 * ________________________________
 */

class ExpenseCategoryModel {
  ExpenseCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryCode,
  });

  final int categoryId;
  final String categoryName;
  final String categoryCode;

  factory ExpenseCategoryModel.fromJson(Map<String, dynamic> json) {
    return ExpenseCategoryModel(
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName']?.toString() ?? '',
      categoryCode: json['categoryCode']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryCode': categoryCode,
    };
  }
}