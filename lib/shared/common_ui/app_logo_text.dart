import 'package:flutter/material.dart';

class AppLogoText extends StatelessWidget{
  const AppLogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Expenzo",
        style: TextStyle(
          color: Colors.white.withOpacity(0.92),
          fontSize: 55,
          fontWeight: FontWeight.bold,
          letterSpacing: 10,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}