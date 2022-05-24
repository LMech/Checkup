// TODO: Add the UI

import 'package:camera/camera.dart';
import 'package:checkup/controllers/camera_oximeter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class CameraOximeterUI extends StatelessWidget {
  const CameraOximeterUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraOximeterController>(
      init: CameraOximeterController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Camera Oximeter'),
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Obx(
                      () => controller.started.value
                          ? CameraPreview(controller.cameraController!)
                          : Container(),
                    ),
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        controller.startCamera();
                      },
                      icon: const Icon(UniconsLine.play),
                      label: const Text('Start measurement'),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
