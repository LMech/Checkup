import 'package:checkup/controllers/connection_controller.dart';
import 'package:checkup/views/core/components/vital_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

// TODO: Add all the missing data
class ConnectionUI extends StatelessWidget {
  const ConnectionUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionController>(
      init: ConnectionController(),
      builder: (controller) {
        return Scaffold(
          appBar:
              AppBar(title: Text(controller.argumentData!['name'] as String)),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
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
              ],
            ),
          ),
        );
      },
    );
  }
}
