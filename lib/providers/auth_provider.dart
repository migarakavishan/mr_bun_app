import 'package:bun_app/controllers/auth_controller.dart';

import 'package:bun_app/model/user_model.dart';
import 'package:bun_app/providers/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  List<String> _favID = [];
  List<String> get favID => _favID;
  AuthController authController = AuthController();
  

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setUserModel(UserModel model, BuildContext context, String name) {
    _userModel = model;
    _favID = model.favorite;
    Provider.of<ProfileProvider>(context, listen: false).setUserName(name);
    notifyListeners();
  }

  void updateImage(String url) {
    _userModel!.image = url;
    notifyListeners();
  }
}
