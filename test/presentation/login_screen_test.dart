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

          tester.view.physicalSize = const Size(1080, 1920);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            const MaterialApp(
              home: LoginScreen(),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.text('Spend Smarter\nSave More'), findsOneWidget);
          expect(find.text('Log In'), findsOneWidget);
          expect(find.byType(ElevatedButton), findsOneWidget);

          final buttonFinder = find.byType(ElevatedButton);
          await tester.ensureVisible(buttonFinder);

          await tester.tap(buttonFinder, warnIfMissed: false);
          await tester.pump();

          expect(find.byType(FadeTransition), findsOneWidget);
          expect(find.byType(SlideTransition), findsOneWidget);
        });
  });
}