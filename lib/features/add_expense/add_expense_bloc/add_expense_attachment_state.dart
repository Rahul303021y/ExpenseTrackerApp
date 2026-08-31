/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 23-08-2026 - 18:04
 * Product Name: Expenzo
 * ________________________________
 */

abstract class AddExpenseAttachmentState {}

class AddExpenseAttachmentInitial extends AddExpenseAttachmentState {}

class AddExpenseAttachmentLoading extends AddExpenseAttachmentState {}

class AddExpenseAttachmentSuccess extends AddExpenseAttachmentState {}

class AddExpenseAttachmentFailure extends AddExpenseAttachmentState {
  final String message;

  AddExpenseAttachmentFailure({
    required this.message,
  });
}