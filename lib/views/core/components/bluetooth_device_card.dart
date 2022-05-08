import 'package:checkup/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

@immutable
class BluetoothDeviceCard extends StatelessWidget {
  BluetoothDeviceCard({Key? key, required this.bluetoothDevice})
      : super(key: key);

  final BluetoothDevice bluetoothDevice;
  final BluetoothController bluetoothSearchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bluetoothSearchController.startListener(bluetoothDevice);
      },
      child: Text(
        bluetoothDevice.name!,
        style: const TextStyle(fontSize: 60),
      ),
    );
  }
}
