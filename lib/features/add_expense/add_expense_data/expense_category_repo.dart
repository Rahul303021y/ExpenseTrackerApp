/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 18-08-2026 - 15:42
 * Product Name: Expenzo
 * ________________________________
 */

import '../add_expense_model/expense_category_model.dart';
import 'expense_category_api_provider.dart';

class ExpenseCategoryRepo {
  ExpenseCategoryRepo(this.apiProvider);

  final ExpenseCategoryApiProvider apiProvider;

  Future<List<ExpenseCategoryModel>> fetchCategories() async {
    final response = await apiProvider.getExpenseCategories();
    final data = response.data['data'] as List;
    return data.map((e) => ExpenseCategoryModel.fromJson(e)).toList();
  }
}