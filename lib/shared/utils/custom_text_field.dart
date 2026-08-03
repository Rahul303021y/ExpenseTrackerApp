import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixIconPressed,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white54,
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
          vertical: 18,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.4),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}