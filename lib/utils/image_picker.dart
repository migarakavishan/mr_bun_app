// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class FileImagePicker {
  // Instance of ImagePicker to open gallery and pick image
  ImagePicker picker = ImagePicker();

  // pick an image from the gallery
  Future<File?> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Logger().f(pickedFile.path);
      return File(pickedFile.path);
    } else {
      Logger().e("Try Again");
      return null;
    }
  }
}
