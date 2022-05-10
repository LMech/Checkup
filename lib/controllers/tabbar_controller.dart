import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/services/firestore_crud.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TabbarController extends GetxController {
  RxInt tabIndex = 0.obs;
  AuthController authController = AuthController.to;

  @override
  Future<void> onInit() async {
    final String fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    if (fcmToken != authController.firestoreUser.value!.fcm && fcmToken != '') {
      FirestoreOperations.instance.updateDocumentWithkey(
        authController.firestoreUser.value!.email,
        {'fcm': authController.firestoreUser.value!.fcm},
      );
    }
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      Get.dialog(
        AlertDialog(
          title: Text(message.notification!.title!),
          content: Text(message.notification!.body!),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('Close'))
          ],
        ),
      );
      Logger().e(message.notification!.toMap());
    });
    super.onInit();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
}
