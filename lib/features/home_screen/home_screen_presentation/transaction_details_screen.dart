/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 22-08-2026 - 19:56
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:expensetrackerapp/core/network/dio_client.dart';
import 'package:expensetrackerapp/core/storage/secure_storage_service.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_data/home_screen_api_provider.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_data/home_screen_repo.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_model/expense_model.dart';
import 'package:expensetrackerapp/shared/common_bloc/api_status.dart';
import 'package:expensetrackerapp/shared/common_bloc/common_bloc.dart';
import 'package:expensetrackerapp/shared/common_bloc/common_event.dart';
import 'package:expensetrackerapp/shared/common_bloc/common_state.dart';
import 'package:expensetrackerapp/shared/common_ui/app_background.dart';
import 'package:expensetrackerapp/shared/common_ui/common_header.dart';
import 'package:expensetrackerapp/shared/utils/build_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({
    super.key,
    required this.expense,
    required this.onBack,
  });

  final Expense expense;
  final VoidCallback onBack;

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  final CommonBloc _deleteBloc = CommonBloc();

  late final HomeScreenRepo _homeScreenRepo;

  @override
  void initState() {
    super.initState();

    _homeScreenRepo = HomeScreenRepo(
      HomeScreenApiProvider(
        DioClient(
          SecureStorageService(),
        ).dio,
      ),
    );
  }

  @override
  void dispose() {
    _deleteBloc.close();
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

  @override
  Widget build(BuildContext context) {
    final bool isIncome = widget.expense.transactionType == 1;

    final String transactionType = isIncome ? "Income" : "Expense";

    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity ,
            width: double.infinity,
            child: AppBackground(
              child: CommonHeader(
                headingName: "Transaction Details",
              ),
            ),
          ),
          Positioned.fill(
            top: 200,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
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
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: Text(
                              transactionType,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isIncome
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "\$${widget.expense.amount.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 32,
                      thickness: 1,
                      color: Color(0xFFEDEDED),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Status",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          transactionType,
                          style: TextStyle(
                            color:
                            isIncome ? Colors.green : Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isIncome ? "From" : "To",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(widget.expense.category),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Payment Mode",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(widget.expense.paymentMode),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Date",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          DateFormat('MMMM d, yyyy')
                              .format(widget.expense.expenseDate),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Spent At",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(widget.expense.periodOfDay),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Created On",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "${DateFormat('dd/MM/yyyy').format(widget.expense.createdDate)} • "
                              "${DateFormat('hh:mm a').format(widget.expense.createdDate)}",
                        ),
                      ],
                    ),
                    if (widget.expense.description.trim().isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Description",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Flexible(
                            child: Text(
                              widget.expense.description,
                              textAlign: TextAlign.right,
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
                          const Text(
                            "Last Edited",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            widget.expense.updatedDate!
                                .toString()
                                .split('.')[0],
                          ),
                        ],
                      ),
                    ],
                    const Divider(
                      height: 32,
                      thickness: 1,
                      color: Color(0xFFEDEDED),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "\$${widget.expense.amount.toStringAsFixed(2)}",
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<CommonBloc, CommonState>(
                      bloc: _deleteBloc,
                      builder: (context, state) {
                        final bool isDeleting =
                        state.apiStatus is ApiLoadingState;
                
                        return BuildSubmitButton(
                          text: isDeleting
                              ? "Deleting..."
                              : "Delete Transaction",
                          buttonColor: Colors.red,
                          onPressed: isDeleting
                              ? () {}
                              : () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text(
                                  "Delete transaction?",
                                ),
                                content: const Text(
                                  "This action can't be undone.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                      context,
                                      false,
                                    ),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                      context,
                                      true,
                                    ),
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.redAccent,
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