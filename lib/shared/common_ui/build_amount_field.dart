import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BuildAmountField extends StatefulWidget {
  final TextEditingController amountController;

  const BuildAmountField({
    super.key,
    required this.amountController,
  });

  @override
  State<BuildAmountField> createState() => _BuildAmountFieldState();
}

class _BuildAmountFieldState extends State<BuildAmountField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).appColors.primary.withOpacity(
              _isFocused ? 1.0 : 0.7,
            ),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              "₹",
              style: TextStyle(
                color: Theme.of(context).appColors.primary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: TextField(
                controller: widget.amountController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Theme.of(context).appColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "0.00",
                  hintStyle: TextStyle(
                    color: Theme.of(context).appColors.textSecondary.withOpacity(0.3),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.amountController.clear();
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).appColors.primary.withOpacity(
                  _isFocused ? 1.0 : 0.7,
                ),
              ),
              child: Text(
                "Clear",
                style: TextStyle(
                  color:Theme.of(context).appColors.primary.withOpacity(
                    _isFocused ? 1.0 : 0.7,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}