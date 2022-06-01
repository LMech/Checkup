import 'dart:math';

import 'package:checkup/controllers/bluetooth_controller.dart';
import 'package:checkup/controllers/google_fit_controller.dart';
import 'package:checkup/controllers/home_controller.dart';
import 'package:checkup/helpers/constns.dart';
import 'package:checkup/views/core/components/vital_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unicons/unicons.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: mediumPadding,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                      _bottomSheet(),
                      backgroundColor: Get.theme.scaffoldBackgroundColor,
                    );
                  },
                  icon: const Icon(UniconsLine.plus),
                ),
              ),
              Obx(
                () => Container(
                  decoration: customBoxDecoration,
                  child: Padding(
                    padding: mediumPadding,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              UniconsLine.heartbeat,
                              size: 80,
                              color: Get.theme.errorColor,
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Heart Rate (bpm)',
                                  style: TextStyle(fontSize: 24),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    controller.hr.isEmpty
                                        ? '--'
                                        : 'bpm ${controller.hr.last.value.toString()}',
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        VitalChart(
                          data: controller.hr,
                          color: Get.theme.errorColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Obx(
                () => Container(
                  decoration: customBoxDecoration,
                  padding: mediumPadding,
                  child: Column(
                    children: <Widget>[
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Blood Oxygen (spo2)',
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          controller.spo2.isEmpty
                              ? '--'
                              : '${controller.spo2.last.value.toString()}%',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      VitalChart(
                        data: controller.spo2.toList(),
                        color: Colors.blueAccent[800] ?? Colors.blue,
                        maximum: 100.0,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _cameraOximeter(controller),
            ],
          ),
        ),
      ),
    );
  }

  Wrap _bottomSheet() {
    final BluetoothController bluetoothController =
        Get.find<BluetoothController>();
    final GoogleFitController googleFitController =
        Get.find<GoogleFitController>();
    return Wrap(
      children: <Widget>[
        if (bluetoothController.connection != null &&
            bluetoothController.connection!.isConnected)
          ListTile(
            leading: Icon(
              Icons.bluetooth_disabled,
              color: Get.theme.errorColor,
            ),
            title: const Text('Disconnect from Bluetooth'),
            onTap: () {
              Get.find<BluetoothController>().endBackgroundTask();
              Get.back();
            },
          )
        else
          ListTile(
            leading: const Icon(
              Icons.bluetooth,
            ),
            title: const Text('Connect to Bluetooth'),
            onTap: () {
              Get.back();
              Get.toNamed('/tabbar/home/bluetooth_search');
            },
          ),
        if (googleFitController.periodicTime == null ||
            !googleFitController.periodicTime!.isActive)
          ListTile(
            leading: const Icon(
              Icons.watch_outlined,
            ),
            title: const Text('Connect to Google Fit'),
            onTap: () async {
              await Permission.activityRecognition.request();
              googleFitController.startStream();
              Get.back();
            },
          )
        else
          ListTile(
            leading: Icon(
              Icons.watch_off_outlined,
              color: Get.theme.errorColor,
            ),
            title: const Text('Disconnect from Google Fit'),
            onTap: () async {
              googleFitController.endStream();
              Get.back();
            },
          )
      ],
    );
  }

  Widget _cameraOximeter(HomeController controller) => InkWell(
        onTap: () => Get.toNamed('/tabbar/home/camera_oximeter'),
        child: Container(
          height: Get.height * .3,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 105, 121, 142),
                Color.fromARGB(255, 59, 79, 117),
                Color.fromARGB(255, 18, 38, 44),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(
                UniconsLine.monitor_heart_rate,
                color: Colors.white,
                size: 100,
              ),
              Text(
                'Camera\nOximeter',
                style: TextStyle(color: Colors.white, fontSize: 40),
              )
            ],
          ),
        ),
        onDoubleTap: () => controller.updateAll(
          Random().nextInt(40) + 60,
          Random().nextInt(10) + 90,
        ),
        onLongPress: () => controller.updateSpo2(Random().nextInt(10) + 80),
      );
}
