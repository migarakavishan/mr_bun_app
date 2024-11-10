import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

// Controller for managing image uploads to Firebase Storage.
class StroageController {
  // - [path]: The storage path in Firebase where the file should be uploaded.
  // - [fileName]: The name of the file in Firebase Storage.
  // - [file]: The image file to be uploaded.
  Future<String> uploadImage(String path, String fileName, File file) async {
    try {
      final reference = FirebaseStorage.instance.ref("$path/$fileName");
      final uploadTask = reference.putFile(file);
      final taskSnapshot = await uploadTask.whenComplete(() {});
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }
}
