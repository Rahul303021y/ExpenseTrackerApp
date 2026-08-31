/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 05-08-2026 - 19:46
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:expensetrackerapp/features/add_expense/add_expense_model/add_expense_response_model.dart';

abstract class AddExpenseState {}

class AddExpenseInitial extends AddExpenseState {}

class AddExpenseLoading extends AddExpenseState {}

class AddExpenseSuccess extends AddExpenseState {
  final AddExpenseResponseModel response;

  AddExpenseSuccess({required this.response});
}

class AddExpenseFailure extends AddExpenseState {
  final String message;

  AddExpenseFailure(this.message);
}