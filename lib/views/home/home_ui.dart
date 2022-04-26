import 'package:checkup/constants/text_constants.dart';
import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/controllers/home_controller.dart';
import 'package:checkup/views/auth/connect_ui.dart';
import 'package:checkup/views/components/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/feature_card.dart';

class HomeUI extends StatefulWidget {
  static final AuthController authController = Get.find();

  const HomeUI({Key? key}) : super(key: key);

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  HomeController homeController = Get.put(HomeController());

  final String photoUrl = '';

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Get.to(() => const ConnectUI());
              }),
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                            "Heart Rate",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => Text(homeController.hr.string,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      const Text(
                        "BPM",
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
                            "Oxygen\nSaturation",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => Text(homeController.hr.value,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      const Text(
                        "%",
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
      ),
    );

    // );
  }

  Widget _profileData() {
    final String userName = HomeUI.authController.firestoreUser.value!.name;

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
                  HomeUI.authController.firestoreUser.value!,
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
