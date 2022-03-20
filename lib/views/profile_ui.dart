import 'package:checkup/controllers/controllers.dart';
import 'package:checkup/controllers/profile_controller.dart';
import 'package:checkup/views/components/components.dart';
import 'package:checkup/views/components/profile/about_user_ui.dart';
import 'package:checkup/views/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final ProfileController profileController = Get.put(ProfileController());

  ProfileUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var photoUrl = '';
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
            GestureDetector(
              child: photoUrl == ''
                  ? Avatar(
                      authController.firestoreUser.value!,
                      radius: 50.0,
                      height: 120,
                      width: 200,
                    )
                  : CircleAvatar(
                      child: ClipOval(
                          child: FadeInImage.assetNetwork(
                              placeholder: '',
                              image: photoUrl,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 120)),
                      radius: 50),
              onTap: () {},
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => AboutUserUI());
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
