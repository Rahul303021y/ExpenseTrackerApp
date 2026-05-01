import 'package:flutter/material.dart';

class DiagonalClipper extends CustomClipper<Path> {
  final double offset;

  const DiagonalClipper({this.offset = 80});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - offset);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}