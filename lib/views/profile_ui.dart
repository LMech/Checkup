import 'package:checkup/controllers/controllers.dart';
import 'package:checkup/views/components/components.dart';
import 'package:checkup/views/components/profile/about_user_ui.dart';
import 'package:checkup/views/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUI extends StatelessWidget {
  final AuthController authController = AuthController.to;

  ProfileUI({Key? key}) : super(key: key);

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
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: <Widget>[
            Avatar(authController.firestoreUser.value!,
                radius: 80, height: 500, width: 500),
            // _aboutYou(),
            ElevatedButton(
                onPressed: () {
                  Get.to(AboutUserUI());
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        "About User",
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18.0,
                      ),
                    ]))
          ]),
        )));
  }
}
