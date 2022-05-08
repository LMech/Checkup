import 'package:checkup/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

@immutable
class BluetoothDevicesUI extends StatelessWidget {
  BluetoothController bluetoothSearchController =
      Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select device'),
      ),
      body: FutureBuilder(
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
    );
  }
}

// TODO: Enahnce and move to components
class BluetoothDeviceCard extends StatelessWidget {
  BluetoothDeviceCard({Key? key, required this.bluetoothDevice})
      : super(key: key);
  final BluetoothDevice bluetoothDevice;
  BluetoothController bluetoothSearchController = Get.find();

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
