import 'package:bun_app/controllers/auth_controller.dart';
import 'package:bun_app/model/product_model.dart';
import 'package:bun_app/model/user_model.dart';
import 'package:bun_app/providers/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  List<String> _favID = [];
  List<String> get favID => _favID;
  AuthController authController = AuthController();
  List<ProductModel> _favItems = [];
  List<ProductModel> get favItems => _favItems;

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

  Future<void> refreshUserData() async {
    if (_user == null) return; // No user is signed in
    try {
      UserModel? updatedUserModel =
          await authController.fetchUserData(_user!.uid);
      _userModel = updatedUserModel;
      // _favID = updatedUserModel.favorite;
      notifyListeners(); // Notify listeners to rebuild the UI with updated data
    } catch (e) {
      Logger().e("Error refreshing user data: $e");
    }
  }

  void addToFav(ProductModel model) {
    _favID.add(model.id);
    _favItems.add(model);
    authController.updateFavorite(user!.uid, _favID);
    notifyListeners();
  }

  void removeFromFav(ProductModel model) {
    _favID.remove(model.id);
    _favItems.remove(model);
    authController.updateFavorite(user!.uid, _favID);
    notifyListeners();
  }

  void filterFavoriteItems(List<ProductModel> sneakers) {
    List<ProductModel> favSneakers = [];
    for (var item in sneakers) {
      if (_favID.contains(item.id) && !_favItems.contains(item)) {
        favSneakers.add(item);
      }
    }
    _favItems = favSneakers;
    notifyListeners();
  }

  // void removeFromOrders(ProductModel model) {
  //   _myOrders.remove(model);
  //   notifyListeners();
  // }
}
