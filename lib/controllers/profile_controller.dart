import 'package:checkup/controllers/controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfileController extends GetxController {
  final AuthController _authController = AuthController.to;

  late TextEditingController phoneNumberController;
  late TextEditingController dataOfBirthController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late final DocumentReference<Map<String, dynamic>> _userData;

  @override
  void onInit() async {
    super.onInit();
    _userData = FirebaseFirestore.instance
        .doc('/users/${_authController.firebaseUser.value!.uid}');
    var data = await _authController.streamFirestoreUser().first;
    phoneNumberController = TextEditingController(text: data.phoneNumber);
    dataOfBirthController = TextEditingController(text: data.dateOfBirth);
    heightController = TextEditingController(
        text: data.height == -1 ? '' : data.height.toString());
    weightController = TextEditingController(
        text: data.weight == -1 ? '' : data.weight.toString());
  }

  Future<void> updateDB(String field, String newText) async {
    await _userData.update({field: newText});
  }
}
