import 'package:expensetrackerapp/features/add_expense/add_expense_bloc/add_expense_bloc.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_bloc/add_expense_event.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_bloc/add_expense_state.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_model/add_expense_request_model.dart';
import 'package:expensetrackerapp/shared/common_ui/app_background.dart';
import 'package:expensetrackerapp/shared/common_ui/build_amount_field.dart';
import 'package:expensetrackerapp/shared/common_ui/build_date_field.dart';
import 'package:expensetrackerapp/shared/common_ui/common_header.dart';
import 'package:expensetrackerapp/shared/common_ui/field_label.dart';
import 'package:expensetrackerapp/shared/utils/bottom_curve_clipper.dart';
import 'package:expensetrackerapp/shared/utils/build_attachment_button.dart';
import 'package:expensetrackerapp/shared/utils/build_submit_button.dart';
import 'package:expensetrackerapp/shared/utils/custom_snackbar.dart';
import 'package:expensetrackerapp/shared/utils/custom_text_field.dart';
import 'package:expensetrackerapp/shared/common_ui/build_name_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_screen/common/home_screen_header.dart';

class AddExpenseScreen extends StatefulWidget {
  final VoidCallback onSubmitSuccess;

  const AddExpenseScreen({super.key, required this.onSubmitSuccess});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  static const double _cardOverlap = 140;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String? _selectedCategory;
  String? _selectedPaymentMode;
  String? _selectedPeriodOfDay;
  String? _selectedTransactionType;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }
  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _amountController.clear();

    setState(() {
      _selectedCategory = null;
      _selectedPaymentMode = null;
      _selectedPeriodOfDay = null;
      _selectedTransactionType = null;
      _selectedDate = DateTime.now();
    });
  }

  void _submitExpense() {
    final amount = double.tryParse(_amountController.text.trim());

    if (_titleController.text.trim().isEmpty) {
      _showError("Please enter a title");
      return;
    }

    if (amount == null || amount <= 0) {
      _showError("Please enter a valid amount");
      return;
    }

    if (_selectedCategory == null) {
      _showError("Please select a category");
      return;
    }

    if (_selectedPaymentMode == null) {
      _showError("Please select a payment mode");
      return;
    }

    if (_selectedTransactionType == null) {
      _showError("Please select a transaction type");
      return;
    }

    if (_selectedPeriodOfDay == null) {
      _showError("Please select the period of day");
      return;
    }

    final request = AddExpenseRequest(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      amount: amount,
      expenseDate: _selectedDate,
      paymentMode: _selectedPaymentMode!,
      periodOfDay: _selectedPeriodOfDay!,
      category: _selectedCategory!,
      transactionType: _getTransactionTypeId(_selectedTransactionType!),
      invoiceUuid: "",
    );

    context.read<AddExpenseBloc>().add(
          AddExpenseSubmitted(request: request),
        );
  }

  int _getTransactionTypeId(String transactionType) {
    switch (transactionType) {
      case "Income":
        return 1;
      case "Expense":
        return 2;
      default:
        return 2;
    }
  }

  void _showError(String message) {
    CustomSnackbar.error(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: BlocListener<AddExpenseBloc, AddExpenseState>(
        listener: (context, state) {
          if (state is AddExpenseSuccess) {
            _clearForm();
            CustomSnackbar.success(context, "Expense added Successfully!!");
            widget.onSubmitSuccess();
          }

          if (state is AddExpenseFailure) {
            CustomSnackbar.error(context, state.message);
          }
        },
        child: Stack(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: SizedBox(
                height: HomeHeader.height,
                width: double.infinity,
                child: AppBackground(
                  child: CommonHeader(headingName: "Add Expense"),
                ),
              ),
            ),
            Positioned(
              top: HomeHeader.height - _cardOverlap,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FieldLabel("TITLE"),
                              const SizedBox(height: 8),
                              CustomTextField(
                                controller: _titleController,
                                hintText: "Add your title here.....",
                                borderColor: const Color(0xFF1F6E68),
                                textColor: Colors.black,
                              ),
                              const SizedBox(height: 20),
                              FieldLabel("CATEGORY"),
                              const SizedBox(height: 8),
                              BuildNameField(
                                selectedCategory: _selectedCategory,
                                onChanged: (value) =>
                                    setState(() => _selectedCategory = value),
                                hintText: "Select Category",
                                dropdownItems: const [
                                  DropdownMenuItem(
                                      value: "Food", child: Text("Food")),
                                  DropdownMenuItem(
                                      value: "Travel", child: Text("Travel")),
                                  DropdownMenuItem(
                                      value: "Shopping",
                                      child: Text("Shopping")),
                                  DropdownMenuItem(
                                      value: "Bills", child: Text("Bills")),
                                  DropdownMenuItem(
                                      value: "Entertainment",
                                      child: Text("Entertainment")),
                                  DropdownMenuItem(
                                      value: "Local", child: Text("Local")),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FieldLabel("PAYMENT MODE"),
                                        const SizedBox(height: 8),
                                        BuildNameField(
                                          selectedCategory:
                                              _selectedPaymentMode,
                                          onChanged: (value) => setState(() =>
                                              _selectedPaymentMode = value),
                                          hintText: "Select Payment Mode",
                                          dropdownItems: const [
                                            DropdownMenuItem(
                                                value: "Cash",
                                                child: Text("Cash")),
                                            DropdownMenuItem(
                                                value: "UPI",
                                                child: Text("UPI")),
                                            DropdownMenuItem(
                                                value: "Card",
                                                child: Text("Card")),
                                            DropdownMenuItem(
                                                value: "Net Banking",
                                                child: Text("Net Banking")),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FieldLabel("TRANSACTION TYPE"),
                                        const SizedBox(height: 8),
                                        BuildNameField(
                                          selectedCategory:
                                              _selectedTransactionType,
                                          onChanged: (value) => setState(() =>
                                              _selectedTransactionType = value),
                                          hintText: "Transaction Type",
                                          dropdownItems: const [
                                            DropdownMenuItem(
                                                value: "Income",
                                                child: Text("Income")),
                                            DropdownMenuItem(
                                                value: "Expense",
                                                child: Text("Expense")),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              FieldLabel("AMOUNT"),
                              const SizedBox(height: 8),
                              BuildAmountField(
                                  amountController: _amountController),
                              const SizedBox(height: 20),
                              FieldLabel("DATE"),
                              const SizedBox(height: 8),
                              BuildDateField(
                                selectedDate: _selectedDate,
                                onDateChanged: (picked) =>
                                    setState(() => _selectedDate = picked),
                              ),
                              const SizedBox(height: 20),
                              FieldLabel("PERIOD OF DAY"),
                              const SizedBox(height: 8),
                              BuildNameField(
                                selectedCategory: _selectedPeriodOfDay,
                                onChanged: (value) => setState(
                                    () => _selectedPeriodOfDay = value),
                                hintText: "Select Period of the Day",
                                dropdownItems: const [
                                  DropdownMenuItem(
                                      value: "Morning", child: Text("Morning")),
                                  DropdownMenuItem(
                                      value: "Afternoon",
                                      child: Text("Afternoon")),
                                  DropdownMenuItem(
                                      value: "Evening", child: Text("Evening")),
                                  DropdownMenuItem(
                                      value: "Night", child: Text("Night")),
                                ],
                              ),
                              const SizedBox(height: 20),
                              FieldLabel("INVOICE"),
                              const SizedBox(height: 8),
                              BuildAttachmentButton(title: "Add Expense"),
                              const SizedBox(height: 20),
                              FieldLabel("DESCRIPTION"),
                              const SizedBox(height: 8),
                              CustomTextField(
                                controller: _descriptionController,
                                hintText: "Add your description here.....",
                                borderColor: const Color(0xFF1F6E68),
                                textColor: Colors.black,
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      BlocBuilder<AddExpenseBloc, AddExpenseState>(
                        builder: (context, state) {
                          if (state is AddExpenseLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return BuildSubmitButton(
                            selectedCategory: _selectedCategory,
                            amountController: _amountController,
                            selectedDate: _selectedDate,
                            onPressed: _submitExpense,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
