/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 23-08-2026 - 17:58
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:dio/dio.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_data/add_expense_attachment_api_provider.dart';

class AddExpenseAttachmentRepo {
  final AddExpenseAttachmentApiProvider apiProvider;

  AddExpenseAttachmentRepo(
      this.apiProvider,
      );

  Future<Response> addExpense({
    required int expenseId,
    required List<MultipartFile> files,
  }) async {
    return await apiProvider.addAttachment(
      expenseId: expenseId,
      files: files,
    );
  }
}