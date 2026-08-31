/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026 - 17:50
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:expensetrackerapp/features/home_screen/home_screen_model/expense_attachment_model.dart';

abstract class ExpenseAttachmentListState {}

class ExpenseAttachmentListInitial extends ExpenseAttachmentListState {}

class ExpenseAttachmentListLoading extends ExpenseAttachmentListState {}

class ExpenseAttachmentListSuccess extends ExpenseAttachmentListState {
  final List<ExpenseAttachment> attachments;

  ExpenseAttachmentListSuccess({required this.attachments});
}

class ExpenseAttachmentListFailure extends ExpenseAttachmentListState {
  final String message;

  ExpenseAttachmentListFailure({required this.message});
}