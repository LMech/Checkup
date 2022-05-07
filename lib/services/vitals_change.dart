import 'package:checkup/controllers/home_controller.dart';
import 'package:get/get.dart';

class VitalsChange {
  factory VitalsChange() => _vitalsChange;

  VitalsChange._internal();

  final homeController = Get.find<HomeController>();

  static final VitalsChange _vitalsChange = VitalsChange._internal();
}
