import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabbarController extends GetxController {
  RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
    debugPrint(index.toString());
  }
}
