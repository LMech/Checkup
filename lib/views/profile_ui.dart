import 'package:checkup/controllers/controllers.dart';
import 'package:checkup/views/components/components.dart';
import 'package:checkup/views/settings_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUI extends StatelessWidget {
  static final AuthController authController = Get.find();

  const ProfileUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          actions: [
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Get.to(() => SettingsUI());
                }),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Avatar(authController.firestoreUser.value!,
                radius: 20, height: 5000, width: 500)
          ],
        )));
  }
}
