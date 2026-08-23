/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 18-08-2026 - 15:53
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:expensetrackerapp/features/add_expense/add_expense_data/expense_payment_type_api_provider.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_model/expense_payment_type_model.dart';

class ExpensePaymentTypeRepo {
  final ExpensePaymentTypeApiProvider apiProvider;

  ExpensePaymentTypeRepo(this.apiProvider);

  Future<List<ExpensePaymentTypeModel>> fetchPaymentType() async {
    final response = await apiProvider.getExpensePaymentType();
    final data = response.data['data'] as List;
    return data.map((e) => ExpensePaymentTypeModel.fromJson(e)).toList();
  }
}
