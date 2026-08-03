import 'package:flutter/material.dart';
import '../utils/background_ring.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1F6E68),
            Color(0xFF174944),
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -95,
            left: -95,
            child: BackgroundRing(size: 260),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: BackgroundRing(size: 220),
          ),
          Positioned(
            top: 120,
            left: 120,
            child: BackgroundRing(size: 130),
          ),
          child,
        ],
      ),
    );
  }
}