/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 18-08-2026 - 15:54
 * Product Name: Expenzo
 * ________________________________
 */

class ExpensePaymentTypeModel {
  ExpensePaymentTypeModel({
    required this.paymentTypeId,
    required this.paymentTypeName,
    required this.paymentTypeCode,
  });

  final int paymentTypeId;
  final String paymentTypeName;
  final String paymentTypeCode;

  factory ExpensePaymentTypeModel.fromJson(Map<String, dynamic> json) {
    return ExpensePaymentTypeModel(
      paymentTypeId: json['paymentTypeId'] as int,
      paymentTypeName: json['paymentTypeName']?.toString() ?? "",
      paymentTypeCode: json['paymentTypeCode']?.toString() ?? "",
    );
  }
  Map<String, dynamic> toJson(){
    return{
      'paymentTypeId':paymentTypeId,
      'paymentTypeName':paymentTypeName,
      'paymentTypeCode': paymentTypeCode
    };
  }
}
