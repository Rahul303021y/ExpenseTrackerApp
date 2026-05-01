import 'package:expensetrackerapp/shared/utils/diagonal_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiagonalClipper Tests', () {

    test('should return false for shouldReclip', () {
      const clipper = DiagonalClipper();

      expect(
        clipper.shouldReclip(const DiagonalClipper()),
        false,
      );
    });

    test('should use default offset correctly', () {
      const clipper = DiagonalClipper();

      expect(clipper.offset, 80);
    });

    test('should use custom offset correctly', () {
      const clipper = DiagonalClipper(offset: 120);

      expect(clipper.offset, 120);
    });

    test('getClip should return valid Path without crashing', () {
      const clipper = DiagonalClipper();

      final path = clipper.getClip(const Size(300, 600));

      expect(path, isA<Path>());
      expect(path.getBounds().isFinite, true);
    });

    test('getClip should produce non-empty path', () {
      const clipper = DiagonalClipper();

      final path = clipper.getClip(const Size(300, 600));

      expect(path.computeMetrics().isNotEmpty, true);
    });

    test('getClip works with custom offset', () {
      const clipper = DiagonalClipper(offset: 50);

      final path = clipper.getClip(const Size(300, 600));

      expect(path, isA<Path>());
    });

  });
}