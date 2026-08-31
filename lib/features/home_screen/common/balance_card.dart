import 'package:expensetrackerapp/core/localization/locale_keys.dart';
import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.income,
    required this.expenses,
    required this.initialBalance,
  });

  final double totalBalance;
  final double income;
  final double expenses;
  final double initialBalance;

  static const double height = 200;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.primaryDark,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).appColors.shadow,
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
              Row(
                children: [
                  Text(LocaleKeys.availableBalance.tr(context),
                      style: TextStyle(
                          color: Theme.of(context).appColors.onPrimary.withOpacity(0.5),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Icon(Icons.keyboard_arrow_up,
                      color: Theme.of(context).appColors.onPrimary.withOpacity(0.5), size: 18),
                ],
              ),
              Icon(Icons.more_horiz, color: Theme.of(context).appColors.onPrimary.withOpacity(0.5)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "₹ ${totalBalance.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context).appColors.onPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("• ",
                          style: TextStyle(
                              color: Theme.of(context).appColors.onPrimary.withOpacity(0.5),
                              fontSize: 12)),
                      Text(
                        LocaleKeys.initial.tr(context),
                        style: TextStyle(
                            color: Theme.of(context).appColors.onPrimary.withOpacity(0.5), fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    "₹ ${initialBalance.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context).appColors.onPrimary.withOpacity(0.7), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatChip(
                  icon: Icons.arrow_downward, label: LocaleKeys.income.tr(context), amount: income),
              _StatChip(
                  icon: Icons.arrow_upward,
                  label: LocaleKeys.expense.tr(context),
                  amount: expenses),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip(
      {required this.icon, required this.label, required this.amount});

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
              radius: 15,
              backgroundColor: Theme.of(context).appColors.onPrimary.withOpacity(0.1),
              child: Icon(icon, size: 14, color: Theme.of(context).appColors.onPrimary.withOpacity(0.5)),
            ),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(color: Theme.of(context).appColors.onPrimary.withOpacity(0.5), fontSize: 14)),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 30),
            Text(
              "₹ ${amount.toStringAsFixed(2)}",
              style: TextStyle(
                  color: Theme.of(context).appColors.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}