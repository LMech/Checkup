import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/controllers/home_controller.dart';
import 'package:checkup/views/components/avatar.dart';
import 'package:checkup/views/components/feature_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  HomeUI({Key? key}) : super(key: key);

  final AuthController authController = AuthController.to;
  final String photoUrl = '';

  Widget _profileData() {
    final String userName = authController.firestoreUser.value!.name;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Hi, $userName',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Let\'s make a checkup',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]),
        GestureDetector(
          child: photoUrl == ''
              ? Avatar(
                  authController.firestoreUser.value?.photoUrl ?? '',
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

  Widget _featuresList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Discover other features',
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
                title: 'Report',
                description: 'Export and share your data',
                onTap: () {},
              ),
              const SizedBox(width: 15),
              FeatureCard(
                color: Get.theme.focusColor,
                icon: CupertinoIcons.waveform_path_ecg,
                title: 'Camera Oximeter',
                description: 'Measure important vital using your phone camera',
                onTap: () {},
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = Get.width;
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                backgroundColor: Get.theme.scaffoldBackgroundColor,
                elevation: 0.0,
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 40.0,
                        color: Get.theme.iconTheme.color,
                      ),
                      onPressed: () {
                        Get.toNamed('/tabbar/home/connect');
                      }),
                ],
              ),
              body: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  children: <Widget>[
                    const SizedBox(height: 35),
                    _profileData(),
                    const SizedBox(height: 35),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            height: 220,
                            width: _screenWidth * .42,
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
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      CupertinoIcons.heart,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Heart Rate',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(
                                  () => Text(controller.hr.value,
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                const Text(
                                  'BPM',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            height: 220,
                            width: _screenWidth * .42,
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
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.bubble_chart_outlined,
                                      color: Colors.blueAccent,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Oxygen\nSaturation',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(
                                  () => Text(controller.spo2.value,
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                const Text(
                                  '%',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                    const SizedBox(height: 35),
                    _featuresList(),
                  ],
                ),
              ),
            ));
  }
}
