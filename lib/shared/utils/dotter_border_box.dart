import 'package:expensetrackerapp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'dashed_border_painter.dart';

class DottedBorderBox extends StatelessWidget {
  final Widget child;
  final bool selected;
  final Color selectionColor;

  const DottedBorderBox({super.key, required this.child, required this.selected, required this.selectionColor});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: selected ? selectionColor : Theme.of(context).appColors.outline,
        strokeWidth: 1.5,
        radius: 12,
        dashWidth: 6,
        dashGap: 4,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: child,
      ),
    );
  }
}
