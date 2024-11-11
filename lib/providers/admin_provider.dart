// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bun_app/controllers/product_controller.dart';
import 'package:bun_app/controllers/stroage_controller.dart';
import 'package:bun_app/model/product_model.dart';
import 'package:bun_app/utils/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// Provider class for managing product-related operations by the admin.
class AdminProvider extends ChangeNotifier {
  ProductController productController = ProductController();

  // Text controllers for managing form inputs.
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  final TextEditingController _priceController = TextEditingController();
  TextEditingController get priceController => _priceController;

  // Stores the selected product category.
  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  // Holds the selected image file.
  File? _imageFile;
  File? get imageFile => _imageFile;

  // Loading state to show/hide loading indicator.
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CollectionReference products =
      FirebaseFirestore.instance.collection("Products");

  // List of all products fetched from Firebase.
  List<ProductModel> _allItems = [];
  List<ProductModel> get allItems => _allItems;

  // Allows the user to pick an image from their device and updates the image file.
  Future<void> pickImage(BuildContext context) async {
    _imageFile = await FileImagePicker().pickImage();
    notifyListeners();
  }

  // Adds a product to the Firestore database after validation.
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

  // Sets the selected category and fetches products filtered by that category.
  void setSelectCategory(String? category, BuildContext context) {
    _selectedCategory = category;
    fetchProductsByCategory(context);
  }

  // Clears the form fields and resets the selected category and image file.
  void clearForm() {
    _descriptionController.clear();
    _nameController.clear();
    _priceController.clear();
    _imageFile = null;
    _selectedCategory = null;
    notifyListeners();
  }

  // Sets the list of all products to be displayed.
  void setAllProducts(List<ProductModel> list) {
    _allItems = list;
    notifyListeners();
  }

  // Sets loading state.
  void setLoadingState(bool state, BuildContext context) {
    // Ensure notifyListeners is called after the current build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoading = state;
      notifyListeners();
    });
  }

  // Fetches products based on the selected category.
  // If no category is selected, it fetches all products.
  Future<void> fetchProductsByCategory(BuildContext context) async {
    setLoadingState(true, context); // Start loading

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

    setLoadingState(false, context); // End loading
    notifyListeners();
  }

  Future<void> fetchAllProducts(BuildContext context) async {
    setLoadingState(true, context); // Start loading
    List<ProductModel> allProducts =
        await productController.fetchProducts(context);
    setAllProducts(allProducts);
    setLoadingState(false, context); // End loading
  }
}
