import 'package:flutter/material.dart';
import 'dashed_border_painter.dart';

class DottedBorderBox extends StatelessWidget {
  final Widget child;

  const DottedBorderBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: Colors.grey.shade400,
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
