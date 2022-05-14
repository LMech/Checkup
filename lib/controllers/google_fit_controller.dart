import 'dart:async';

import 'package:checkup/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:logger/logger.dart';

class GoogleFitController extends GetxController {
  final HealthFactory health = HealthFactory();
  final types = [HealthDataType.HEART_RATE, HealthDataType.BLOOD_OXYGEN];
  final HomeController homeController = Get.find<HomeController>();
  Timer? periodicTime;

  Future<void> startStream() async {
    await health.requestAuthorization(types);
    periodicTime = Timer.periodic(const Duration(minutes: 2), (timer) async {
      final now = DateTime.now();
      final List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(
        now.subtract(const Duration(minutes: 2)),
        now,
        types,
      );
      Logger().e('here');
      for (final HealthDataPoint point in healthData) {
        if (point.type == HealthDataType.HEART_RATE) {
          homeController.updateHR(
            point.value.toInt(),
            measuringTime: point.dateTo.toLocal(),
          );
        } else if (point.type == HealthDataType.BLOOD_OXYGEN) {
          homeController.updateSpo2(
            point.value.toInt(),
            measuringTime: point.dateTo.toLocal(),
          );
        }
      }
    });
  }

  void endStream() {
    periodicTime!.cancel();
    Logger().e(periodicTime!.isActive);
  }
}
