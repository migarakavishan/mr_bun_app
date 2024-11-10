import 'package:bun_app/controllers/auth_controller.dart';
import 'package:bun_app/controllers/order_controller.dart';
import 'package:bun_app/model/order_model.dart';
import 'package:bun_app/model/product_model.dart';
import 'package:bun_app/model/user_model.dart';
import 'package:bun_app/providers/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// Provider for managing authentication, favorite products, and orders.
class AuthProvider extends ChangeNotifier {
  // Firebase user instance
  User? _user;
  User? get user => _user;

  // User data model
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  // Lists of favorite item IDs and favorite items
  List<String> _favID = [];
  List<String> get favID => _favID;

  List<ProductModel> _favItems = [];
  List<ProductModel> get favItems => _favItems;

  // Controller instances for managing authentication and orders
  AuthController authController = AuthController();

  // User's orders
  List<OrderModel> _myOrders = [];
  List<OrderModel> get myOrders => _myOrders;

  // Sets the user object and notifies listeners.
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  /// Sets user data from a [UserModel] and updates the user's name in `ProfileProvider`.
  void setUserModel(UserModel model, BuildContext context, String name) {
    _userModel = model;
    _favID = model.favorite;
    Provider.of<ProfileProvider>(context, listen: false).setUserName(name);
    notifyListeners();
  }

  // Updates the user's profile image.
  void updateImage(String url) {
    _userModel!.image = url;
    notifyListeners();
  }

  // Refreshes the user's data by fetching updated data from Firebase. This is for scroll down refresh in home page.
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

  // This method updates `_favID`, `_favItems`, and sends updated data to Firebase.
  void addToFav(ProductModel model) {
    _favID.add(model.id);
    _favItems.add(model);
    authController.updateFavorite(user!.uid, _favID);
    notifyListeners();
  }

  // Removes a product from the user's favorites.
  void removeFromFav(ProductModel model) {
    _favID.remove(model.id);
    _favItems.remove(model);
    authController.updateFavorite(user!.uid, _favID);
    notifyListeners();
  }

  // Filters favorite items based on a list of all products.
  void filterFavoriteItems(List<ProductModel> product) {
    List<ProductModel> favProduct = [];
    for (var item in product) {
      if (_favID.contains(item.id) && !_favItems.contains(item)) {
        favProduct.add(item);
      }
    }
    _favItems = favProduct;
    notifyListeners();
  }

  // Fetches the user's orders and stores them in `_myOrders`.
  Future<List<OrderModel>> fetchMyOrders(BuildContext context) async {
    _myOrders = await OrderController().fetchMyOrders(context);

    return _myOrders;
  }

  // Removes a specific order from the user's orders list.
  void removeFromOrders(OrderModel model) {
    _myOrders.remove(model);
    notifyListeners();
  }
}
