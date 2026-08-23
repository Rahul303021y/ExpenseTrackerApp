/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 22-08-2026 - 17:38
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:expensetrackerapp/features/add_expense/add_expense_data/expense_time_of_day_api_provider.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_model/expense_time_of_day_model.dart';

class ExpenseTimeOfDayRepo{
  final ExpenseTimeOfDayApiProvider expenseTimeOfDayApiProvider;
  ExpenseTimeOfDayRepo(this.expenseTimeOfDayApiProvider);
  Future<List<ExpenseTimeOfDayModel>> fetchTimeOfDay() async{
    final response = await expenseTimeOfDayApiProvider.fetchAllTimeOfDay();
    final data = response.data['data'] as List;
    return data.map((e)=> ExpenseTimeOfDayModel.fromJson(e)).toList();
  }
}