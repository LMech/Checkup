import 'package:checkup/controllers/bluetooth_controller.dart';
import 'package:checkup/views/core/components/bluetooth_device_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

@immutable
class BluetoothDevicesUI extends StatelessWidget {
  BluetoothDevicesUI({Key? key}) : super(key: key);

  final BluetoothController bluetoothSearchController =
      Get.find<BluetoothController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select device'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: bluetoothSearchController.getBondedDeviceList(),
          builder: (_, AsyncSnapshot<List<BluetoothDevice>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext _, int index) {
                  return BluetoothDeviceCard(
                    bluetoothDevice: snapshot.data![index],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
