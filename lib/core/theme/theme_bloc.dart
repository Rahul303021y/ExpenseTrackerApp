/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 29-08-2026 - 17:45
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ThemeStarted>(_onStarted);
    on<ThemeModeChanged>(_onModeChanged);
    on<ThemeToggled>(_onToggled);
    on<ThemeVariantChanged>(_onVariantChanged);

    add(const ThemeStarted());
  }

  static const _modeKey = 'theme_mode';
  static const _variantKey = 'theme_variant';

  Future<void> _onStarted(
      ThemeStarted event,
      Emitter<ThemeState> emit,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    final savedMode = prefs.getString(_modeKey) ?? 'system';
    final mode = {
      'light': ThemeMode.light,
      'dark': ThemeMode.dark,
      'system': ThemeMode.system,
    }[savedMode] ??
        ThemeMode.system;

    // final savedVariant = prefs.getString(_variantKey) ?? 'blue';
    final savedVariant = prefs.getString(_variantKey) ?? 'teal';
    final variant = {
      'teal': AppColorVariant.teal,
      'blue': AppColorVariant.blue,
    }[savedVariant] ??
        AppColorVariant.teal;

    emit(state.copyWith(themeMode: mode, variant: variant));
  }

  Future<void> _onModeChanged(
      ThemeModeChanged event,
      Emitter<ThemeState> emit,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modeKey, event.mode.name);
    emit(state.copyWith(themeMode: event.mode));
  }

  Future<void> _onToggled(
      ThemeToggled event,
      Emitter<ThemeState> emit,
      ) async {
    final next =
    state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modeKey, next.name);
    emit(state.copyWith(themeMode: next));
  }

  Future<void> _onVariantChanged(
      ThemeVariantChanged event,
      Emitter<ThemeState> emit,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _variantKey,
      event.variant == AppColorVariant.blue ? 'blue' : 'teal',
    );
    emit(state.copyWith(variant: event.variant));
  }
}