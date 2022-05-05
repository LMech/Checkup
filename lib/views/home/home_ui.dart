import 'package:checkup/controllers/home_controller.dart';
import 'package:checkup/views/core/components/avatar.dart';
import 'package:checkup/views/core/components/feature_card.dart';
import 'package:checkup/views/core/components/vital_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';
import 'package:unicons/unicons.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  Widget _profileData(String name, String photoUrl) {
    final String userName = name;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, $userName',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              "Let's make a checkup",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Avatar(
          photoUrl,
          radius: 60.0,
          height: 200,
          width: 200,
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                size: 40.0,
                color: Get.theme.iconTheme.color,
              ),
              onPressed: () {
                Get.toNamed('/tabbar/home/connect');
              },
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              const SizedBox(height: 35),
              Obx(
                () => VitalChart(
                  data: controller.newHR.toList(),
                  color: Colors.red[800] ?? Colors.red,
                  icon: UniconsLine.heartbeat,
                ),
              ),
              const SizedBox(height: 35),
              Obx(
                () => VitalChart(
                  data: controller.newHR.toList(),
                  color: Colors.blueAccent[800] ?? Colors.blue,
                  icon: UniconsLine.raindrops,
                  rtl: true,
                ),
              ),
              const SizedBox(height: 35),
              _featuresList(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.updateNewHR();
          },
        ),
      ),
    );
  }
}

class ChartSampleData {
  ChartSampleData({this.x, this.yValue});

  final DateTime? x;
  final double? yValue;
}
