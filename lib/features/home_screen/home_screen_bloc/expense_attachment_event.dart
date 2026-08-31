/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026 - 17:49
 * Product Name: Expenzo
 * ________________________________
 */

abstract class ExpenseAttachmentListEvent {}

class FetchExpenseAttachments extends ExpenseAttachmentListEvent {
  final int expenseId;

  FetchExpenseAttachments({required this.expenseId});
}