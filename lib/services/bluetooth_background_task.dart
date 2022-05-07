import 'dart:convert';

import 'package:checkup/services/vitals_change.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart'
    show BluetoothConnection, BluetoothDevice;
import 'package:logger/logger.dart' show Logger;
import 'package:scoped_model/scoped_model.dart' show Model, ScopedModel;

class BackgroundCollectingTask extends Model {
  BackgroundCollectingTask._fromConnection(this._connection) {
    _connection.input!.listen((data) {
      if (data.length == 2 && data.first != 255) {
        Logger().e(data.toString());
        // TODO: update the ui
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
    BluetoothDevice server,
  ) async {
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
