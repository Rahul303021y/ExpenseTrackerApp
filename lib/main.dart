/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026
 * Product Name: Expenzo
 * ________________________________
 */
/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:expensetrackerapp/core/localization/language_manager.dart';
import 'package:expensetrackerapp/features/splash_screen/splash_screen_presentation/spalash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_bloc.dart';
import 'core/theme/theme_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LanguageManager languageManager = LanguageManager();
  await languageManager.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageManager>.value(value: languageManager),
      ],
      child: BlocProvider<ThemeBloc>(
        create: (_) => ThemeBloc(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageManager languageManager = context.watch<LanguageManager>();

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Expense Tracker',
          locale: languageManager.locale,
          themeMode: themeState.themeMode,
          theme: AppTheme.light(themeState.variant),
          darkTheme: AppTheme.dark(themeState.variant),
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
          home: const SplashScreen(),
        );
      },
    );
  }
}