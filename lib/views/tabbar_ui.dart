import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/controllers/tabbar_controller.dart';
import 'package:checkup/views/chat_ui.dart';
import 'package:checkup/views/connections/connections_ui.dart';
import 'package:checkup/views/home/home_ui.dart';
import 'package:checkup/views/profile/profile_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      ChatbotUI(),
                      const ConnectionsUI(),
                      ProfileUI(),
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: tabbarController.tabIndex.value,
                  onTap: tabbarController.changeTabIndex,
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.chat_bubble_2),
                      label: 'Atouf',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person_3_fill),
                      label: 'Contacts',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.profile_circled),
                      label: 'Profile',
                    ),
                  ],
                )))));
  }
}
