/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 18-08-2026 - 15:42
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:dio/dio.dart';

class ExpenseCategoryApiProvider {
  ExpenseCategoryApiProvider(this.dio);

  final Dio dio;

  Future<Response> getExpenseCategories() {
    return dio.get('/expense-category');
  }
}