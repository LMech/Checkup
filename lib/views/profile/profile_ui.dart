import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/controllers/profile_controller.dart';
import 'package:checkup/views/core/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:unicons/unicons.dart';

@immutable
class ProfileUI extends StatelessWidget {
  ProfileUI({Key? key}) : super(key: key);

  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: <Widget>[
                _profileData(),
                const SizedBox(height: 10),
                _listView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileData() {
    final String userName = authController.firestoreUser.value!.name;
    final String email = authController.firestoreUser.value!.email;

    return Column(
      children: [
        // TODO: make a white space component
        const SizedBox(
          height: 8.0,
        ),
        Avatar(
          authController.firestoreUser.value!.photoUrl,
          radius: 110.0,
          height: 50.0,
          width: 50.0,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          userName,
          style: const TextStyle(fontSize: 28.0),
        ),
        const SizedBox(height: 8),
        Text(email),
      ],
    );
  }

  Widget _listView() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Get.theme.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              InkWell(
                child: const ListTile(
                  leading: Icon(UniconsLine.user_circle),
                  trailing: Icon(UniconsLine.angle_right),
                  title: Text('About you'),
                ),
                onTap: () => Logger().e('here'),
              ),
              const InkWell(
                child: ListTile(
                  leading: Icon(UniconsLine.sign_alt),
                  trailing: Icon(UniconsLine.signout),
                  title: Text('Sign out'),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Medical ID container
        Container(
          decoration: BoxDecoration(
            color: Get.theme.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              InkWell(
                child: const ListTile(
                  leading: Icon(UniconsLine.head_side_cough),
                  trailing: Icon(UniconsLine.angle_right),
                  title: Text('Allergies'),
                ),
                onTap: () => Logger().e('here'),
              ),
              const InkWell(
                child: ListTile(
                  leading: Icon(UniconsLine.capsule),
                  trailing: Icon(UniconsLine.angle_right),
                  title: Text('Medcine'),
                ),
              ),
              const InkWell(
                child: ListTile(
                  leading: Icon(UniconsLine.coronavirus),
                  trailing: Icon(UniconsLine.angle_right),
                  title: Text('Diseases'),
                ),
              ),
              const InkWell(
                child: ListTile(
                  leading: Icon(UniconsLine.syringe),
                  trailing: Icon(UniconsLine.angle_right),
                  title: Text('Vaccine'),
                ),
              ),
              const InkWell(
                child: ListTile(
                  leading: Icon(UniconsLine.user_md),
                  trailing: Icon(UniconsLine.angle_right),
                  title: Text('Physician'),
                ),
              ),
              const InkWell(
                child: ListTile(
                  leading: Icon(UniconsLine.wheelchair_alt),
                  trailing: Icon(UniconsLine.angle_right),
                  title: Text('Surgery'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
