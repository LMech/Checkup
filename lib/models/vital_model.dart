class VitalModel {
  VitalModel({required this.measuringTime, required this.value});

  final DateTime measuringTime;
  final int value;
  @override
  String toString() {
    return 'UserModel(x: $measuringTime, yValue: $value)';
  }
}
