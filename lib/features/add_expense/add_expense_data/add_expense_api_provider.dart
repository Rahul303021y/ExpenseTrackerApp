/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 05-08-2026 - 19:54
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:dio/dio.dart';
import 'package:expensetrackerapp/core/app_constants.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_model/add_expense_request_model.dart';

class AddExpenseApiProvider {
  final Dio dio;

  AddExpenseApiProvider(this.dio);

  Future<Response> addExpense(AddExpenseRequest request) {
    return dio.post(AppConstants.addExpenseUrl, data: request.toJson());
  }
}
