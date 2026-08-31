/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 29-08-2026 - 17:49
 * Product Name: Expenzo
 * ________________________________
 */
/*
 * File: app_colors_extension.dart
 * Description: Named color slots for Expenzo's light/dark themes.
 *              Access via: Theme.of(context).appColors.primary
 */

import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.primary,
    required this.primaryDark,
    required this.onPrimary,
    required this.background,
    required this.surface,
    required this.surfaceContainer,
    required this.textPrimary,
    required this.textSecondary,
    required this.outline,
    required this.outlineVariant,
    required this.onSurfaceVariant,
    required this.disabled,
    // required this.balanceCard,
    required this.income,
    required this.incomeContainer,
    required this.expense,
    required this.expenseContainer,
    required this.error,
    required this.onError,
    required this.info,
    required this.infoContainer,
    required this.shadow,
    required this.transparent
  });

  // Brand
  final Color primary;
  final Color primaryDark;
  final Color onPrimary;

  // Surfaces & text (mode-dependent)
  final Color background;
  final Color surface;
  final Color surfaceContainer; // slightly raised bg — cards, sheets, nav bar
  final Color textPrimary;
  final Color textSecondary;
  final Color outline; // input borders, prominent dividers
  final Color outlineVariant; // subtler dividers, e.g. row separators
  final Color onSurfaceVariant; // muted icons/secondary content on a surface
  final Color disabled;
  final Color shadow;
  final Color transparent;
  Color get onBackground => textPrimary;
  // Feature-specific brand accents
  // final Color balanceCard;

  // Semantic (income/expense/error/info) — same across light & dark
  final Color income;
  final Color incomeContainer;
  final Color expense;
  final Color expenseContainer;
  final Color error; // form validation errors (distinct from `expense`)
  final Color onError; // text/icons on top of an error-colored background
  final Color info;
  final Color infoContainer;

  @override
  AppColorsExtension copyWith({
    Color? primary,
    Color? primaryDark,
    Color? onPrimary,
    Color? background,
    Color? surface,
    Color? surfaceContainer,
    Color? shadow,
    Color? textPrimary,
    Color? textSecondary,
    Color? outline,
    Color? outlineVariant,
    Color? onSurfaceVariant,
    Color? disabled,
    // Color? balanceCard,
    Color? income,
    Color? incomeContainer,
    Color? expense,
    Color? expenseContainer,
    Color? error,
    Color? onError,
    Color? info,
    Color? infoContainer,
    Color? transparent
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      onPrimary: onPrimary ?? this.onPrimary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      shadow: shadow ?? this.shadow,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      disabled: disabled ?? this.disabled,
      // balanceCard: balanceCard ?? this.balanceCard,
      income: income ?? this.income,
      incomeContainer: incomeContainer ?? this.incomeContainer,
      expense: expense ?? this.expense,
      expenseContainer: expenseContainer ?? this.expenseContainer,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      info: info ?? this.info,
      infoContainer: infoContainer ?? this.infoContainer,
      transparent: transparent ?? this.transparent
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;

    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceContainer:
      Color.lerp(surfaceContainer, other.surfaceContainer, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      onSurfaceVariant:
      Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      // balanceCard: Color.lerp(balanceCard, other.balanceCard, t)!,
      income: Color.lerp(income, other.income, t)!,
      incomeContainer: Color.lerp(incomeContainer, other.incomeContainer, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      expenseContainer:
      Color.lerp(expenseContainer, other.expenseContainer, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      transparent: Color.lerp(transparent, other.transparent, t)!
    );
  }

  // ── Light mode instance ────────────────────────────────────────────
  static const light = AppColorsExtension(
    primary: Color(0xFF1F6E68),
    primaryDark: Color(0xFF174944),
    onPrimary: Color(0xFFFFFFFF),
    background: Color(0xFFF7F7F5),
    surface: Color(0xFFFFFFFF),
    surfaceContainer: Color(0xFFEFEFEC),
    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF6B6B6B),
    outline: Color(0xFFE0E0E0),
    outlineVariant: Color(0xFFEDEDED),
    onSurfaceVariant: Color(0xFF49454F),
    disabled: Color(0xFFBDBDBD),
    // balanceCard: Color(0xFF0F6E56),
    // fab: Color(0xFF0F6E56),
    shadow: Color(0x26000000),
    income: Color(0xFF4CAF50),
    incomeContainer: Color(0xFF1A4D1A),
    expense: Color(0xFFE24B4A),
    expenseContainer: Color(0xFF7A1F1F),
    error: Color(0xFFE24B4A),
    onError: Color(0xFFFFFFFF),
    info: Color(0xFF378ADD),
    infoContainer: Color(0xFF0C447C),
    transparent: Colors.transparent,
  );

  // ── Blue · Light mode instance ─────────────────────────────────────
  static const blueLight = AppColorsExtension(
    primary: Color(0xFF378ADD),
    primaryDark: Color(0xFF0C447C),
    onPrimary: Color(0xFFFFFFFF),
    background: Color(0xFFF5F8FB),
    surface: Color(0xFFFFFFFF),
    surfaceContainer: Color(0xFFEAF1F8),
    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF6B6B6B),
    outline: Color(0xFFE0E0E0),
    outlineVariant: Color(0xFFEDEDED),
    onSurfaceVariant: Color(0xFF49454F),
    disabled: Color(0xFFBDBDBD),
    // balanceCard: Color(0xFF0C447C),
    // fab: Color(0xFF378ADD),
    shadow: Color(0x26000000),
    income: Color(0xFF4CAF50),
    incomeContainer: Color(0xFF1A4D1A),
    expense: Color(0xFFE24B4A),
    expenseContainer: Color(0xFF7A1F1F),
    error: Color(0xFFE24B4A),
    onError: Color(0xFFFFFFFF),
    info: Color(0xFF378ADD),
    infoContainer: Color(0xFF0C447C),
    transparent: Colors.transparent,
  );

  // ── Blue · Dark mode instance ──────────────────────────────────────
  static const blueDark = AppColorsExtension(
    primary: Color(0xFF378ADD),
    primaryDark: Color(0xFF0C447C),
    onPrimary: Color(0xFFFFFFFF),
    // background: Color(0xFF121212),
    background: Color(0xFF1C1C1E),
    surface: Color(0xFF26262A),
    surfaceContainer: Color(0xFF303034),
    textPrimary: Color(0xFFF0F0F0),
    textSecondary: Color(0xFFAFAFB4),
    outline: Color(0xFF48484C),
    outlineVariant: Color(0xFF38383B),
    onSurfaceVariant: Color(0xFFCAC4D0),
    disabled: Color(0xFF6A6A6E),
    // balanceCard: Color(0xFF0C447C),
    // fab: Color(0xFF378ADD),
    shadow: Color(0x4D000000),
    income: Color(0xFF4CAF50),
    incomeContainer: Color(0xFF1A4D1A),
    expense: Color(0xFFE24B4A),
    expenseContainer: Color(0xFF7A1F1F),
    error: Color(0xFFE24B4A),
    onError: Color(0xFFFFFFFF),
    info: Color(0xFF378ADD),
    infoContainer: Color(0xFF0C447C),
    transparent: Colors.transparent,
  );

  // ── Dark mode instance ─────────────────────────────────────────────
  static const dark = AppColorsExtension(
    primary: Color(0xFF1F6E68),
    primaryDark: Color(0xFF174944),
    onPrimary: Color(0xFFFFFFFF),
    // background: Color(0xFF121212),
    background: Color(0xFF1C1C1E),
    surface: Color(0xFF26262A),
    surfaceContainer: Color(0xFF303034),
    textPrimary: Color(0xFFF0F0F0),
    textSecondary: Color(0xFFAFAFB4),
    outline: Color(0xFF48484C),
    outlineVariant: Color(0xFF38383B),
    onSurfaceVariant: Color(0xFFCAC4D0),
    disabled: Color(0xFF6A6A6E),
    shadow: Color(0x4D000000),
    // balanceCard: Color(0xFF0F6E56),
    // fab: Color(0xFF0F6E56),
    income: Color(0xFF4CAF50),
    incomeContainer: Color(0xFF1A4D1A),
    expense: Color(0xFFE24B4A),
    expenseContainer: Color(0xFF7A1F1F),
    error: Color(0xFFE24B4A),
    onError: Color(0xFFFFFFFF),
    info: Color(0xFF378ADD),
    infoContainer: Color(0xFF0C447C),
    transparent: Colors.transparent,
  );
}