import 'dart:ui' as ui;

import 'package:checkup/models/vital_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VitalChart extends StatelessWidget {
  VitalChart({
    Key? key,
    required this.data,
    required this.color,
    this.maximum,
  }) : super(key: key);

  final Color color;
  final List<VitalModel> data;
  final DateTime now = DateTime.now();
  final double? maximum;

  ZoomController zoomController = Get.put<ZoomController>(ZoomController());
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: const Text(''),
      children: <Widget>[
        SizedBox(
          height: 200.0,
          child: Obx(
            () => SfCartesianChart(
              onZooming: (ZoomPanArgs args) {
                if (args.axis!.name == 'Color(0xffd32f2f)') {
                  zoomController.zoomPosition(
                    args.currentZoomPosition,
                  );
                  zoomController.zoomFactor(args.currentZoomFactor);
                } else if (args.axis!.name ==
                    'MaterialColor(primary value: Color(0xff2196f3))') {
                  zoomController.zoomPosition(
                    args.currentZoomPosition,
                  );
                  zoomController.zoomFactor(args.currentZoomFactor);
                }
                if (args.axis!.name == 'Color(0xffd32f2f)' &&
                    args.currentZoomFactor < .03) {
                  zoomController.isVisible(true);
                } else if (args.axis!.name == 'Color(0xffd32f2f)' &&
                    args.currentZoomFactor > .03) {
                  zoomController.isVisible(false);
                }
                if (args.axis!.name ==
                        'MaterialColor(primary value: Color(0xff2196f3))' &&
                    args.currentZoomFactor < .03) {
                  zoomController.isVisible(true);
                } else if (args.axis!.name ==
                        'MaterialColor(primary value: Color(0xff2196f3))' &&
                    args.currentZoomFactor > .03) {
                  zoomController.isVisible(false);
                }
              },
              zoomPanBehavior: zoomController.zoomPanBehavior,
              plotAreaBorderWidth: 0.0,
              primaryXAxis: _getDateTimeAxis(),
              primaryYAxis: NumericAxis(
                axisLine: const AxisLine(width: 0.0),
                maximum: maximum,
              ),
              series: <ChartSeries<VitalModel, DateTime>>[
                SplineAreaSeries<VitalModel, DateTime>(
                  cardinalSplineTension: .3,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: zoomController.isVisible.value,
                    labelAlignment: ChartDataLabelAlignment.top,
                  ),
                  markerSettings: MarkerSettings(
                    isVisible: zoomController.isVisible.value,
                    borderColor: color,
                    shape: DataMarkerType.diamond,
                  ),
                  dataSource: data,
                  xValueMapper: (VitalModel sales, _) => sales.measuringTime,
                  yValueMapper: (VitalModel sales, _) => sales.value,
                  splineType: SplineType.cardinal,
                  borderWidth: 2,
                  borderColor: color,
                  onCreateShader: (ShaderDetails details) {
                    return ui.Gradient.linear(details.rect.topCenter,
                        details.rect.bottomCenter, <Color>[
                      color,
                      Colors.transparent,
                    ]);
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  DateTime _getToday() => DateTime(now.year, now.month, now.day);

  DateTime _getTomorrow() {
    final DateTime today = _getToday();
    return today.add(const Duration(hours: 24));
  }

  DateTimeAxis _getDateTimeAxis() => DateTimeAxis(
        enableAutoIntervalOnZooming: true,
        title: AxisTitle(text: 'Time of Day'),
        zoomFactor: zoomController.zoomFactor.value,
        zoomPosition: zoomController.zoomPosition.value,
        name: color.toString(),
        minimum: _getToday(),
        maximum: _getTomorrow(),
        desiredIntervals: 24,
      );
}

class ZoomController extends GetxController {
  final ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    enableDoubleTapZooming: true,
    enablePanning: true,
    zoomMode: ZoomMode.x,
  );
  Rx<bool> isVisible = false.obs;
  Rx<double> zoomFactor = 1.0.obs;
  Rx<double> zoomPosition = 1.0.obs;
}
