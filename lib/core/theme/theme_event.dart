/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 29-08-2026 - 17:46
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:flutter/material.dart';
import 'app_theme.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

// Fired once on app startup to restore the saved theme mode + variant.
class ThemeStarted extends ThemeEvent {
  const ThemeStarted();
}

// Fired when the user explicitly picks a mode (light / dark / system).
class ThemeModeChanged extends ThemeEvent {
  const ThemeModeChanged(this.mode);

  final ThemeMode mode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ThemeModeChanged && other.mode == mode);

  @override
  int get hashCode => mode.hashCode;
}

// Fired from a simple toggle switch (light <-> dark).
class ThemeToggled extends ThemeEvent {
  const ThemeToggled();
}

// Fired when the user picks a brand color scheme (teal / blue).
class ThemeVariantChanged extends ThemeEvent {
  const ThemeVariantChanged(this.variant);

  final AppColorVariant variant;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ThemeVariantChanged && other.variant == variant);

  @override
  int get hashCode => variant.hashCode;
}