import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  final String text;

  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).appColors.textPrimary,
        letterSpacing: 0.5,
      ),
    );
  }
}