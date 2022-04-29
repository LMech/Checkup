import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/views/auth/update_profile_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsUI extends StatelessWidget {
  const SettingsUI({Key? key}) : super(key: key);

  Widget _buildLayoutSection(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
            title: Text('settings.updateProfile'.tr),
            trailing: ElevatedButton(
              onPressed: () async {
                Get.to(() => UpdateProfileUI());
              },
              child: Text(
                'settings.updateProfile'.tr,
              ),
            )),
        ListTile(
          title: Text('settings.signOut'.tr),
          trailing: ElevatedButton(
            onPressed: () {
              AuthController.to.signOut();
            },
            child: Text(
              'settings.signOut'.tr,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr),
      ),
      body: _buildLayoutSection(context),
    );
  }
}
