import 'package:dio/dio.dart';

class HomeScreenApiProvider {
  final Dio dio;

  HomeScreenApiProvider(this.dio);

  Future<Response> getExpenses() {
    return dio.post(
      "/expense/get-all-expenses",
      data: {
        "maxResults": 10,
        "pageNum": 1,
        "sortBy": "",
      },
    );
  }

  Future<Response> fetchAccountSummary() {
    return dio.get("/account-summary/get-monthly-summary");
  }

  Future<Response> deleteExpense(int expenseId) {
    return dio.delete("/expense/delete-expense/$expenseId");
  }
}
