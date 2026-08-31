/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 23-08-2026 - 17:55
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:dio/dio.dart';
import 'package:expensetrackerapp/core/app_constants.dart';

class AddExpenseAttachmentApiProvider {
  final Dio dio;

  AddExpenseAttachmentApiProvider({
    required this.dio,
  });

  Future<Response> addAttachment({
    required int expenseId,
    required List<MultipartFile> files,
  }) {
    FormData formData = FormData();

    formData.fields.add(
      MapEntry(
        "expenseId",
        expenseId.toString(),
      ),
    );

    for (MultipartFile file in files) {
      formData.files.add(
        MapEntry(
          "files",
          file,
        ),
      );
    }

    return dio.post(
      AppConstants.addExpenseAttachmentUrl,
      data: formData,
    );
  }
}