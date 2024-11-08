// ignore_for_file: use_build_context_synchronously

import 'package:bun_app/model/user_model.dart';
import 'package:bun_app/providers/auth_provider.dart' as auth_provider;
import 'package:bun_app/screens/auth_screen/login_screen.dart';
import 'package:bun_app/screens/main_screens/main_screen.dart';
import 'package:bun_app/utils/custom_navigators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class AuthController {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  Future<void> listenAuthState(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Logger().e('User is currently signed out!');
        CustomNavigators.goTo(context, const LoginScreen());
      } else {
        Provider.of<auth_provider.AuthProvider>(context, listen: false).setUser(
            user); // this prefix thing was add because that AuthProvider cannt access tha auth_provider class that i create
        Logger().i('User is Signed in!');
        fetchUserData(user.uid).then((value) {
          if (value != null) {
            Provider.of<auth_provider.AuthProvider>(context, listen: false)
                .setUserModel(value, context, value.name);
            CustomNavigators.goTo(context, const MainScreen());
          } else {
            Provider.of<auth_provider.AuthProvider>(context, listen: false)
                .setUserModel(
                    UserModel(
                        email: user.uid,
                        image:
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                        name: "",
                        uid: user.uid,
                        favorite: []),
                    context,
                    "");
            CustomNavigators.goTo(context, const MainScreen());
          }
        });
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

  Future<bool> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        UserModel model = UserModel(
            name: name,
            email: email,
            image:
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
            uid: credential.user!.uid,
            favorite: []);
        addUserData(model);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Logger().e('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<void> addUserData(UserModel user) async {
    try {
      users.doc(user.uid).set(user.toJson());
      Logger().f("User data Added");
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserModel?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await users.doc(uid).get();
      return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<void> updateUser(Map<String, dynamic> data, String uid) async {
    try {
      await users.doc(uid).update(data);
      Logger().f("User Updated");
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> updateFavorite(String uid, List<String> items) async {
    try {
      await users.doc(uid).update({"favorite": items});
    } catch (e) {
      Logger().e(e);
    }
  }
}
