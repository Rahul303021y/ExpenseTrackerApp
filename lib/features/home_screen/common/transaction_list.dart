import 'package:expensetrackerapp/core/localization/locale_keys.dart';
import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_presentation/all_transaction_screen.dart';
import 'package:flutter/material.dart';
import '../home_screen_model/expense_model.dart';
import 'transaction_tile.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.topSpacing,
    required this.transactions,
    required this.onTransactionTap
  });

  final double topSpacing;
  final List<Expense> transactions;
  final Function(Expense expense) onTransactionTap;

  @override
  Widget build(BuildContext context) {
    final preview = transactions.take(4).toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: topSpacing, left: 24, right: 24, bottom: 24),
      decoration: BoxDecoration(color: Theme.of(context).appColors.background),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LocaleKeys.transactionHistory.tr(context),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).appColors.textPrimary),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllTransactionsScreen(transactions: transactions, onTransactionTap: onTransactionTap,),
                    ),
                  );
                },
                child: Text(LocaleKeys.seeAll.tr(context), style: TextStyle(color: Theme.of(context).appColors.textPrimary),),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < preview.length; i++) ...[
            TransactionTile(
              title: preview[i].title,
              subtitle: preview[i].expenseDate.toString().split(' ')[0],
              amount: preview[i].amount,
              isIncome: preview[i].transactionType == 1,
              icon: Icons.shopping_bag_outlined,
              onTap: () {
                onTransactionTap(preview[i]);
              },
            ),
            if (i != preview.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}