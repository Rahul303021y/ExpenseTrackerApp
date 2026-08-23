import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final TextEditingController controller;
  final Color borderColor;
  final int? maxLines;
  final Color textColor;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixIconPressed,
    required this.controller,
    required this.borderColor,
    this.maxLines = 1,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: textColor,
        ),

        suffixIcon: suffixIcon != null
            ? IconButton(
          onPressed: onSuffixIconPressed,
          icon: Icon(
            suffixIcon,
            color: Colors.white70,
          ),
        )
            : null,

        filled: true,
        fillColor: Colors.transparent,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: borderColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}