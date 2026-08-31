import 'package:expensetrackerapp/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColors', () {
    test('tealBackground should be Color(0xFFEFF6F6)', () {
      expect(AppColors.tealBackground, const Color(0xFFEFF6F6));
    });

    test('tealPrimary should be Color(0xFF4AAFA8)', () {
      expect(AppColors.tealPrimary, const Color(0xFF4AAFA8));
    });

    test('tealDark should be Color(0xFF438883)', () {
      expect(AppColors.tealDark, const Color(0xFF438883));
    });

    test('white should be Colors.white', () {
      expect(AppColors.white, Colors.white);
    });

    test('textGrey should be Color(0xFF888888)', () {
      expect(AppColors.textGrey, const Color(0xFF888888));
    });
  });
}
