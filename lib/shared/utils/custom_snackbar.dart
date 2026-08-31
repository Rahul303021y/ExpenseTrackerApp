import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static void success(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).appColors.incomeContainer,
        // dark green
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).appColors.income,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Theme.of(context).appColors.onPrimary,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Theme.of(context).appColors.onPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void error(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).appColors.expenseContainer,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).appColors.error,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_outlined,
                color: Theme.of(context).appColors.onPrimary,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "$message!!",
                style: TextStyle(
                    color: Theme.of(context).appColors.onPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void info(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).appColors.infoContainer,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).appColors.info,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.info_outline,
                color: Theme.of(context).appColors.onPrimary,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Theme.of(context).appColors.onPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
