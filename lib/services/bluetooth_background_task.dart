import 'dart:convert';

import 'package:checkup/services/vitals_change.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';

class BackgroundCollectingTask extends Model {
  BackgroundCollectingTask._fromConnection(this._connection) {
    _connection.input!.listen((data) {
      if (data.length == 2 && data.first.toInt() != 255) {
        debugPrint(data.toString());
        _vitalsChange.changeHome(
            hr: data.first.toString(), spo2: data.last.toString());
      }
    }).onDone(() {
      inProgress = false;
      notifyListeners();
    });
  }

  bool inProgress = false;

  final BluetoothConnection _connection;
  final VitalsChange _vitalsChange = VitalsChange();

  static BackgroundCollectingTask of(
    BuildContext context, {
    bool rebuildOnChange = false,
  }) =>
      ScopedModel.of<BackgroundCollectingTask>(
        context,
        rebuildOnChange: rebuildOnChange,
      );

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
