/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 29-08-2026 - 17:47
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:flutter/material.dart';
import 'app_colors_extension.dart';

/*
 * File: app_theme.dart
 * Description: Builds ThemeData for Expenzo across two independent axes:
 *              - brightness: light / dark
 *              - variant: teal / blue
 *              Mode + variant selection is owned by ThemeBloc.
 */

import 'package:flutter/material.dart';
import 'app_colors_extension.dart';
enum AppColorVariant { teal, blue }

abstract class AppTheme {
  static AppColorsExtension _colorsFor(
      AppColorVariant variant,
      Brightness brightness,
      ) {
    final isDark = brightness == Brightness.dark;
    switch (variant) {
      case AppColorVariant.teal:
        return isDark ? AppColorsExtension.dark : AppColorsExtension.light;
      case AppColorVariant.blue:
        return isDark
            ? AppColorsExtension.blueDark
            : AppColorsExtension.blueLight;
    }
  }

  static ThemeData light(AppColorVariant variant) =>
      _build(_colorsFor(variant, Brightness.light), Brightness.light);

  static ThemeData dark(AppColorVariant variant) =>
      _build(_colorsFor(variant, Brightness.dark), Brightness.dark);

  static ThemeData get lightTheme => light(AppColorVariant.teal);
  static ThemeData get darkTheme => dark(AppColorVariant.teal);

  static ThemeData _build(AppColorsExtension colors, Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      brightness: brightness,
      scaffoldBackgroundColor: colors.background,
      primaryColor: colors.primary,
      extensions: [colors],
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primary,
        brightness: brightness,
        primary: colors.primary,
        surface: colors.surface,
        error: colors.error,
        onError: colors.onError,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? colors.surface : colors.primary,
        foregroundColor: isDark ? colors.textPrimary : colors.onPrimary,
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: colors.textPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: colors.textSecondary, fontSize: 14),
        titleLarge: TextStyle(
            color: colors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700),
      ),
      dividerColor: colors.outline,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          disabledBackgroundColor: colors.disabled,
        ),
      ),
    );
  }
}

// ── Easy access from any widget ────────────────────────────────────────
// Usage: Theme.of(context).appColors.income
extension AppThemeExtension on ThemeData {
  AppColorsExtension get appColors =>
      extension<AppColorsExtension>() ?? AppColorsExtension.light;
}