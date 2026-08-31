import 'package:expensetrackerapp/core/localization/locale_keys.dart';
import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:expensetrackerapp/features/home_screen/common/transaction_tile.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_model/expense_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/common_ui/app_background.dart';
import '../../../shared/common_ui/common_header.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen(
      {super.key, required this.transactions, required this.onTransactionTap});

  final List<Expense> transactions;
  final Function(Expense expense) onTransactionTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).appColors.transparent,
      child: Stack(children: [
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
            decoration: BoxDecoration(
              color: Theme.of(context).appColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: transactions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final expense = transactions[index];

                return TransactionTile(
                  title: expense.title,
                  subtitle: expense.expenseDate.toString().split(' ')[0],
                  amount: expense.amount,
                  isIncome: expense.transactionType == 1,
                  icon: Icons.shopping_bag_outlined,
                  onTap: () {
                    onTransactionTap(expense);
                  },
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
