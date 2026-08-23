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
      await repo.addExpense(event.request);

      emit(AddExpenseSuccess());
    } catch (e) {
      emit(AddExpenseFailure(e.toString()));
    }
  }
}