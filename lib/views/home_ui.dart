import 'package:checkup/views/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home.title'.tr),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Get.to(SettingsUI());
              }),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // Avatar(controller.firestoreUser.value!),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _vitalCard(CupertinoIcons.add, Colors.amber,
                            "Heart Rate", "BPM", context),
                        _vitalCard(CupertinoIcons.add, Colors.amber,
                            "Heart Rate", "BPM", context),
                      ])
                  // FormVerticalSpace(),
                  // Text(
                  //     'home.uidLabel'.tr +
                  //         ': ' +
                  //         controller.firestoreUser.value!.uid,
                  //     style: TextStyle(fontSize: 16)),
                  // FormVerticalSpace(),
                  // Text(
                  //     'home.nameLabel'.tr +
                  //         ': ' +
                  //         controller.firestoreUser.value!.name,
                  //     style: TextStyle(fontSize: 16)),
                  // FormVerticalSpace(),
                  // Text(
                  //     'home.emailLabel'.tr +
                  //         ': ' +
                  //         controller.firestoreUser.value!.email,
                  //     style: TextStyle(fontSize: 16)),
                  // FormVerticalSpace(),
                  // Text(
                  //     'home.adminUserLabel'.tr +
                  //         ': ' +
                  //         controller.admin.value.toString(),
                  //     style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // );
  }

  _vitalCard(IconData icon, Color color, String vital, String unit,
      BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(15),
      height: 200,
      width: screenWidth * 0.42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Get.theme.cardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  vital,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "--",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            unit,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
