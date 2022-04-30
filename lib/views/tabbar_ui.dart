import 'package:checkup/controllers/tabbar_controller.dart';
import 'package:checkup/views/chatbot_ui.dart';
import 'package:checkup/views/components/app_icons.dart';
import 'package:checkup/views/connections_ui.dart';
import 'package:checkup/views/home/home_ui.dart';
import 'package:checkup/views/profile/profile_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabbarUI extends StatelessWidget {
  const TabbarUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabbarController>(
        init: TabbarController(),
        builder: (controller) => Obx(() => (Scaffold(
            body: IndexedStack(
              index: controller.tabIndex.value,
              children: [
                HomeUI(),
                const ChatbotUI(),
                ConnectionsUI(),
                ProfileUI(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              currentIndex: controller.tabIndex.value,
              onTap: controller.changeTabIndex,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: '○',
                ),
                BottomNavigationBarItem(
                  icon: Icon(MyFlutterApp.atouf),
                  label: '○',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt_outlined),
                  label: '○',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_ind_outlined),
                  label: '○',
                ),
              ],
            )))));
  }
}
