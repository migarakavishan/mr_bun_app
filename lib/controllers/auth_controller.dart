// ignore_for_file: use_build_context_synchronously

import 'package:bun_app/screens/auth_screen/login_screen.dart';
import 'package:bun_app/screens/main_screens/main_screen.dart';
import 'package:bun_app/utils/custom_navigators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthController {
  Future<void> listenAuthState(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Logger().e('User is currently signed out!');
        CustomNavigators.goTo(context, const LoginScreen());
      } else {
        Logger().e('User is signed in!');
        CustomNavigators.goTo(context, const MainScreen());
      }
    });
  }

  Future<bool> signInWithPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Logger().e('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Logger().e('Wrong password provided for that user.');
      }
      return false;
    }
  }


  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
