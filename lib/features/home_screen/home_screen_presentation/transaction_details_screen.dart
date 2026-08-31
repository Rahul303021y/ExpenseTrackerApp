/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 22-08-2026 - 19:56
 * Product Name: Expenzo
 * ________________________________
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:expensetrackerapp/core/localization/locale_keys.dart';
import 'package:expensetrackerapp/core/network/dio_client.dart';
import 'package:expensetrackerapp/core/storage/secure_storage_service.dart';
import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_bloc/expense_attachment_event.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_data/expense_attachment_api_provider.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_data/home_screen_api_provider.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_data/home_screen_repo.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_model/expense_attachment_model.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_model/expense_model.dart';
import 'package:expensetrackerapp/shared/common_bloc/api_status.dart';
import 'package:expensetrackerapp/shared/common_bloc/common_bloc.dart';
import 'package:expensetrackerapp/shared/common_bloc/common_event.dart';
import 'package:expensetrackerapp/shared/common_bloc/common_state.dart';
import 'package:expensetrackerapp/shared/common_ui/app_background.dart';
import 'package:expensetrackerapp/shared/common_ui/common_header.dart';
import 'package:expensetrackerapp/shared/utils/build_submit_button.dart';
import 'package:expensetrackerapp/shared/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../common/attachment_grid.dart';
import '../common/full_screen_image_viewer.dart';
import '../home_screen_bloc/expense_attachment_bloc.dart';
import '../home_screen_bloc/expense_attachment_state.dart';
import '../home_screen_data/expense_attachment_repo.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  final CommonBloc _deleteBloc = CommonBloc();

  late final HomeScreenRepo _homeScreenRepo;
  late final ExpenseAttachmentListRepo _attachmentRepo;
  late final ExpenseAttachmentListBloc _attachmentBloc;

  bool _isOpeningPdf = false;

  @override
  void initState() {
    super.initState();

    _homeScreenRepo = HomeScreenRepo(
      HomeScreenApiProvider(
        DioClient(SecureStorageService()).dio,
      ),
    );

    _attachmentRepo = ExpenseAttachmentListRepo(
      ExpenseAttachmentListApiProvider(
        dio: DioClient(SecureStorageService()).dio,
      ),
    );

    _attachmentBloc = ExpenseAttachmentListBloc(repo: _attachmentRepo)
      ..add(FetchExpenseAttachments(expenseId: widget.expense.expenseId));
  }

  @override
  void dispose() {
    _deleteBloc.close();
    _attachmentBloc.close();
    super.dispose();
  }

  void _deleteExpense() {
    _deleteBloc.add(
      CallApiEvent(
        apiCall: () => _homeScreenRepo.deleteExpense(
          widget.expense.expenseId,
        ),
        isList: false,
      ),
    );
  }

  Future<Uint8List> _fetchAttachmentBytes(String uuid) async {
    final bytes = await _attachmentRepo.downloadAttachmentBytes(uuid);
    return Uint8List.fromList(bytes);
  }

  void _openImageFullScreen(ExpenseAttachment attachment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenImageViewer(
          fetchBytes: _fetchAttachmentBytes(attachment.uuid),
          fileName: attachment.fileName,
        ),
      ),
    );
  }

  Future<void> _openPdf(ExpenseAttachment attachment) async {
    if (_isOpeningPdf) return;
    setState(() => _isOpeningPdf = true);

    try {
      final bytes = await _fetchAttachmentBytes(attachment.uuid);
      final tempDir = await getTemporaryDirectory();
      final file = File("${tempDir.path}/${attachment.fileName}");
      await file.writeAsBytes(bytes);

      await OpenFile.open(file.path);
    } catch (e) {
      if (mounted) {
        CustomSnackbar.error(context, LocaleKeys.failedToOpenPDF.tr(context));
      }
    } finally {
      if (mounted) setState(() => _isOpeningPdf = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isIncome = widget.expense.transactionType == 1;

    final String transactionType = isIncome ? "Income" : "Expense";

    return Material(
      color: Theme.of(context).appColors.background,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: AppBackground(
              child: CommonHeader(
                headingName: LocaleKeys.transactionDetails.tr(context),
              ),
            ),
          ),
          Positioned.fill(
            top: 180,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              decoration: BoxDecoration(
                color: Theme.of(context).appColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(radius: 40),
                          const SizedBox(height: 8),
                          Text(
                            widget.expense.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              wordSpacing: 4,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 11,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).appColors.shadow,
                                  blurRadius: 2,
                                ),
                              ],
                              color: Theme.of(context).appColors.surfaceContainer,
                            ),
                            child: Text(
                              transactionType,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color:
                                    isIncome ? Theme.of(context).appColors.income: Theme.of(context).appColors.expense,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "₹ ${widget.expense.amount.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              letterSpacing: 2,
                              color: Theme.of(context).appColors.textPrimary
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 32,
                      thickness: 1,
                      color: Theme.of(context).appColors.outlineVariant,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.status.tr(context),
                          style: TextStyle(color: Theme.of(context).appColors.textSecondary),
                        ),
                        Text(
                          transactionType,
                          style: TextStyle(
                            color: isIncome ? Theme.of(context).appColors.income : Theme.of(context).appColors.expense,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isIncome
                              ? LocaleKeys.from.tr(context)
                              : LocaleKeys.to.tr(context),
                          style: TextStyle(color: Theme.of(context).appColors.textSecondary),
                        ),
                        Text(widget.expense.category, style: TextStyle(color: Theme.of(context).appColors.textPrimary),),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.paymentMode.tr(context),
                          style: TextStyle(color: Theme.of(context).appColors.textSecondary),
                        ),
                        Text(widget.expense.paymentMode,  style: TextStyle(color: Theme.of(context).appColors.textPrimary),),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.date.tr(context),
                          style: TextStyle(color: Theme.of(context).appColors.textSecondary),
                        ),
                        Text(
                          DateFormat('MMMM d, yyyy')
                              .format(widget.expense.expenseDate), style: TextStyle(color: Theme.of(context).appColors.textPrimary)
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.spentAt.tr(context),
                          style: TextStyle(color:Theme.of(context).appColors.textSecondary),
                        ),
                        Text(widget.expense.periodOfDay,  style: TextStyle(color: Theme.of(context).appColors.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.createdOn.tr(context),
                          style: TextStyle(color:Theme.of(context).appColors.textSecondary),
                        ),
                        Text(
                          "${DateFormat('dd/MM/yyyy').format(widget.expense.createdDate)} • "
                          "${DateFormat('hh:mm a').format(widget.expense.createdDate)}",  style: TextStyle(color: Theme.of(context).appColors.textPrimary)
                        ),
                      ],
                    ),
                    if (widget.expense.description.trim().isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.description.tr(context),
                            style: TextStyle(color:Theme.of(context).appColors.textSecondary),
                          ),
                          Flexible(
                            child: Text(
                              widget.expense.description,
                              textAlign: TextAlign.right, style: TextStyle(color: Theme.of(context).appColors.textPrimary)
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (widget.expense.updatedDate != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.lastEdited.tr(context),
                            style: TextStyle(color: Theme.of(context).appColors.textSecondary),
                          ),
                          Text(
                            widget.expense.updatedDate!
                                .toString()
                                .split('.')[0],  style: TextStyle(color: Theme.of(context).appColors.textPrimary)
                          ),
                        ],
                      ),
                    ],
                    Divider(
                      height: 32,
                      thickness: 1,
                      color: Theme.of(context).appColors.outlineVariant,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.total.tr(context),
                          style: TextStyle(color:Theme.of(context).appColors.textSecondary),
                        ),
                        Text(
                          "₹${widget.expense.amount.toStringAsFixed(2)}",  style: TextStyle(color: Theme.of(context).appColors.textPrimary)
                        ),
                      ],
                    ),
                    Divider(
                      height: 32,
                      thickness: 1,
                      color:Theme.of(context).appColors.outlineVariant,
                    ),
                    BlocBuilder<ExpenseAttachmentListBloc,
                        ExpenseAttachmentListState>(
                      bloc: _attachmentBloc,
                      builder: (context, state) {
                        if (state is ExpenseAttachmentListLoading) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          );
                        }

                        if (state is ExpenseAttachmentListFailure) {
                          return const SizedBox.shrink();
                        }

                        if (state is ExpenseAttachmentListSuccess) {
                          if (state.attachments.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.attachments.tr(context),
                                  style: TextStyle(color: Theme.of(context).appColors.textSecondary),
                                ),
                                const SizedBox(height: 8),
                                AttachmentGrid(
                                  attachments: state.attachments,
                                  fetchBytes: _fetchAttachmentBytes,
                                  onImageTap: _openImageFullScreen,
                                  onPdfTap: _openPdf,
                                ),
                              ],
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<CommonBloc, CommonState>(
                      bloc: _deleteBloc,
                      builder: (context, state) {
                        final bool isDeleting =
                            state.apiStatus is ApiLoadingState;

                        return BuildSubmitButton(
                          text: isDeleting
                              ? LocaleKeys.deleting.tr(context)
                              : LocaleKeys.deleteTransaction.tr(context),
                          buttonColor: Colors.red,
                          onPressed: isDeleting
                              ? () {}
                              : () async {
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text(
                                        LocaleKeys
                                            .areYouSureYouWantToDeleteThisTransaction
                                            .tr(context),
                                      ),
                                      content: Text(
                                        LocaleKeys.thisActionCantBeUndone
                                            .tr(context),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                            context,
                                            false,
                                          ),
                                          child: Text(
                                              LocaleKeys.cancel.tr(context)),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                            context,
                                            true,
                                          ),
                                          child: Text(
                                            LocaleKeys.delete.tr(context),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .error,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirmed == true) {
                                    _deleteExpense();
                                  }
                                },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
