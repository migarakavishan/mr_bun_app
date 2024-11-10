import 'dart:io';

import 'package:bun_app/controllers/auth_controller.dart';
import 'package:bun_app/controllers/stroage_controller.dart';
import 'package:bun_app/providers/auth_provider.dart';
import 'package:bun_app/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// ProfileProvider class to manage profile-related functionality
class ProfileProvider extends ChangeNotifier {
  AuthController authController = AuthController();

  FileImagePicker picker = FileImagePicker(); // Utility for image selection

  StroageController storage = StroageController();

   // Text controller for the user's name
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  // File for storing selected profile image
  File? _pickedImage;
  File? get pickedImage => _pickedImage;

  // Sets the username in the text controller and notifies listeners
  void setUserName(String name) {
    _nameController.text = name;
    notifyListeners();
  }

  // Updates user data, including profile image upload and name change
  Future<void> updateUserData(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    if (_pickedImage != null) {
      String url = await storage.uploadImage(
          "User Images", "${auth.user!.uid}.jpg", _pickedImage!);
      Logger().f(url);
      if (url != "") {
        auth.updateImage(url);
      }
    }

    if (_nameController.text.trim().isNotEmpty) {
      Map<String, dynamic> data = {
        "name": _nameController.text,
        "image": auth.userModel!.image
      };
      authController.updateUser(data, auth.user!.uid);
    } else {
      Logger().e("Please enter your name");
    }
  }

  // Picks a profile image using the image picker utility
  Future<void> pickProfileImage(BuildContext context) async {
    _pickedImage = await picker.pickImage();
    notifyListeners();
  }
}
