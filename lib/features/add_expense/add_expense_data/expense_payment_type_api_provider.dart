/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 18-08-2026 - 15:49
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:dio/dio.dart';

class ExpensePaymentTypeApiProvider{
  final Dio dio;
  ExpensePaymentTypeApiProvider(this.dio);
  Future<Response> getExpensePaymentType(){
    return dio.get("/payment-type");
  }
}