/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 05-08-2026 - 19:46
 * Product Name: Expenzo
 * ________________________________
 */

abstract class AddExpenseState {}

class AddExpenseInitial extends AddExpenseState {}

class AddExpenseLoading extends AddExpenseState {}

class AddExpenseSuccess extends AddExpenseState {}

class AddExpenseFailure extends AddExpenseState {
  final String message;

  AddExpenseFailure(this.message);
}