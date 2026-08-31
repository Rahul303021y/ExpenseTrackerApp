/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 05-08-2026 - 19:55
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:dio/dio.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_data/add_expense_api_provider.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_model/add_expense_request_model.dart';

class AddExpenseRepo {
  final AddExpenseApiProvider apiProvider;

  AddExpenseRepo(this.apiProvider);

  Future<Response> addExpense(AddExpenseRequest request) async {
    return await apiProvider.addExpense(request);
  }
}
