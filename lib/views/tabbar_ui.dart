
import 'package:checkup/views/chat_ui.dart';
import 'package:checkup/views/components/components.dart';
//>>>>>>> b8e1392233eb3d5cd9fafe80de584657b88ffcd3
import 'package:checkup/views/home_ui.dart';
import 'package:checkup/views/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import 'friends/contacts.dart';

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
            : Obx(() => (
            Scaffold(
                body: SafeArea(
                  child: IndexedStack(
                    index: tabbarController.tabIndex.value,
                    children: [HomeUI(), ProfileUI(), Contacts()],
                  /*  children: [
                      HomeUI(),
                      ProfileUI(),
                      ChatUi(),
                    ],*/
//>>>>>>> b8e1392233eb3d5cd9fafe80de584657b88ffcd3
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
//<<<<<<< HEAD
                      icon: CupertinoIcons.person_crop_circle_fill_badge_exclam,
                      label: 'Home',
//=======
//>>>>>>> b8e1392233eb3d5cd9fafe80de584657b88ffcd3
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
