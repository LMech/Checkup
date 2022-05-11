import 'package:checkup/controllers/auth_controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static final AuthController authController = AuthController.to;

  String email = authController.firestoreUser.value!.email;
  String name = authController.firestoreUser.value!.name;
  String photoUrl = authController.firestoreUser.value!.photoUrl;
  Future<void> Function() signout = authController.signOut;
}
