import 'package:checkup/views/bluetooth_search_ui.dart';
import 'package:checkup/views/bluetooth_background_task.dart';
import 'package:checkup/views/components/list_tile_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ConnectUI extends StatefulWidget {
  const ConnectUI({Key? key}) : super(key: key);

  @override
  State<ConnectUI> createState() => _ConnectUIState();
}

class _ConnectUIState extends State<ConnectUI> {
  BackgroundCollectingTask? _collectingTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose method"),
      ),
      body: ListView(children: [
        ListTileWithIcon(
          title: ((_collectingTask?.inProgress ?? false)
              ? 'Disconnect and stop background collecting'
              : 'Connect to start background collecting'),
          icon: Icons.arrow_forward_ios_outlined,
          size: 20.0,
          onTap: () async {
            {
              if (_collectingTask?.inProgress ?? false) {
                await _collectingTask!.cancel();
                setState(() {
                  /* Update for `_collectingTask.inProgress` */
                });
              } else {
                final BluetoothDevice? selectedDevice =
                    await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const SelectBondedDevicePage(
                          checkAvailability: false);
                    },
                  ),
                );

                if (selectedDevice != null) {
                  await _startBackgroundTask(context, selectedDevice);
                  setState(() {
                    /* Update for `_collectingTask.inProgress` */
                  });
                }
              }
            }
          },
        ),
      ]),
    );
  }

  Future<void> _startBackgroundTask(
    BuildContext context,
    BluetoothDevice server,
  ) async {
    try {
      _collectingTask = await BackgroundCollectingTask.connect(server);
      await _collectingTask!.start();
    } catch (ex) {
      _collectingTask?.cancel();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error while connecting'),
            content: Text(ex.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
