import 'package:checkup/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AboutYouController extends GetxController {
  static final AuthController authController = AuthController.to;
  TextEditingController nameTextController =
      TextEditingController(text: authController.firestoreUser.value!.name);
}
