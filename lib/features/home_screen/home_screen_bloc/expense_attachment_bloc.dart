/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026 - 17:44
 * Product Name: Expenzo
 * ________________________________
 */

/*
 * _______________________________
 * Created By: Rahul Kumar
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:dio/dio.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_bloc/expense_attachment_state.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_data/expense_attachment_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_model/expense_attachment_model.dart';

import 'expense_attachment_event.dart';

class ExpenseAttachmentListBloc
    extends Bloc<ExpenseAttachmentListEvent, ExpenseAttachmentListState> {
  final ExpenseAttachmentListRepo repo;

  ExpenseAttachmentListBloc({
    required this.repo,
  }) : super(ExpenseAttachmentListInitial()) {
    on<FetchExpenseAttachments>(_onFetchAttachments);
  }

  Future<void> _onFetchAttachments(
      FetchExpenseAttachments event,
      Emitter<ExpenseAttachmentListState> emit,
      ) async {
    emit(ExpenseAttachmentListLoading());

    try {
      final response = await repo.fetchAttachments(event.expenseId);

      final List<dynamic> data = response.data;
      final attachments =
      data.map((json) => ExpenseAttachment.fromJson(json)).toList();

      emit(ExpenseAttachmentListSuccess(attachments: attachments));
    } on DioException catch (e) {
      String message = "Failed to load attachments.";

      if (e.response?.data is Map && e.response?.data["message"] != null) {
        message = e.response?.data["message"];
      }

      emit(ExpenseAttachmentListFailure(message: message));
    } catch (e) {
      emit(
        ExpenseAttachmentListFailure(
          message: "Something went wrong while loading attachments.",
        ),
      );
    }
  }
}