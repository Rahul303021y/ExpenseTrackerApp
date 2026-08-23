import 'package:expensetrackerapp/features/home_screen/home_screen_model/expense_account_summary_model.dart';

import '../../../core/network/api_response.dart';
import '../home_screen_model/expense_data_model.dart';
import 'home_screen_api_provider.dart';

class HomeScreenRepo {
  final HomeScreenApiProvider homeScreenApiProvider;

  HomeScreenRepo(
      this.homeScreenApiProvider,
      );

  Future<ApiResponse<ExpenseData>> getExpenses() async {
    final response = await homeScreenApiProvider.getExpenses();

    return ApiResponse<ExpenseData>.fromJson(
      response.data,
          (json) => ExpenseData.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<ExpenseAccountSummaryModel>> fetchAccountSummary() async{
    final response = await homeScreenApiProvider.fetchAccountSummary();
    return ApiResponse<ExpenseAccountSummaryModel>.fromJson(
      response.data, (json) => ExpenseAccountSummaryModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<void> deleteExpense(int expenseId) async {
    await homeScreenApiProvider.deleteExpense(expenseId);
  }
}