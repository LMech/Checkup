import 'package:checkup/views/chat_ui.dart';
import 'package:checkup/views/components/components.dart';
import 'package:checkup/views/home_ui.dart';
import 'package:checkup/views/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';

class TabbarUI extends StatelessWidget {
  static final tabbarController = Get.put(TabbarController());

  const TabbarUI({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => controller.firestoreUser.value!.uid == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Obx(() => (Scaffold(
                body: SafeArea(
                  child: IndexedStack(
                    index: tabbarController.tabIndex.value,
                    children: [
                      HomeUI(),
                      ProfileUI(),
                      ChatUi(),
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: tabbarController.tabIndex.value,
                  onTap: tabbarController.changeTabIndex,
                  items: [
                    _bottomNavigationBarItem(
                      icon: CupertinoIcons.home,
                      label: 'Home',
                    ),
                    _bottomNavigationBarItem(
                      icon: CupertinoIcons.profile_circled,
                      label: 'Profile',
                    ),
                    _bottomNavigationBarItem(
                      icon: CupertinoIcons.chat_bubble_text,
                      label: 'chat',
                    ),
                  ],
                )))));
  }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
