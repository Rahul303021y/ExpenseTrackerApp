import 'package:expensetrackerapp/presentation/login_screen.dart';
import 'package:expensetrackerapp/presentation/spalash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashScreen Tests', () {

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets('renders splash screen and navigates to LoginScreen',
            (WidgetTester tester) async {

          // ✅ Fix screen size (prevents overflow issues)
          tester.view.physicalSize = const Size(1080, 1920);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            const MaterialApp(
              home: SplashScreen(),
            ),
          );

          // ✅ Verify splash is shown initially
          expect(find.byType(SplashScreen), findsOneWidget);

          // ✅ Let animation run (1500ms)
          await tester.pump(const Duration(milliseconds: 1600));

          // ✅ Allow navigation to complete
          await tester.pumpAndSettle();

          // ✅ Verify navigation happened
          expect(find.byType(LoginScreen), findsOneWidget);
        });
  });
}