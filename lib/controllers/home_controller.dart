import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/models/vital_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthController authController = AuthController.to;
  RxList<VitalModel> hr = <VitalModel>[].obs;
  RxList<VitalModel> spo2 = <VitalModel>[].obs;

  late final String _today;
  late final DatabaseReference _ref;
  late final String _uid;

  @override
  Future<void> onInit() async {
    _uid = authController.firestoreUser.value!.uid;
    _ref = FirebaseDatabase.instance.ref('users/$_uid/');

    final DateTime now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day)
        .millisecondsSinceEpoch
        .toString();
    _loadFromDb();
    super.onInit();
  }

  Future<void> updateHR(int newHR) async {
    final DateTime now = DateTime.now();
    hr.add(VitalModel(measuringTime: now, value: newHR));
    await _ref
        .child('$_today/hr')
        .update({now.millisecondsSinceEpoch.toString(): newHR});
  }

  Future<void> updateSpo2(int newSpo2) async {
    final DateTime now = DateTime.now();
    spo2.add(VitalModel(measuringTime: now, value: newSpo2));

    await _ref
        .child('$_today/spo2')
        .update({now.millisecondsSinceEpoch.toString(): newSpo2});
  }

  void updateAll(int hr, int spo2) {
    updateHR(hr);
    updateSpo2(spo2);
  }

  Future<void> _loadFromDb() async {
    final snapshotHR = await _ref.child('$_today/hr').get();
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
      final snapshotSpo2 = await _ref.child('$_today/spo2').get();
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
