// TODO:Add the logic
import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

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
    rs = [];
    gs = [];
    bs = [];
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
    }
  }

  void _initTimer() {
    Logger().e('work');
    final List<List<double>> ppg = [];
    final List<double> meanRed = [];
    List<double> tmp = [];
    _timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 30), (timer) {
      if (started.value) {
        if (_image != null) {
          tmp = _meanYUV2RGB(_image!);
          ppg.add(tmp);
          meanRed.add(tmp[0]);
          if (meanRed.length == 200) {
            Get.back();
            log(ppg.toString());
            log(meanRed.toString());
          }
        }
      } else {
        Logger().e("canceled");
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
}
