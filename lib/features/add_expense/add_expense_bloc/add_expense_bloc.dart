/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 05-08-2026 - 19:45
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:expensetrackerapp/features/add_expense/add_expense_bloc/add_expense_event.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_bloc/add_expense_state.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_data/add_expense_repo.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_model/add_expense_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final AddExpenseRepo repo;

  AddExpenseBloc(this.repo) : super(AddExpenseInitial()) {
    on<AddExpenseSubmitted>(_onAddExpenseSubmitted);
  }

  Future<void> _onAddExpenseSubmitted(
      AddExpenseSubmitted event,
      Emitter<AddExpenseState> emit,
      ) async {
    emit(AddExpenseLoading());

    try {
      final result = await repo.addExpense(event.request);

      final responseData =
      AddExpenseResponseModel.fromJson(result.data["data"]);

      emit(AddExpenseSuccess(response: responseData));
    } catch (e) {
      emit(AddExpenseFailure(e.toString()));
    }
  }
}