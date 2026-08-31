import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BuildSubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;

  const BuildSubmitButton({
    super.key,
    this.text = "Add Expense",
    required this.onPressed,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Theme.of(context).appColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor ?? Theme.of(context).appColors.onPrimary, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}