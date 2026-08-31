/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026 - 17:45
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:dio/dio.dart';
import 'package:expensetrackerapp/core/app_constants.dart';

class ExpenseAttachmentListApiProvider {
  final Dio dio;

  ExpenseAttachmentListApiProvider({
    required this.dio,
  });

  Future<Response> fetchAttachments(int expenseId) {
    return dio.get("${AppConstants.getAttachmentsUrl}$expenseId");
  }

  Future<Response> downloadAttachment(String uuid) {
    return dio.get(
      "${AppConstants.downloadAttachmentUrl}$uuid",
      options: Options(responseType: ResponseType.bytes),
    );
  }
}