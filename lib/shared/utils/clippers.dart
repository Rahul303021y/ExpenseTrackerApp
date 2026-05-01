import 'package:flutter/material.dart';

class DiagonalBorderPainter extends CustomPainter {
  final double offset;

  const DiagonalBorderPainter({this.offset = 80});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height - offset);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}