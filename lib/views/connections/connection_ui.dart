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
                  () => VitalChart(
                    data: controller.hr.toList(),
                    color: Colors.red[800] ?? Colors.red,
                  ),
                ),
                const SizedBox(height: 35),
                Obx(
                  () => VitalChart(
                    data: controller.spo2.toList(),
                    color: Colors.blueAccent[800] ?? Colors.blue,
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
