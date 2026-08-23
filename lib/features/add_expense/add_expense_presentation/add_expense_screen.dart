import 'package:expensetrackerapp/features/add_expense/add_expense_bloc/add_expense_bloc.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_bloc/add_expense_event.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_bloc/add_expense_state.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_data/expense_category_api_provider.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_data/expense_category_repo.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_data/expense_payment_type_api_provider.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_data/expense_time_of_day_repo.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_model/expense_payment_type_model.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_data/expense_payment_type_repo.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_model/add_expense_request_model.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_model/expense_category_model.dart';
import 'package:expensetrackerapp/features/add_expense/add_expense_model/expense_time_of_day_model.dart';
import 'package:expensetrackerapp/shared/common_bloc/api_status.dart';
import 'package:expensetrackerapp/shared/common_bloc/common_bloc.dart';
import 'package:expensetrackerapp/shared/common_bloc/common_event.dart';
import 'package:expensetrackerapp/shared/common_bloc/common_state.dart';
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
import 'package:expensetrackerapp/core/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/dio_client.dart';
import '../../home_screen/common/home_screen_header.dart';
import '../add_expense_data/expense_time_of_day_api_provider.dart';

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

  final CommonBloc _categoryBloc = CommonBloc();
  final CommonBloc _paymentTypeBloc = CommonBloc();
  final CommonBloc _timeOfDayBloc = CommonBloc();
  late final ExpenseCategoryRepo _categoryRepo;
  late final ExpensePaymentTypeRepo _expensePaymentTypeRepo;
  late final ExpenseTimeOfDayRepo _timeOfDayRepo;

  DateTime _selectedDate = DateTime.now();

  String? _selectedCategory;
  String? _selectedPaymentMode;
  String? _selectedTimeOfDay;
  String? _selectedTransactionType;

  @override
  void initState() {
    super.initState();
    _categoryRepo = ExpenseCategoryRepo(
      ExpenseCategoryApiProvider(DioClient(SecureStorageService()).dio),
    );
    _expensePaymentTypeRepo = ExpensePaymentTypeRepo(
      ExpensePaymentTypeApiProvider(DioClient(SecureStorageService()).dio),
    );
    _timeOfDayRepo = ExpenseTimeOfDayRepo(
      ExpenseTimeOfDayApiProvider(
        DioClient(SecureStorageService()).dio,
      ),
    );
    _fetchCategories();
    _fetchPaymentType();
    _fetchTimeOfDay();
  }

  void _fetchCategories() {
    _categoryBloc.add(
      CallApiEvent(
        apiCall: () => _categoryRepo.fetchCategories(),
        isList: true,
      ),
    );
  }

  void _fetchPaymentType() {
    _paymentTypeBloc.add(
      CallApiEvent(
        apiCall: () => _expensePaymentTypeRepo.fetchPaymentType(),
        isList: true,
      ),
    );
  }

  void _fetchTimeOfDay() {
    _timeOfDayBloc.add(
      CallApiEvent(
        apiCall: () => _timeOfDayRepo.fetchTimeOfDay(),
        isList: true,
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    _categoryBloc.close();
    _paymentTypeBloc.close();
    _timeOfDayBloc.close();
    super.dispose();
  }

  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _amountController.clear();

    setState(() {
      _selectedCategory = null;
      _selectedPaymentMode = null;
      _selectedTimeOfDay = null;
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

    if (_selectedTimeOfDay == null) {
      _showError("Please select the period of day");
      return;
    }

    final request = AddExpenseRequest(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      amount: amount,
      expenseDate: _selectedDate,
      paymentMode: _selectedPaymentMode!,
      periodOfDay: _selectedTimeOfDay!,
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
                              BlocBuilder<CommonBloc, CommonState>(
                                bloc: _categoryBloc,
                                builder: (context, state) {
                                  final status = state.apiStatus;

                                  if (status is ApiLoadingState) {
                                    return const SizedBox(
                                      height: 48,
                                      child: Center(
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        ),
                                      ),
                                    );
                                  }

                                  if (status is ApiFailureState) {
                                    return BuildNameField(
                                      selectedCategory: _selectedCategory,
                                      onChanged: (value) => setState(
                                          () => _selectedCategory = value),
                                      hintText: "Failed to load categories",
                                      dropdownItems: const [],
                                    );
                                  }

                                  final categories = status is ApiSuccessState
                                      ? (status.responseList ?? [])
                                          .cast<ExpenseCategoryModel>()
                                      : <ExpenseCategoryModel>[];

                                  return BuildNameField(
                                    selectedCategory: _selectedCategory,
                                    onChanged: (value) => setState(
                                        () => _selectedCategory = value),
                                    hintText: "Select Category",
                                    dropdownItems: categories
                                        .map(
                                          (category) => DropdownMenuItem(
                                            value: category.categoryCode,
                                            child: Text(category.categoryName),
                                          ),
                                        )
                                        .toList(),
                                  );
                                },
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
                                        BlocBuilder<CommonBloc, CommonState>(
                                          bloc: _paymentTypeBloc,
                                          builder: (context, state) {
                                            final status = state.apiStatus;

                                            if (status is ApiLoadingState) {
                                              return const SizedBox(
                                                height: 48,
                                                child: Center(
                                                  child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                            strokeWidth: 2),
                                                  ),
                                                ),
                                              );
                                            }

                                            if (status is ApiFailureState) {
                                              return BuildNameField(
                                                selectedCategory:
                                                    _selectedPaymentMode,
                                                onChanged: (value) => setState(
                                                    () => _selectedPaymentMode =
                                                        value),
                                                hintText:
                                                    "Failed to load payment modes",
                                                dropdownItems: const [],
                                              );
                                            }

                                            final paymentTypes = status
                                                    is ApiSuccessState
                                                ? (status.responseList ?? [])
                                                    .cast<
                                                        ExpensePaymentTypeModel>()
                                                : <ExpensePaymentTypeModel>[];

                                            return BuildNameField(
                                              selectedCategory:
                                                  _selectedPaymentMode,
                                              onChanged: (value) => setState(
                                                  () => _selectedPaymentMode =
                                                      value),
                                              hintText: "Select Payment Mode",
                                              dropdownItems: paymentTypes
                                                  .map(
                                                    (paymentType) =>
                                                        DropdownMenuItem(
                                                      value: paymentType
                                                          .paymentTypeCode,
                                                      child: Text(paymentType
                                                          .paymentTypeName),
                                                    ),
                                                  )
                                                  .toList(),
                                            );
                                          },
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
                              BlocBuilder<CommonBloc, CommonState>(
                                  bloc: _timeOfDayBloc,
                                  builder: (context, state) {
                                    final status = state.apiStatus;
                                    if (status is ApiLoadingState) {
                                      return const SizedBox(
                                        height: 48,
                                        child: Center(
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2),
                                          ),
                                        ),
                                      );
                                    }

                                    if (status is ApiFailureState) {
                                      return BuildNameField(
                                        selectedCategory: _selectedTimeOfDay,
                                        onChanged: (value) => setState(
                                            () => _selectedTimeOfDay = value),
                                        hintText:
                                            "Failed to load Time of the Day",
                                        dropdownItems: const [],
                                      );
                                    }

                                    final timeOfDay = status is ApiSuccessState
                                        ? (status.responseList ?? [])
                                            .cast<ExpenseTimeOfDayModel>()
                                        : <ExpenseTimeOfDayModel>[];

                                    return BuildNameField(
                                      selectedCategory: _selectedTimeOfDay,
                                      onChanged: (value) => setState(
                                        () => _selectedTimeOfDay = value,
                                      ),
                                      hintText: "Select Time of the Day",
                                      dropdownItems: timeOfDay
                                          .map(
                                            (dayTime) =>
                                                DropdownMenuItem<String>(
                                              value: dayTime.timeOfDayName,
                                              child:
                                                  Text(dayTime.timeOfDayName),
                                            ),
                                          )
                                          .toList(),
                                    );
                                  }),
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
