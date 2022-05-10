import 'package:checkup/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart' show Logger;

class FirestoreOperations {
  FirestoreOperations._internal();

  static final FirestoreOperations instance = FirestoreOperations._internal();

  final AuthController authController = AuthController.to;
  FirebaseFirestore db = FirebaseFirestore.instance;
  late String userEmail;

  // Check if the document exist in users using a email
  Future<bool> checkExist(String key) async {
    late bool isExist;
    try {
      await db
          .collection('users/')
          .where('email', isEqualTo: key)
          .get()
          .then((value) {
        if (value.docs.isBlank ?? false) {
          isExist = false;
        } else {
          isExist = true;
        }
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
      Logger().e(e);
      isExist = true;
    }
    return isExist;
  }

  // Get a single document using an email as key
  Future<Map<String, dynamic>> getDocument(String key) async {
    Map<String, dynamic> userMap = {};
    try {
      await db
          .collection('users/')
          .where('email', isEqualTo: key)
          .get()
          .then((value) {
        userMap = value.docs[0].data();
      });
    } catch (e) {
      Logger().e(e);
    }
    return userMap;
  }

  Future<void> updateDocumentWithkey(
    String key,
    Map<String, Object?> newValue,
  ) async {
    try {
      await db.collection('users/').where('email', isEqualTo: key).get().then(
            (value) => value.docs[0].reference.set(
              newValue,
              SetOptions(merge: true),
            ),
          );
    } catch (e) {
      Logger().e(e);
      Get.snackbar('Error', e.toString());
    }
  }
}
