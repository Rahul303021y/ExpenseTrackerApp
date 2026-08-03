import 'package:expensetrackerapp/features/home_screen/common/balance_card.dart';
import 'package:expensetrackerapp/features/home_screen/common/header.dart';
import 'package:expensetrackerapp/features/home_screen/common/transaction_list.dart';
import 'package:expensetrackerapp/features/home_screen/common/transaction_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const double _cardOverlap = 35;

  @override
  Widget build(BuildContext context) {
    final transactions = [
      const TransactionTile(
          title: "Upwork",
          subtitle: "Today",
          amount: 850,
          isIncome: true,
          icon: Icons.work_outline),
      const TransactionTile(
          title: "Transfer",
          subtitle: "Yesterday",
          amount: 85,
          isIncome: false,
          icon: Icons.swap_horiz),
      const TransactionTile(
          title: "Paypal",
          subtitle: "12 Jun",
          amount: 1400,
          isIncome: true,
          icon: Icons.account_balance_wallet_outlined),
      const TransactionTile(
          title: "Netflix",
          subtitle: "11 Jun",
          amount: 19,
          isIncome: false,
          icon: Icons.movie_outlined),
      const TransactionTile(
          title: "Upwork",
          subtitle: "1 Jun",
          amount: 850,
          isIncome: true,
          icon: Icons.work_outline),
      const TransactionTile(
          title: "Netflix",
          subtitle: "28 May",
          amount: 19,
          isIncome: false,
          icon: Icons.movie_outlined),
    ];
    final double topSpacing =
        HomeHeader.height - _cardOverlap + BalanceCard.height;
    return SingleChildScrollView(
      child: Stack(
        children: [
          const HomeHeader(userName: "Rahul Kumar"),
          Positioned(
            top: HomeHeader.height - _cardOverlap - BalanceCard.height / 2,
            left: 24,
            right: 24,
            child: const BalanceCard(
              totalBalance: 2548,
              income: 1840,
              expenses: 284,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: topSpacing - BalanceCard.height / 2 + 20),
            child: TransactionList(
              topSpacing: 0,
              transactions: transactions,
            ),
          ),
        ],
      ),
    );
  }
}