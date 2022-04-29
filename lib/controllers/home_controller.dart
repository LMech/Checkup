import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString hr = '--'.obs;
  RxString spo2 = '--'.obs;

  updateHR(String hr) {
    this.hr(hr);
  }

  updateSpo2(String spo2) {
    this.spo2(spo2);
  }

  updateAll(String hr, String spo2) {
    updateHR(hr);
    updateSpo2(spo2);
  }
}
