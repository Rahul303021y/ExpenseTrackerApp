import 'package:flutter/material.dart';

class BuildAmountField extends StatefulWidget {
  final TextEditingController amountController;

  const BuildAmountField({super.key, required this.amountController});

  @override
  State<BuildAmountField> createState() => _BuildAmountFieldState();
}

class _BuildAmountFieldState extends State<BuildAmountField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF1F6E68), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text("\$",
              style: TextStyle(
                  color: Color(0xFF1F6E68),
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: widget.amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Color(0xFF1F6E68),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  border: InputBorder.none, isDense: true),
            ),
          ),
          TextButton(
            onPressed: () => setState(() => widget.amountController.clear()),
            style: TextButton.styleFrom(foregroundColor: Color(0xFF1F6E68),),
            child: Text("Clear", style: TextStyle(color: Color(0xFF1F6E68))),
          ),
        ],
      ),
    );
  }
}
