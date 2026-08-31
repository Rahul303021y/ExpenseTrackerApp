import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BuildNameField extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final List<DropdownMenuItem<String>> dropdownItems;

  const BuildNameField({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
    required this.hintText,
    required this.dropdownItems,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      isExpanded: true,
      items: dropdownItems,
      onChanged: onChanged,
      hint: Text(
        hintText,
        style: TextStyle(
          color: Theme.of(context).appColors.textSecondary.withOpacity(0.5),
        ),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).appColors.outline,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).appColors.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).appColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}