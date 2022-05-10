import 'package:checkup/controllers/bluetooth_controller.dart';
import 'package:checkup/controllers/google_fit_controller.dart';
import 'package:checkup/controllers/home_controller.dart';
import 'package:checkup/services/vitals_change.dart';
import 'package:checkup/views/core/components/feature_card.dart';
import 'package:checkup/views/core/components/vital_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                () => VitalChart(
                  data: controller.hr.toList(),
                  color: Colors.red[800] ?? Colors.red,
                  icon: Icons.favorite,
                ),
              ),
              const SizedBox(height: 35),
              Obx(
                () => VitalChart(
                  data: controller.spo2.toList(),
                  color: Colors.blueAccent[800] ?? Colors.blue,
                  icon: Icons.invert_colors,
                  rtl: true,
                ),
              ),
              const SizedBox(height: 35),
              _featuresList(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            VitalsClassifier.instance.spo2Classifier(89);
          },
        ),
      ),
    );
  }

  Widget _bottomSheet() {
    final BluetoothController bluetoothController =
        Get.find<BluetoothController>();
    final GoogleFitController googleFitController =
        Get.find<GoogleFitController>();
    return Wrap(
      children: [
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
            title: const Text('Conntect to Google Fit'),
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
              googleFitController.endtream();
              Get.back();
            },
          )
      ],
    );
  }

  Widget _featuresList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Discover other features',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 20),
              FeatureCard(
                color: Get.theme.focusColor,
                icon: Icons.assessment_outlined,
                title: 'Report',
                description: 'Export and share your data',
                onTap: () {},
              ),
              const SizedBox(width: 15),
              FeatureCard(
                color: Get.theme.focusColor,
                icon: Icons.monitor_heart_outlined,
                title: 'Camera Oximeter',
                description: 'Measure important vital using your phone camera',
                onTap: () {},
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class ChartSampleData {
  ChartSampleData({this.x, this.yValue});

  final DateTime? x;
  final double? yValue;
}
