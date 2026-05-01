import 'package:expensetrackerapp/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginScreen Widget Tests', () {

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets('Login screen renders and button is tappable',
            (WidgetTester tester) async {

          // ✅ Set proper screen size (fix off-screen issues)
          tester.view.physicalSize = const Size(1080, 1920);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            const MaterialApp(
              home: LoginScreen(),
            ),
          );

          // ✅ Let animations complete
          await tester.pumpAndSettle();

          // ✅ Verify UI elements
          expect(find.text('Spend Smarter\nSave More'), findsOneWidget);
          expect(find.text('Log In'), findsOneWidget);
          expect(find.byType(ElevatedButton), findsOneWidget);

          // ✅ Ensure button is visible before tapping
          final buttonFinder = find.byType(ElevatedButton);
          await tester.ensureVisible(buttonFinder);

          // ✅ Tap safely
          await tester.tap(buttonFinder, warnIfMissed: false);
          await tester.pump();

          // ✅ Verify animation widgets exist
          expect(find.byType(FadeTransition), findsOneWidget);
          expect(find.byType(SlideTransition), findsOneWidget);
        });
  });
}