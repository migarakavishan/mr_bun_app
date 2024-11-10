import 'package:bun_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// SigninProvider class for managing sign-in functionality
class SigninProvider extends ChangeNotifier {
  AuthController authController = AuthController();
  
   // Controllers for handling text input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetEmail = TextEditingController();

  // Getters for text controllers
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get resetEmail => _resetEmail;

  // Initiates the sign-in process
  Future<void> startSignIn(context) async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      Logger().e("Invalid data");
    } else {
      bool isSuccess = await authController.signInWithPassword(
          email: _emailController.text,
          password: _passwordController.text,
          context: context);
      if (isSuccess) {
        clearTextField();
      }
    }
  }

  // Clears the email and password text fields
  void clearTextField() {
    _emailController.clear();
    _passwordController.clear();
    notifyListeners();
  }
}
