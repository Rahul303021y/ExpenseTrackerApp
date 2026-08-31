/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 29-08-2026 - 17:46
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:flutter/material.dart';
import 'app_theme.dart';

class ThemeState {
  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.variant = AppColorVariant.teal,
  });

  final ThemeMode themeMode;
  final AppColorVariant variant;

  ThemeState copyWith({ThemeMode? themeMode, AppColorVariant? variant}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      variant: variant ?? this.variant,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ThemeState &&
              other.themeMode == themeMode &&
              other.variant == variant);

  @override
  int get hashCode => Object.hash(themeMode, variant);
}