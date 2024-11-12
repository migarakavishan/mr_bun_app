import 'package:bun_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';

// SignupProvider class for managing sign-up functionality
class SignupProvider extends ChangeNotifier {
  AuthController authController = AuthController();

  // Controllers for handling text input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // Getters for text controllers
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get nameController => _nameController;

  // Initiates the sign-up process
  Future<void> startSignUp(context) async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _passwordController.text != confirmPasswordController.text ||
        _nameController.text.trim().isEmpty) {
      Logger().e("Invalid Data");
    } else {
      //create an account with the provided credentials
      authController
          .createAccount(
              email: emailController.text,
              password: passwordController.text,
              name: _nameController.text,
              context: context)
          .then(
        (value) {
          if (value) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(
                  child: SpinKitThreeBounce(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                );
              },
            );
            clearTextField();
          }
        },
      );
    }
  }

  // Clears the text fields after successful sign-up
  void clearTextField() {
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _nameController.clear();
    notifyListeners();
  }
}
