import 'dart:math';

import 'package:checkup/controllers/bluetooth_controller.dart';
import 'package:checkup/controllers/home_controller.dart';
import 'package:checkup/views/core/components/feature_card.dart';
import 'package:checkup/views/core/components/vital_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          elevation: 0.0,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            IconButton(
              onPressed: () {
                Get.bottomSheet(
                  _bottomSheet(),
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                );
              },
              icon: const Icon(Icons.plus_one),
            ),
            const SizedBox(height: 35),
            Obx(
              () => VitalChart(
                data: controller.hr.toList(),
                color: Colors.red[800] ?? Colors.red,
                icon: UniconsLine.heartbeat,
              ),
            ),
            const SizedBox(height: 35),
            Obx(
              () => VitalChart(
                data: controller.spo2.toList(),
                color: Colors.blueAccent[800] ?? Colors.blue,
                icon: UniconsLine.raindrops,
                rtl: true,
              ),
            ),
            const SizedBox(height: 35),
            _featuresList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.updateAll(
              Random().nextInt(20) + 60,
              Random().nextInt(10) + 90,
            );
          },
        ),
      ),
    );
  }

  Widget _bottomSheet() {
    final bool isBluetoothRegistered = Get.isRegistered<BluetoothController>();
    return Wrap(
      children: [
        if (isBluetoothRegistered)
          ListTile(
            leading: Icon(
              Icons.bluetooth_disabled,
              color: Get.theme.errorColor,
            ),
            title: const Text('Disconnect'),
            onTap: () {
              Get.find<BluetoothController>().endBackgroundTask();
              Get.delete<BluetoothController>();
              Get.back();
            },
          )
        else
          ListTile(
            leading: Icon(
              Icons.bluetooth,
              color: Get.theme.primaryColor,
            ),
            title: const Text('Connect'),
            onTap: () {
              Get.back();
              Get.toNamed('/tabbar/home/bluetooth_search');
            },
          ),
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
