import 'package:expensetrackerapp/features/home_screen/home_screen_presentation/all_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'transaction_tile.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.topSpacing,
    required this.transactions,
  });

  final double topSpacing;
  final List<TransactionTile> transactions;

  @override
  Widget build(BuildContext context) {
    final preview = transactions.take(4).toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: topSpacing, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Transactions History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllTransactionsScreen(transactions: transactions),
                    ),
                  );
                },
                child: const Text("See all"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < preview.length; i++) ...[
            preview[i],
            if (i != preview.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}