import 'package:expensetrackerapp/features/home_screen/common/transaction_tile.dart';
import 'package:flutter/material.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key, required this.transactions});

  final List<TransactionTile> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Transactions")),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: transactions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) => transactions[index],
      ),
    );
  }
}