import 'package:checkup/constants/text_constants.dart';
import 'package:checkup/controllers/controllers.dart';
import 'package:checkup/views/components/avatar.dart';
import 'package:checkup/views/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/feature_card.dart';

class HomeUI extends StatelessWidget {
  static final AuthController authController = Get.find();
  final String photoUrl = '';
  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('home.title'.tr),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              // TODO: add screen for connecting to the devices
              onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              const SizedBox(height: 35),
              _profileData(),
              const SizedBox(height: 35),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _vitalCard(Icons.bubble_chart_outlined, Colors.blueAccent,
                        "Oxygen Saturation", "%", _screenWidth),
                    _vitalCard(CupertinoIcons.heart, Colors.red, "Heart Rate",
                        "BPM", _screenWidth),
                  ]),
              const SizedBox(height: 35),
              _createFeaturesList(),
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
      ),
    );

    // );
  }

  Widget _profileData() {
    final String userName = authController.firestoreUser.value!.name;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Hi, $userName'.tr,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            TextConstants.checkup,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]),
        GestureDetector(
          child: photoUrl == ''
              ? Avatar(
                  authController.firestoreUser.value!,
                  radius: 25.0,
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
                  radius: 25),
          onTap: () {},
        )
      ]),
    );
  }

  Widget _vitalCard(IconData icon, Color color, String vital, String unit,
      double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 200,
      width: screenWidth * 0.42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Get.theme.cardColor,
        boxShadow: const [
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
                  vital.tr,
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
            unit.tr,
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

  Widget _createFeaturesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            TextConstants.discoverFeatures,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 20),
              FeatureCard(
                color: Get.theme.focusColor,
                icon: CupertinoIcons.rectangle_paperclip,
                title: TextConstants.reportFeatureTitle,
                description: TextConstants.reportFeatureDescription,
                onTap: () {},
              ),
              const SizedBox(width: 15),
              FeatureCard(
                color: Get.theme.focusColor,
                icon: CupertinoIcons.waveform_path_ecg,
                title: TextConstants.oximeterFeatureTitle,
                description: TextConstants.oximeterFeatureDescription,
                onTap: () {},
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}
