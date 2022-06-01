// TODO: Add the logic
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:checkup/controllers/home_controller.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class CameraOximeterController extends GetxController {
  Rx<bool> started = false.obs;
  CameraController? cameraController;
  CameraImage? _image;
  Timer? _timer;

  late List<double> rs;
  late List<double> gs;
  late List<double> bs;

  @override
  Future<void> onInit() async {
    rs = <double>[];
    gs = <double>[];
    bs = <double>[];
    try {
      final List<CameraDescription> _cameras = await availableCameras();
      cameraController = CameraController(
        _cameras.first,
        ResolutionPreset.low,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
    } catch (e) {
      Get.back();
      Get.snackbar('Error while opening the camera', e.toString());
    }
    super.onInit();
  }

  Future<void> startCamera() async {
    try {
      await cameraController!.initialize();
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        cameraController!.setFlashMode(FlashMode.torch);
      });
      started(true);
      await cameraController!.startImageStream((CameraImage image) {
        _image = image;
      }).then((value) => _initTimer());
    } catch (e) {
      Logger().e(e);
      Get.snackbar('Error using the camera', e.toString());
    }
  }

  void _initTimer() {
    final List<List<double>> ppg = <List<double>>[];
    final List<SensorValue> meanRed = <SensorValue>[];
    List<double> tmp = <double>[];
    _timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 30), (timer) {
      if (started.value) {
        if (_image != null) {
          tmp = _meanYUV2RGB(_image!);
          ppg.add(tmp);
          meanRed.add(SensorValue(value: tmp[0], time: DateTime.now()));
          if (meanRed.length == 250) {
            _startMeasurement(ppg, meanRed);
          }
        }
      } else {
        timer.cancel();
      }
    });
  }

  // This function takes a YUV CameraImage format convert it to RGB and return the mean value of each channel
  List<double> _meanYUV2RGB(CameraImage _image) {
    try {
      final int width = _image.width;
      final int height = _image.height;
      final int area = width * height;
      final int uvRowStride = _image.planes[1].bytesPerRow;
      final int? uvPixelStride = _image.planes[1].bytesPerPixel;
      int r = 0;
      int g = 0;
      int b = 0;

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          final int uvIndex =
              uvPixelStride! * (x / 2).floor() + uvRowStride * (y / 2).floor();
          final int index = y * width + x;

          final yp = _image.planes[0].bytes[index];
          final up = _image.planes[1].bytes[uvIndex];
          final vp = _image.planes[2].bytes[uvIndex];
          // Calculate pixel color
          r += (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          g += (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
              .round()
              .clamp(0, 255);
          b += (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        }
      }
      return [r / area, g / area, b / area];
    } catch (e) {
      Logger().e(e);
      return [-1.0];
    }
  }

  @override
  void onClose() {
    started(false);
    if (cameraController != null) {
      cameraController!.setFlashMode(FlashMode.off);
      cameraController!.dispose();
    }
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  Future<void> _startMeasurement(
    List<List<double>> ppg,
    List<SensorValue> meanRed,
  ) async {
    if (meanRed.every((element) => element.value > 150)) {
      double spo2Value = await _getSpo2(ppg.sublist(48, 202));
      final double hrValue = _getHR(meanRed.sublist(40, 220));
      Get.find<HomeController>().updateAll(hrValue.toInt(), spo2Value.toInt());
      Get.back();
      if (spo2Value > 99.0) {
        spo2Value = 99.0;
      }
      Get.defaultDialog(
        title:
            'Your Oxygen saturation is predicted to be ${spo2Value.toStringAsFixed(0)}, and your heart rate on average is ${hrValue.toStringAsFixed(0)}',
        middleText: '',
      );
    } else {
      cameraController!.setFlashMode(FlashMode.off);
      cameraController!.stopImageStream();
      started(false);
      Get.defaultDialog(
        title:
            'Please, make sure your hand is placed on the camera and flash at the same time',
        middleText: '',
      );
    }
  }

  Future<double> _getSpo2(List<List<double>> ppg) async {
    final interpreter = await tfl.Interpreter.fromAsset('spo2.tflite');
    final output = [
      [-1.0]
    ];
    interpreter.run([ppg], output);
    interpreter.close();
    return output.first.first;
  }

  double _getHR(List<SensorValue> meanRed) {
    final List<int> values = [];
    int currentValue = 0;

    for (int i = 50; i < meanRed.length; i++) {
      double maxVal = 0;
      double _avg = 0;
      final subMeanRed = meanRed.sublist(i - 50, i);
      for (final element in subMeanRed) {
        _avg += element.value / subMeanRed.length;
        if (element.value > maxVal) {
          maxVal = element.value as double;
        }
      }
      final double _threshold = (maxVal + _avg) / 2;
      int _counter = 0;
      int _previousTimestamp = 0;
      double _tempBPM = 0.0;

      for (int j = 1; j < subMeanRed.length; j++) {
        if (subMeanRed[j - 1].value < _threshold &&
            subMeanRed[j].value > _threshold) {
          if (_previousTimestamp != 0) {
            _counter++;
            _tempBPM += 60000 /
                (subMeanRed[j].time.millisecondsSinceEpoch -
                    _previousTimestamp);
          }
          _previousTimestamp = subMeanRed[j].time.millisecondsSinceEpoch;
        }
      }

      if (_counter > 0) {
        _tempBPM /= _counter;
        _tempBPM = .3 * currentValue + .7 * _tempBPM;
        currentValue = _tempBPM.toInt();
        if (currentValue != 0 && currentValue > 20 && currentValue < 250) {
          values.add(currentValue);
        }
      }
    }
    return values.average;
  }
}

class SensorValue {
  /// timestamp of datapoint
  final DateTime time;

  /// value of datapoint
  final num value;

  SensorValue({required this.time, required this.value});

  /// Returns JSON mapped data point
  Map<String, dynamic> toJSON() => {'time': time, 'value': value};

  /// Map a list of data samples to a JSON formatted array.
  ///
  /// Map a list of [data] samples to a JSON formatted array. This is
  /// particularly useful to store [data] to database.
  static List<Map<String, dynamic>> toJSONArray(List<SensorValue> data) =>
      List.generate(data.length, (index) => data[index].toJSON());
}
