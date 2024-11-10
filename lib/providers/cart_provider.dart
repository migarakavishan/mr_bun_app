import 'package:bun_app/controllers/order_controller.dart';
import 'package:bun_app/model/cart_item_model.dart';
import 'package:bun_app/model/order_model.dart';
import 'package:bun_app/model/product_model.dart';
import 'package:bun_app/model/user_model.dart';
import 'package:bun_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// CartProvider class to manage cart operations
class CartProvider extends ChangeNotifier {
  int _quantity = 1; // Default quantity for cart items
  int get quantity => _quantity;

  // List to store cart items
  final List<CartItemModel> _cartItems = [];
  List<CartItemModel> get cartItems => _cartItems;

  OrderController orderController = OrderController(); // For order processing

  // Increases item quantity in the cart
  void increseQuantity() {
    _quantity++;
    notifyListeners();
  }

  // Decreases item quantity but ensures it doesn't go below 1
  void decrementQuantity() {
    if (_quantity != 1) {
      _quantity--;
      notifyListeners();
    }
  }

  // Adds a product to the cart if it’s not already there.
  // If it is, removes it from the cart.
  void addToCart(ProductModel model) {
    if (_cartItems.any((element) => element.model.id == model.id)) {
      _cartItems.removeWhere((element) => element.model.id == model.id);
      Logger().e(_cartItems.length);
      notifyListeners();
    } else {
      _cartItems.add(CartItemModel(model: model, quantity: _quantity));
      Logger().f(_cartItems.length);
      notifyListeners();
    }
  }

  // Increases the quantity of a cart item at a given index.
  void increaseCartItemQuantity(int index) {
    _cartItems[index].quantity++;
    notifyListeners();
  }

  // Decreases the quantity of a cart item at a given index but ensures it doesn't go below 1.
  void decrementCartItemQuantity(int index) {
    if (_cartItems[index].quantity != 1) {
      _cartItems[index].quantity--;
      notifyListeners();
    }
  }

  
  String getQuantity(ProductModel model) {
    int q = 1;
    if (_cartItems.any((element) => element.model.id == model.id)) {
      q = _cartItems[
              _cartItems.indexWhere((element) => element.model.id == model.id)]
          .quantity;
    } else {
      q = _quantity;
    }

    return "$q";
  }

  // Calculates the total cost of all items in the cart.
  String calculateTotal() {
    double total = 0;
    for (var element in _cartItems) {
      total += element.model.price * element.quantity;
    }
    return "$total";
  }


  // Saves the current cart as an order and clears the cart
  Future<void> saveOrders(BuildContext context) async {
    UserModel user =
        Provider.of<AuthProvider>(context, listen: false).userModel!;
    OrderModel model = OrderModel(
        items: _cartItems,
        orderID: "",
        totalAmount: double.parse(calculateTotal()),
        user: user);
    orderController.saveOrderDetails(model);

    clearCart();
  }

  // Clears all items from the cart.
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
