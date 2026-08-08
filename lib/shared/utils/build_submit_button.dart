import 'package:flutter/material.dart';

class BuildSubmitButton extends StatelessWidget {
  final String? selectedCategory;
  final TextEditingController amountController;
  final DateTime selectedDate;
  final VoidCallback onPressed;

  const BuildSubmitButton({
    super.key,
    required this.selectedCategory,
    required this.amountController,
    required this.selectedDate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1F6E68),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: const Text(
          "Add Expense",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}