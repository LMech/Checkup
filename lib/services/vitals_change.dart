import 'package:checkup/controllers/home_controller.dart';
import 'package:get/get.dart';

class VitalsChange {
  static final VitalsChange _vitalsChange = VitalsChange._internal();

  factory VitalsChange() => _vitalsChange;

  VitalsChange._internal();

  final homeController = Get.find<HomeController>();

  void changeHome({String hr = "", String spo2 = ""}) {
    homeController.updateAll(hr, spo2);
  }
}
