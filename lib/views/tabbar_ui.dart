import 'package:checkup/controllers/tabbar_controller.dart';
import 'package:checkup/views/chat_ui.dart';
import 'package:checkup/views/connections/connections_ui.dart';
import 'package:checkup/views/home/home_ui.dart';
import 'package:checkup/views/profile/profile_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabbarUI extends StatelessWidget {
  const TabbarUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabbarController>(
        init: TabbarController(),
        builder: (controller) => Obx(() => (Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: controller.tabIndex.value,
                children: [
                  HomeUI(),
                  const ChatbotUI(),
                  ConnectionsUI(),
                  ProfileUI(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.tabIndex.value,
              onTap: controller.changeTabIndex,
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
