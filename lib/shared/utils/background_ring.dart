import 'package:flutter/material.dart';

class BackgroundRing extends StatelessWidget {
  final double size;

  const BackgroundRing({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.04),
          width: 20,
        ),
      ),
    );
  }
}