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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          isExpanded: true,
          hint: Text(hintText),
          items: dropdownItems,
          onChanged: onChanged,
        ),
      ),
    );
  }
}