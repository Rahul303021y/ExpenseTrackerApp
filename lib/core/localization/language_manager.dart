/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026 - 19:58
 * Product Name: Expenzo
 * ________________________________
 */
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class LanguageManager extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Map<String, dynamic>? _resources;
  Locale get locale => _locale;
  Map<String, dynamic>? get resources => _resources;
  Future<void> initialize() async {
    await _loadLanguage(_locale.languageCode);
  }

  Future<void> changeLanguage(String languageCode) async {
    if (_locale.languageCode == languageCode) {
      return;
    }

    try {
      await _loadLanguage(languageCode);

      _locale = Locale(languageCode);

      notifyListeners();
    } catch (e) {
      debugPrint(
        'Failed to change language to $languageCode: $e',
      );
    }
  }

  Future<void> _loadLanguage(String languageCode) async {
    try {
      final String jsonString = await rootBundle.loadString(
        'lib/core/localization/$languageCode.json',
      );

      final decodedData = jsonDecode(jsonString);

      if (decodedData is! Map<String, dynamic>) {
        throw const FormatException(
          'Localization JSON must contain an object.',
        );
      }

      _resources = decodedData;

      debugPrint(
        'Language loaded successfully: $languageCode',
      );
    } catch (e) {
      debugPrint(
        'Failed to load language: $languageCode',
      );

      debugPrint(
        'Localization error: $e',
      );
      if (languageCode != 'en') {
        try {
          final String jsonString = await rootBundle.loadString(
            'lib/core/localization/en.json',
          );

          final decodedData = jsonDecode(jsonString);

          if (decodedData is Map<String, dynamic>) {
            _resources = decodedData;
          }
        } catch (e) {
          debugPrint(
            'Failed to load English localization: $e',
          );
        }
      }
    }
  }
  String translate(String key) {
    return _resources?[key]?.toString() ?? key;
  }
}