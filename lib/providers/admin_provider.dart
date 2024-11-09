// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bun_app/controllers/product_controller.dart';
import 'package:bun_app/controllers/stroage_controller.dart';
import 'package:bun_app/model/product_model.dart';
import 'package:bun_app/utils/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AdminProvider extends ChangeNotifier {
  ProductController productController = ProductController();
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  final TextEditingController _priceController = TextEditingController();
  TextEditingController get priceController => _priceController;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  File? _imageFile;
  File? get imageFile => _imageFile;

  CollectionReference products =
      FirebaseFirestore.instance.collection("Products");

  List<ProductModel> _allItems = [];
  List<ProductModel> get allItems => _allItems;

  Future<void> pickImage(BuildContext context) async {
    _imageFile = await FileImagePicker().pickImage();
    notifyListeners();
  }

  Future<void> addProduct(BuildContext context) async {
    if (_imageFile != null &&
        _nameController.text.trim().isNotEmpty &&
        _descriptionController.text.trim().isNotEmpty &&
        _priceController.text.isNotEmpty) {
      String docId = products.doc().id;
      await StroageController()
          .uploadImage("Product Images", "$docId.jpg", _imageFile!)
          .then((value) async {
        if (value == "") {
          Logger().e("Failed");
        } else {
          ProductModel model = ProductModel(
              id: docId,
              title: _nameController.text,
              description: _descriptionController.text,
              image: value,
              category: _selectedCategory!,
              price: double.parse(_priceController.text));
          await productController.addProduct(model, products, docId, context);
        }
      });
    } else {
      Logger().e("Please add product details");
    }
  }

  void setSelectCategory(String? category, BuildContext context) {
    _selectedCategory = category;
    fetchProductsByCategory(context);
  }

  void clearForm() {
    _descriptionController.clear();
    _nameController.clear();
    _priceController.clear();
    _imageFile = null;
    _selectedCategory = null;
    notifyListeners();
  }

  void setAllProducts(List<ProductModel> list) {
    _allItems = list;
    notifyListeners();
  }

  Future<void> fetchProductsByCategory(BuildContext context) async {
    List<ProductModel> products;
    if (_selectedCategory == null) {
      // Fetch all products if no category selected
      products = await ProductController().fetchProducts(context);
    } else {
      // Fetch products based on selected category
      products = await ProductController()
          .fetchProductsByCategory(_selectedCategory!, context);
    }
    _allItems = products;
    notifyListeners();
  }

  Future<void> fetchAllProducts(BuildContext context) async {
    List<ProductModel> allProducts =
        await productController.fetchProducts(context);
    setAllProducts(allProducts);
  }
}
