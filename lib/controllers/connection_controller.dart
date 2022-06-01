import 'package:checkup/models/vital_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ConnectionController extends GetxController {
  Map<String, dynamic>? argumentData = Get.arguments as Map<String, dynamic>?;
  RxList<VitalModel> hr = <VitalModel>[].obs;
  RxList<VitalModel> spo2 = <VitalModel>[].obs;

  late final DatabaseReference _ref;
  late final String _today;
  late final String _uid;

  @override
  Future<void> onInit() async {
    _uid = argumentData!['uid'] as String;
    final DateTime now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day)
        .millisecondsSinceEpoch
        .toString();
    _loadFromDb();
    _ref = FirebaseDatabase.instance.ref('users/$_uid/$_today');
    _ref.onValue.listen((DatabaseEvent event) {
      _loadFromDb();
    });
    super.onInit();
  }

  Future<void> _loadFromDb() async {
    final snapshotHR = await _ref.child('/hr').orderByKey().get();
    if (snapshotHR.exists) {
      for (final DataSnapshot child in snapshotHR.children) {
        hr.add(
          VitalModel(
            measuringTime: DateTime.fromMillisecondsSinceEpoch(
              int.parse(child.key.toString()),
            ),
            value: int.parse(child.value.toString()),
          ),
        );
      }
      final snapshotSpo2 = await _ref.child('/spo2').orderByKey().get();
      if (snapshotHR.exists) {
        for (final DataSnapshot child in snapshotSpo2.children) {
          spo2.add(
            VitalModel(
              measuringTime: DateTime.fromMillisecondsSinceEpoch(
                int.parse(child.key.toString()),
              ),
              value: int.parse(child.value.toString()),
            ),
          );
        }
      }
    }
  }
}
