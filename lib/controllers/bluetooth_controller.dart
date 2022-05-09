import 'dart:async';

import 'package:checkup/controllers/home_controller.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BluetoothController extends GetxController {
  final FlutterBluetoothSerial _bluetoothSerial =
      FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;
  final HomeController homeController = Get.find<HomeController>();

  Future<List<BluetoothDevice>> getBondedDeviceList() async {
    final List<BluetoothDevice> bodedDevices =
        await _bluetoothSerial.getBondedDevices();
    return bodedDevices;
  }

  Future<void> startListener(
    BluetoothDevice server,
  ) async {
    try {
      connection = await BluetoothConnection.toAddress(server.address);
      stream();
      Get.back();
    } catch (e) {
      Logger().e(e);
      Get.snackbar('Error', 'Please, Check the state of bluetooth');
    }
  }

  void stream() {
    return connection!.input!.listen((event) {
      Logger().e(event.toString());
      final List<int> packet = event.toList();
      if (packet.length == 2 && packet.first != 255) {
        homeController.updateAll(packet.first, packet.last);
      }
    }).onDone(() {
      connection!.close();
    });
  }

  void endBackgroundTask() {
    if (connection != null) {
      connection!.close();
    }
  }
}
