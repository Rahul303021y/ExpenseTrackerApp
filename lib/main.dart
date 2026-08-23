import 'package:expensetrackerapp/features/splash_screen/splash_screen_presentation/spalash_screen.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(
              highContrast: false,
              boldText: false,
              textScaler: TextScaler.noScaling,
            ),
            child: child!,
          );
        },
      home: SplashScreen(),
    );
  }
}