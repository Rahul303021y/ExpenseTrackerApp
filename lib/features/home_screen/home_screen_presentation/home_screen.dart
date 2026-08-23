import 'package:expensetrackerapp/features/home_screen/common/balance_card.dart';
import 'package:expensetrackerapp/features/home_screen/common/home_screen_header.dart';
import 'package:expensetrackerapp/features/home_screen/common/transaction_list.dart';
import 'package:expensetrackerapp/features/home_screen/common/transaction_tile.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_screen_bloc/home_screen_bloc.dart';
import '../home_screen_bloc/home_screen_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onTransactionTap,
  });

  final Function(Expense expense) onTransactionTap;

  static const double _cardOverlap = 35;

  @override
  Widget build(BuildContext context) {
    final double topSpacing =
        HomeHeader.height -
            _cardOverlap +
            BalanceCard.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<HomeBloc, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomeScreenError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is HomeScreenLoaded) {
            final summary = state.accountSummary;

            final transactions = state.expenses
                .map(
                  (expense) => TransactionTile(
                title: expense.title,
                subtitle:
                expense.expenseDate.toString().split(' ')[0],
                amount: expense.amount,
                isIncome: expense.transactionType == 1,
                icon: Icons.shopping_bag_outlined,
                onTap: () {
                  onTransactionTap(expense);
                },
              ),
            )
                .toList();

            return SingleChildScrollView(
              child: Stack(
                children: [
                  const HomeHeader(
                    greeting: "Good Afternoon,",
                    userName: "Rahul Kumar",
                  ),
                  Positioned(
                    top: HomeHeader.height -
                        _cardOverlap -
                        BalanceCard.height / 2,
                    left: 24,
                    right: 24,
                    child: BalanceCard(
                      totalBalance:
                      summary.availableBalance.toDouble(),
                      income:
                      summary.totalIncome.toDouble(),
                      expenses:
                      summary.totalExpense.toDouble(),
                      initialBalance:
                      summary.initialBalance.toDouble(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: topSpacing -
                          BalanceCard.height / 2 +
                          20,
                    ),
                    child: TransactionList(
                      topSpacing: 0,
                      transactions: transactions,
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}