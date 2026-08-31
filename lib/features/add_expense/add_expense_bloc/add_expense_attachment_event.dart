/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 23-08-2026 - 18:03
 * Product Name: Expenzo
 * ________________________________
 */

abstract class AddExpenseAttachmentEvent {}

class UploadExpenseAttachmentEvent extends AddExpenseAttachmentEvent {
  final int expenseId;
  final List<String> filePaths;

  UploadExpenseAttachmentEvent({
    required this.expenseId,
    required this.filePaths,
  });
}