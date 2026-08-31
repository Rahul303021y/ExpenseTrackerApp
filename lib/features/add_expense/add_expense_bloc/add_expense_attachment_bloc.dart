/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 23-08-2026 - 18:03
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:expensetrackerapp/features/add_expense/add_expense_data/add_expense_attachment_repo.dart';
import 'add_expense_attachment_event.dart';
import 'add_expense_attachment_state.dart';

class AddExpenseAttachmentBloc
    extends Bloc<AddExpenseAttachmentEvent, AddExpenseAttachmentState> {
  final AddExpenseAttachmentRepo repo;

  AddExpenseAttachmentBloc({
    required this.repo,
  }) : super(AddExpenseAttachmentInitial()) {
    on<UploadExpenseAttachmentEvent>(_uploadAttachment);
  }

  Future<void> _uploadAttachment(
      UploadExpenseAttachmentEvent event,
      Emitter<AddExpenseAttachmentState> emit,
      ) async {
    emit(AddExpenseAttachmentLoading());

    try {
      List<MultipartFile> files = [];

      for (String filePath in event.filePaths) {
        MultipartFile file = await MultipartFile.fromFile(filePath);
        files.add(file);
      }

      await repo.addExpense(
        expenseId: event.expenseId,
        files: files,
      );

      emit(AddExpenseAttachmentSuccess());
    } on DioException catch (e) {
      debugPrint("Attachment upload DioException:");
      debugPrint("  type: ${e.type}");
      debugPrint("  message: ${e.message}");
      debugPrint("  statusCode: ${e.response?.statusCode}");
      debugPrint("  responseData: ${e.response?.data}");

      String message = "Failed to upload attachments.";

      if (e.response?.data is Map &&
          e.response?.data["message"] != null) {
        message = e.response?.data["message"];
      }

      emit(
        AddExpenseAttachmentFailure(
          message: message,
        ),
      );
    } catch (e) {
      emit(
        AddExpenseAttachmentFailure(
          message: "Something went wrong while uploading attachments.",
        ),
      );
    }
  }
}