import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var hr = '-'.obs;

  updateHR(String value) {
    hr(value);
    // hr.value = value;
    debugPrint("here");
    debugPrint(hr.value);
  }
}
