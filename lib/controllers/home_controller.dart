import 'package:checkup/controllers/auth_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthController authController = AuthController.to;
  late final DatabaseReference _ref;

  late final String _uid;

  RxString hr = '--'.obs;
  RxString spo2 = '--'.obs;

  @override
  void onInit() {
    _uid = authController.firestoreUser.value!.uid;
    _ref = FirebaseDatabase.instance.ref('users/$_uid/');
    super.onInit();
  }

  void updateHR(String hr) async {
    this.hr(hr);

    List<String> time = _getNowUnixTime();
    await _ref.child('hr/${time[1]}').update({time[0]: hr});
  }

  void updateSpo2(String spo2) async {
    this.spo2(spo2);
    List<String> time = _getNowUnixTime();
    await _ref.child('spo2/${time[1]}').update({time[0]: spo2});
  }

  void updateAll(String hr, String spo2) {
    updateHR(hr);
    updateSpo2(spo2);
  }

  List<String> _getNowUnixTime() {
    DateTime now = DateTime.now();
    String nowS = now.millisecondsSinceEpoch.toString();
    DateTime today = DateTime(now.year, now.month, now.day);

    return [nowS, today.millisecondsSinceEpoch.toString()];
  }

  DateTime _toDateTime(String unixTime) =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(unixTime));
}
