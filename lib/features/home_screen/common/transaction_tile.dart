import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isIncome,
    required this.icon,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final double amount;
  final bool isIncome;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Theme.of(context).appColors.onSurfaceVariant.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Theme.of(context).appColors.onSurfaceVariant),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).appColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: Theme.of(context).appColors.textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            "${isIncome ? '+' : '-'} \$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: isIncome ? Theme.of(context).appColors.income : Theme.of(context).appColors.expense,
            ),
          ),
        ],
      ),
    );
  }
}