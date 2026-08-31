import 'package:expensetrackerapp/core/theme/app_theme.dart';
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).appColors.primary,
            Theme.of(context).appColors.primaryDark
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
            top: 10,
            left: 10,
            child: BackgroundRing(size: 220),
          ),
          Positioned(
            top: 120,
            left: 130,
            child: BackgroundRing(size: 130),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: child,
          ),
        ],
      ),
    );
  }
}