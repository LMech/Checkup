import 'package:checkup/controllers/profile_controller.dart';
import 'package:checkup/views/core/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

@immutable
class ProfileUI extends StatelessWidget {
  const ProfileUI({Key? key}) : super(key: key);

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
                _profileData(
                  controller.name,
                  controller.email,
                  controller.photoUrl,
                ),
                const SizedBox(height: 10),
                _listView(controller.signout),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileData(String name, String email, String photoUrl) {
    return Column(
      children: [
        // TODO: make a white space component
        const SizedBox(
          height: 8.0,
        ),
        Avatar(
          photoUrl,
          radius: 110.0,
          height: 50.0,
          width: 50.0,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 28.0),
        ),
        const SizedBox(height: 8),
        Text(email),
      ],
    );
  }

  Widget _listView(Future<void> Function() signout) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Get.theme.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <ListTile>[
              ListTile(
                leading: const Icon(UniconsLine.user_circle),
                trailing: const Icon(UniconsLine.angle_right),
                title: const Text('About you'),
                onTap: () => Get.toNamed('/tabbar/profile/about_you'),
              ),
              ListTile(
                leading: const Icon(UniconsLine.sign_alt),
                trailing: Icon(
                  UniconsLine.signout,
                  color: Get.theme.errorColor,
                ),
                title: const Text('Sign out'),
                onTap: () => signout(),
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
            children: <ListTile>[
              ListTile(
                leading: const Icon(UniconsLine.head_side_cough),
                trailing: const Icon(UniconsLine.angle_right),
                title: const Text('Allergies'),
                onTap: () => Get.toNamed(
                  '/tabbar/profile/medical_item',
                  arguments: 'allergies',
                ),
              ),
              const ListTile(
                leading: Icon(UniconsLine.capsule),
                trailing: Icon(UniconsLine.angle_right),
                title: Text('Medcine'),
              ),
              const ListTile(
                leading: Icon(UniconsLine.coronavirus),
                trailing: Icon(UniconsLine.angle_right),
                title: Text('Diseases'),
              ),
              const ListTile(
                leading: Icon(UniconsLine.syringe),
                trailing: Icon(UniconsLine.angle_right),
                title: Text('Vaccine'),
              ),
              const ListTile(
                leading: Icon(UniconsLine.user_md),
                trailing: Icon(UniconsLine.angle_right),
                title: Text('Physician'),
              ),
              const ListTile(
                leading: Icon(UniconsLine.wheelchair_alt),
                trailing: Icon(UniconsLine.angle_right),
                title: Text('Surgery'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
