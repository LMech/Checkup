import 'package:checkup/controllers/auth_controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final AuthController authController = AuthController.to;

  String email = AuthController.to.firestoreUser.value!.email;
  String name = AuthController.to.firestoreUser.value!.name;
  String photoUrl = AuthController.to.firestoreUser.value!.photoUrl;
  Future<void> Function() signout = AuthController.to.signOut;
}
