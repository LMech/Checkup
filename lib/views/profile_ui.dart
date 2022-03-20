import 'package:checkup/controllers/controllers.dart';
import 'package:checkup/controllers/profile_controller.dart';
import 'package:checkup/views/components/components.dart';
import 'package:checkup/views/components/list_tile_with_icon.dart';
import 'package:checkup/views/components/profile/about_user_ui.dart';
import 'package:checkup/views/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final ProfileController profileController = Get.put(ProfileController());
  var photoUrl = '';

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
            _profileData(),
            SizedBox(height: 10),
            _listView(),
          ]),
        )));
  }

  _profileData() {
    final String userName = authController.firestoreUser.value!.name;
    final String email = authController.firestoreUser.value!.email;

    return Column(
      children: [
        SizedBox(height: 10),
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
        SizedBox(height: 10),
        Text(
          "$userName",
          style: TextStyle(fontSize: 28.0),
        ),
        SizedBox(height: 5),
        Text("$email"),
      ],
    );
  }

  _listView() {
    return Expanded(
      child: ListView(children: [
        ListTileWithIcon(
          title: "About Me",
          icon: Icons.arrow_forward_ios_outlined,
          size: 20.0,
          onTap: () => Get.to(() => AboutUserUI()),
        ),
        ListTileWithIcon(
          title: "Medical Bracelet",
          icon: Icons.arrow_forward_ios_outlined,
          size: 20.0,
          onTap: () => Get.to(() => AboutUserUI()),
        )
      ]),
    );
  }
}
