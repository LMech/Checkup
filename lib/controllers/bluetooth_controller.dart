import 'dart:async';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BluetoothController extends GetxController {
  final FlutterBluetoothSerial _bluetoothSerial =
      FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;

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
