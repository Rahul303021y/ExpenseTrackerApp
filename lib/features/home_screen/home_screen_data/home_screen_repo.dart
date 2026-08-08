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
}