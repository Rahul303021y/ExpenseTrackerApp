/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026 - 17:46
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:dio/dio.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_data/expense_attachment_api_provider.dart';

class ExpenseAttachmentListRepo {
  final ExpenseAttachmentListApiProvider apiProvider;

  ExpenseAttachmentListRepo(
      this.apiProvider,
      );

  Future<Response> fetchAttachments(int expenseId) async {
    return await apiProvider.fetchAttachments(expenseId);
  }

  Future<List<int>> downloadAttachmentBytes(String uuid) async {
    final response = await apiProvider.downloadAttachment(uuid);
    return response.data as List<int>;
  }
}