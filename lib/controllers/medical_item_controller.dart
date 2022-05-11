import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/services/firestore_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MedicalItemController extends GetxController {
  static String argumentData = Get.arguments as String;
  String name = argumentData;
  RxList<dynamic> elements = (AuthController.to.firestoreUser.value!
          .toMap()[argumentData] as List<dynamic>)
      .obs;
  void removeCard(String value) {
    FirestoreOperations.instance.updateDocument({
      argumentData: FieldValue.arrayRemove([value])
    });
    elements.remove(value);
  }
}
