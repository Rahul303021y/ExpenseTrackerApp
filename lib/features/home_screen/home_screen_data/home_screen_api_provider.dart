import 'package:dio/dio.dart';
import 'package:expensetrackerapp/core/app_constants.dart';

class HomeScreenApiProvider {
  final Dio dio;

  HomeScreenApiProvider(this.dio);

  Future<Response> getExpenses() {
    return dio.post(
      AppConstants.getExpensesUrl,
      data: {
        "maxResults": 10,
        "pageNum": 1,
        "sortBy": "",
      },
    );
  }

  Future<Response> fetchAccountSummary() {
    return dio.get(AppConstants.fetchAccountSummaryUrl);
  }

  Future<Response> deleteExpense(int expenseId) {
    return dio.delete("${AppConstants.deleteExpenseUrl}$expenseId");
  }
}
