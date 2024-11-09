import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class AdminController {
  CollectionReference admin = FirebaseFirestore.instance.collection("Admin");

  Future<List<String>?> getAdmins() async {
    List<String> uids = await admin.doc("admins").get().then((value) {
      List<String> uids =
          ((value.data() as Map<String, dynamic>)['uidList'] as List<dynamic>)
              .map((e) => e.toString())
              .toList();
      Logger().f(uids);
      return uids;
    });
    return uids;
  }
}