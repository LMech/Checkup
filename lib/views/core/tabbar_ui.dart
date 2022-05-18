import 'package:checkup/controllers/tabbar_controller.dart';
import 'package:checkup/views/chatbot_ui.dart';
import 'package:checkup/views/connections/connections_list_ui.dart';
import 'package:checkup/views/home/home_ui.dart';
import 'package:checkup/views/profile/profile_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class TabbarUI extends StatelessWidget {
  const TabbarUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabbarController>(
      init: TabbarController(),
      builder: (controller) => Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.tabIndex.value,
            children: <Widget>[
              const HomeUI(),
              const ChatbotUI(),
              ConnectionsListUI(),
              const ProfileUI(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,
            currentIndex: controller.tabIndex.value,
            onTap: controller.changeTabIndex,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(UniconsLine.home_alt),
                label: '○',
              ),
              BottomNavigationBarItem(
                icon: Icon(UniconsLine.robot),
                label: '○',
              ),
              BottomNavigationBarItem(
                icon: Icon(UniconsLine.users_alt),
                label: '○',
              ),
              BottomNavigationBarItem(
                icon: Icon(UniconsLine.user_square),
                label: '○',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
