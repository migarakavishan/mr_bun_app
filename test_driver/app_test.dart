import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Auth Integration Tests', () {
    late FlutterDriver driver;

    // Connect to the Flutter driver before running tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await Future.delayed(const Duration(seconds: 2));
    });

    // Close the connection to the driver after tests are done
    tearDownAll(() async {
      await driver.close();
    });

    test('Sign in with valid credentials', () async {
      await driver.requestData(
          'initialize_firebase'); // Trigger Firebase init on the app side

      // Replace with actual test credentials
      const String email = 'migara@mail.com';
      const String password = '123456';

      // Enter the email and password, then trigger the sign-in
      await driver.tap(find.byValueKey('emailField'));
      await driver.enterText(email);
      await driver.tap(find.byValueKey('passwordField'));
      await driver.enterText(password);
      await driver.tap(find.byValueKey('signInButton'));
      await driver.tap(find.byValueKey('profile'));
      await driver.tap(find.byValueKey('logout'));

      // Check if the app navigated to the main screen (add your own success validation)
      expect(await driver.getText(find.byValueKey('welcomeMessage')),
          contains('Welcome'));
    });

    test('Sign in with invalid credentials', () async {
      await driver.requestData('initialize_firebase');

      const String email = 'invaliduser@example.com';
      const String password = 'wrongpassword';

      await driver.tap(find.byValueKey('emailField'));
      await driver.enterText(email);
      await driver.tap(find.byValueKey('passwordField'));
      await driver.enterText(password);
      await driver.tap(find.byValueKey('signInButton'));
      await driver.tap(find.byValueKey('okay'));

      // Check for error message after failed login
      expect(await driver.getText(find.byValueKey('errorMessage')),
          contains('No user found'));
    });

    // test('Create account with valid details', () async {
    //   await driver.requestData('initialize_firebase'); // Trigger Firebase init

    //   // Test account details
    //   const String email = 'newuser@example.com';
    //   const String password = '123456';
    //   const String name = 'Test User';

    //   // Navigate to the registration screen
    //   // await driver.tap(find.byValueKey('registerButton'));

    //   // Enter the registration details
    //   await driver.tap(find.byValueKey('registerNameField'));
    //   await driver.enterText(name);
    //   await driver.tap(find.byValueKey('registerEmailField'));
    //   await driver.enterText(email);
    //   await driver.tap(find.byValueKey('registerPasswordField'));
    //   await driver.enterText(password);
    //   await driver.tap(find.byValueKey('registerPasswordField2'));
    //   await driver.enterText(password);
      

    //   // Submit the registration form
    //   await driver.tap(find.byValueKey('registerSubmitButton'));

    //   // Validate success - check for welcome message or screen navigation
    //   expect(await driver.getText(find.byValueKey('welcomeMessage')),
    //       contains('Welcome, $name'));
    // });

    // test('Create account with existing email', () async {
    //   await driver.requestData('initialize_firebase');

    //   // Existing account details
    //   const String email = 'existinguser@example.com';
    //   const String password = 'securepassword';
    //   const String name = 'Existing User';

    //   // Navigate to the registration screen
    //   await driver.tap(find.byValueKey('registerButton'));

    //   // Enter the registration details
    //   await driver.tap(find.byValueKey('registerEmailField'));
    //   await driver.enterText(email);
    //   await driver.tap(find.byValueKey('registerPasswordField'));
    //   await driver.enterText(password);
    //   await driver.tap(find.byValueKey('registerNameField'));
    //   await driver.enterText(name);

    //   // Submit the registration form
    //   await driver.tap(find.byValueKey('registerSubmitButton'));

    //   // Check for error message
    //   expect(await driver.getText(find.byValueKey('errorMessage')),
    //       contains('The account already exists for that email.'));
    // });

    // test('Create account with weak password', () async {
    //   await driver.requestData('initialize_firebase');

    //   // Account details with weak password
    //   const String email = 'weakpassworduser@example.com';
    //   const String password = '123'; // Weak password
    //   const String name = 'Weak Password User';

    //   // Navigate to the registration screen
    //   await driver.tap(find.byValueKey('registerButton'));

    //   // Enter the registration details
    //   await driver.tap(find.byValueKey('registerEmailField'));
    //   await driver.enterText(email);
    //   await driver.tap(find.byValueKey('registerPasswordField'));
    //   await driver.enterText(password);
    //   await driver.tap(find.byValueKey('registerNameField'));
    //   await driver.enterText(name);

    //   // Submit the registration form
    //   await driver.tap(find.byValueKey('registerSubmitButton'));

    //   // Check for weak password error message
    //   expect(await driver.getText(find.byValueKey('errorMessage')),
    //       contains('The password provided is too weak.'));
    // });
  });
}
