import 'dart:convert';

import 'package:checkup/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

final homeController = Get.find<HomeController>();

class BackgroundCollectingTask extends Model {
  static BackgroundCollectingTask of(
    BuildContext context, {
    bool rebuildOnChange = false,
  }) =>
      ScopedModel.of<BackgroundCollectingTask>(
        context,
        rebuildOnChange: rebuildOnChange,
      );

  final BluetoothConnection _connection;
  final List<int> _buffer = List<int>.empty(growable: true);

  // @TODO , Such sample collection in real code should be delegated
  // (via `Stream<DataSample>` preferably) and then saved for later
  // displaying on chart (or even streight prepare for displaying).
  // @TODO ? should be shrinked at some point, endless colleting data would cause memory shortage.
  bool inProgress = false;

  BackgroundCollectingTask._fromConnection(this._connection) {
    _connection.input!.listen((data) {
      debugPrint(data.toString());
      // _buffer += data;
      // // print('${ascii.decode(data)}');

      // while (true) {
      //   // If there is a sample, and it is full sent
      //   // debugPrint(ascii.decode(data)/);
      //   // debugPrint(ascii.decode(data));
      //   // homeController.updateHR(data.last.toString());

      //   int index = _buffer.indexOf('t'.codeUnitAt(0));
      //   if (index >= 0 && _buffer.length - index >= 2) {
      //     notifyListeners();
      //   } else {
      //     break;
      //   }
      // }
    }).onDone(() {
      inProgress = false;
      notifyListeners();
    });
  }

  static Future<BackgroundCollectingTask> connect(
      BluetoothDevice server) async {
    final BluetoothConnection connection =
        await BluetoothConnection.toAddress(server.address);
    return BackgroundCollectingTask._fromConnection(connection);
  }

  void dispose() {
    _connection.dispose();
  }

  Future<void> start() async {
    inProgress = true;
    _buffer.clear();
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }

  Future<void> cancel() async {
    inProgress = false;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.finish();
  }

  Future<void> pause() async {
    inProgress = false;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.output.allSent;
  }

  Future<void> resume() async {
    inProgress = true;
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }
}
