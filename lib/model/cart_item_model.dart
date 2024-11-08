import 'package:bun_app/model/product_model.dart';

class CartItemModel {
  ProductModel model;
  int quantity;

  CartItemModel({required this.model, required this.quantity});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        model: ProductModel.fromJson(json['model'] as Map<String, dynamic>),
        quantity: (json["quantity"] as num).toInt());
  }

  Map<String, dynamic> toJson() {
    return {"quantity": quantity, "model": model.toJson()};
  }
}
