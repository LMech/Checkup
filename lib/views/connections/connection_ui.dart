import 'package:checkup/controllers/connection_controller.dart';
import 'package:checkup/helpers/constns.dart';
import 'package:checkup/views/core/components/profile_header.dart';
import 'package:checkup/views/core/components/vital_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
              padding: mediumPadding,
              children: <Widget>[
                ProfileHeader(
                  name: controller.argumentData!['name'] as String,
                  email: controller.argumentData!['email'] as String,
                  photoUrl: controller.argumentData!['photoUrl'] as String,
                ),
                const SizedBox(
                  height: 8.0,
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
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10.0,
                  children: <Chip>[
                    Chip(
                      label: Text(
                        controller.argumentData!['phoneNumber'] as String,
                      ),
                      avatar: const Icon(UniconsLine.mobile_android),
                    ),
                    Chip(
                      label: Text(
                        controller.argumentData!['address'] as String,
                      ),
                      avatar: const Icon(UniconsLine.map),
                    ),
                    Chip(
                      label: Text(
                        DateFormat('yMMMMd')
                            .format(
                              (controller.argumentData!['dateOfBirth']
                                      as Timestamp)
                                  .toDate(),
                            )
                            .toString(),
                      ),
                      avatar: const Icon(UniconsLine.calender),
                    ),
                    Chip(
                      label: Text(
                        controller.argumentData!['gender'] as String,
                      ),
                      avatar: const Icon(UniconsLine.mars),
                    ),
                    Chip(
                      label: Text(
                        (controller.argumentData!['height'] as int).toString(),
                      ),
                      avatar: const Icon(UniconsLine.ruler),
                    ),
                    Chip(
                      label: Text(
                        (controller.argumentData!['weight'] as int).toString(),
                      ),
                      avatar: const Icon(UniconsLine.weight),
                    ),
                    Chip(
                      label: Text(
                        controller.argumentData!['bloodType'] as String,
                      ),
                      avatar: const Icon(Icons.bloodtype),
                    ),
                  ],
                ),
                if ((controller.argumentData!['allergies'] as List<dynamic>)
                    .isNotEmpty)
                  const Text('Allergies'),
                for (dynamic allergy
                    in controller.argumentData!['allergies'] as List<dynamic>)
                  ListTile(
                    title: Text(allergy as String),
                  ),
                if ((controller.argumentData!['medicine'] as List<dynamic>)
                    .isNotEmpty)
                  const Text(
                    'Medicine',
                  ),
                for (dynamic allergy
                    in controller.argumentData!['medicine'] as List<dynamic>)
                  ListTile(
                    title: Text(allergy as String),
                  ),
                if ((controller.argumentData!['diseases'] as List<dynamic>)
                    .isNotEmpty)
                  const Text(
                    'Diseases',
                  ),
                for (dynamic allergy
                    in controller.argumentData!['diseases'] as List<dynamic>)
                  ListTile(
                    title: Text(allergy as String),
                  ),
                if ((controller.argumentData!['physician'] as List<dynamic>)
                    .isNotEmpty)
                  const Text(
                    'Physician',
                  ),
                for (dynamic allergy
                    in controller.argumentData!['physician'] as List<dynamic>)
                  ListTile(
                    title: Text(allergy as String),
                  ),
                if ((controller.argumentData!['surgery'] as List<dynamic>)
                    .isNotEmpty)
                  const Text(
                    'Surgery',
                  ),
                for (dynamic allergy
                    in controller.argumentData!['surgery'] as List<dynamic>)
                  ListTile(
                    title: Text(allergy as String),
                  ),
                if ((controller.argumentData!['vaccine'] as List<dynamic>)
                    .isNotEmpty)
                  const Text(
                    'Vaccine',
                  ),
                for (dynamic allergy
                    in controller.argumentData!['vaccine'] as List<dynamic>)
                  ListTile(
                    title: Text(allergy as String),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
