import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isIncome,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final double amount;
  final bool isIncome;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.black87),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            ],
          ),
        ),
        Text(
          "${isIncome ? '+' : '-'} \$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: isIncome ? Colors.green : Colors.redAccent,
          ),
        ),
      ],
    );
  }
}