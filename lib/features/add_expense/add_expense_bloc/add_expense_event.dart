/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 05-08-2026 - 19:46
 * Product Name: Expenzo
 * ________________________________
 */

import '../add_expense_model/add_expense_request_model.dart';

abstract class AddExpenseEvent {}

class AddExpenseSubmitted extends AddExpenseEvent {
  final AddExpenseRequest request;

  AddExpenseSubmitted({required this.request});
}