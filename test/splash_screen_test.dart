// splash_screen_test.dart

import 'package:bun_app/providers/auth_provider.dart';
import 'package:bun_app/providers/profile_provider.dart';
import 'package:bun_app/providers/signin_provider.dart';
import 'package:bun_app/screens/splash%20_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'test_firebase_platform_file.dart';

void main() {
  setUpAll(() async {
    FirebasePlatform.instance = TestFirebasePlatform();
    await Firebase.initializeApp();
  });

  testWidgets('SplashScreen displays Mr.Bun text and circular container',
      (WidgetTester tester) async {
    // Build the widget with MultiProvider, including all necessary providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SigninProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          // Add other necessary providers here
        ],
        child: const MaterialApp(
          home: SplashScreen(),
        ),
      ),
    );

    // Check if "Mr.Bun" text is present.
    expect(find.text("Mr.Bun"), findsOneWidget);

    // Verify if the circular container is present.
    final containerFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).shape == BoxShape.circle,
    );
    expect(containerFinder, findsOneWidget);

    // Advance the timer to simulate the end of the splash screen delay.
    await tester.pump(const Duration(seconds: 3));
  });
}
