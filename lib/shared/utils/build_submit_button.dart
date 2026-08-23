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
          backgroundColor: buttonColor ?? const Color(0xFF1F6E68),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor ?? Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}