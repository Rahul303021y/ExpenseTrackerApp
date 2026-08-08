import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.income,
    required this.expenses,
  });

  final double totalBalance;
  final double income;
  final double expenses;

  static const double height = 200;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF2F6E5E),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text("Total Balance", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold)),
                  Icon(Icons.keyboard_arrow_up, color: Colors.white70, size: 18),
                ],
              ),
              const Icon(Icons.more_horiz, color: Colors.white70),
            ],
          ),
          Text(
            "\$ ${totalBalance.toStringAsFixed(2)}",
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatChip(icon: Icons.arrow_downward, label: "Income", amount: income,),
              _StatChip(icon: Icons.arrow_upward, label: "Expenses", amount: expenses),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label, required this.amount});

  final IconData icon;
  final String label;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white.withOpacity(.15),
                  child: Icon(icon, size: 14, color: Colors.white,),
                ),
                SizedBox(width: 8,),
                Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
           Row(
             children: [
               SizedBox(width: 30,),
               Text(
                 "\$ ${amount.toStringAsFixed(2)}",
                 style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
               ),
             ],
           )
      ],
    );
  }
}