// ignore_for_file: use_build_context_synchronously

import 'package:bun_app/model/product_model.dart';
import 'package:bun_app/providers/admin_provider.dart';
import 'package:bun_app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// Controller for managing product-related operations in the Firestore database.
class ProductController {
  CollectionReference products = FirebaseFirestore.instance.collection(
      "Products"); // Reference to the 'Products' collection in Firestore.

  // Adds a new product to the Firestore database.
  Future<void> addProduct(ProductModel model, CollectionReference products,
      String docId, BuildContext context) async {
    products.doc(docId).set(model.toJson()).then((value) {
      Logger().e("Product added with ID: $docId");
      Provider.of<AdminProvider>(context, listen: false).clearForm();
    });
  }

  // Fetches all products from Firestore.

  /// Returns a list of `ProductModel` instances representing all products.
  /// Updates [AuthProvider] to filter favorite items and [AdminProvider] to set all products.
  Future<List<ProductModel>> fetchProducts(context) async {
    QuerySnapshot snapshot = await products.get();
    if (snapshot.docs.isEmpty) {
      Logger().e("Cant fetch data");
      return [];
    } else {
      List<ProductModel> products = [];
      for (var element in snapshot.docs) {
        ProductModel product =
            ProductModel.fromJson(element.data() as Map<String, dynamic>);
        products.add(product);
      }
      Provider.of<AuthProvider>(context, listen: false)
          .filterFavoriteItems(products);
      Provider.of<AdminProvider>(context, listen: false)
          .setAllProducts(products);
      return products;
    }
  }

  // Fetches products by category from Firestore.
  /// Retrieves all products that match the specified [category] and returns them as a list of `ProductModel`.
  Future<List<ProductModel>> fetchProductsByCategory(
      String category, BuildContext context) async {
    QuerySnapshot snapshot =
        await products.where('category', isEqualTo: category).get();

    if (snapshot.docs.isEmpty) {
      Logger().e("No products found in the selected category");
      return [];
    } else {
      List<ProductModel> categoryProducts = [];
      for (var element in snapshot.docs) {
        ProductModel product =
            ProductModel.fromJson(element.data() as Map<String, dynamic>);
        categoryProducts.add(product);
      }

      // Optionally, update providers with the fetched data if necessary
      Provider.of<AuthProvider>(context, listen: false)
          .filterFavoriteItems(categoryProducts);
      Provider.of<AdminProvider>(context, listen: false)
          .setAllProducts(categoryProducts);

      return categoryProducts;
    }
  }
}
