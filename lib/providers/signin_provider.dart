import 'package:bun_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SigninProvider extends ChangeNotifier {
  AuthController authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetEmail = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get resetEmail => _resetEmail;

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

  void clearTextField() {
    _emailController.clear();
    _passwordController.clear();
    notifyListeners();
  }
}
