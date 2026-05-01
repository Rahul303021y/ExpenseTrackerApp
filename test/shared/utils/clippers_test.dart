import 'dart:ui';
import 'package:expensetrackerapp/shared/utils/clippers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiagonalBorderPainter Tests', () {

    test('should not repaint when old delegate is same type', () {
      const painter = DiagonalBorderPainter();

      expect(painter.shouldRepaint(const DiagonalBorderPainter()), false);
    });

    test('should use correct offset value', () {
      const painter = DiagonalBorderPainter(offset: 100);

      expect(painter.offset, 100);
    });

    test('paint method executes without crashing', () {
      const painter = DiagonalBorderPainter();

      final canvas = Canvas(PictureRecorder());
      const size = Size(300, 600);

      // Should not throw
      painter.paint(canvas, size);
    });

    test('paint works with custom offset', () {
      const painter = DiagonalBorderPainter(offset: 50);

      final canvas = Canvas(PictureRecorder());
      const size = Size(300, 600);

      painter.paint(canvas, size);
    });
  });
}