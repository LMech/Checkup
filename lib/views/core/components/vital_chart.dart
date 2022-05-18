import 'dart:ui' as ui;

import 'package:checkup/models/vital_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VitalChart extends StatelessWidget {
  VitalChart({
    Key? key,
    required this.data,
    required this.color,
  }) : super(key: key);

  final Color color;
  final List<VitalModel> data;
  final DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: const Text(''),
      children: <Widget>[
        SizedBox(
          height: 200.0,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0.0,
            primaryXAxis: _getDateTimeAxis(),
            primaryYAxis: NumericAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0.0),
            ),
            series: <ChartSeries<VitalModel, DateTime>>[
              SplineAreaSeries<VitalModel, DateTime>(
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
      ],
    );
  }

  DateTime _getToday() => DateTime(now.year, now.month, now.day);

  DateTime _getTomorrow() {
    final DateTime today = _getToday();
    return today.add(const Duration(hours: 24));
  }

  DateTimeAxis _getDateTimeAxis() => DateTimeAxis(
        title: AxisTitle(text: 'Time'),
        minimum: _getToday(),
        maximum: _getTomorrow(),
        majorGridLines: const MajorGridLines(width: 0),
        intervalType: DateTimeIntervalType.hours,
        desiredIntervals: 2,
        interval: 2,
        dateFormat: DateFormat.H(),
      );
}
