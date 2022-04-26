import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/controllers/tabbar_controller.dart';
import 'package:checkup/views/home/home_ui.dart';
import 'package:checkup/views/profile/profile_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'friends/contacts_ui.dart';

class TabbarUI extends StatelessWidget {
  static final tabbarController = Get.put(TabbarController());

  const TabbarUI({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => controller.firestoreUser.value!.uid == null
            ? const SafeArea(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Obx(() => (Scaffold(
                body: SafeArea(
                  child: IndexedStack(
                    index: tabbarController.tabIndex.value,
                    children: [
                      const HomeUI(),
                      ContactsUI(),
                      ProfileUI(),
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
                      icon: CupertinoIcons.person_3_fill,
                      label: 'Contacts',
                    ),
                    _bottomNavigationBarItem(
                      icon: CupertinoIcons.profile_circled,
                      label: 'Profile',
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
