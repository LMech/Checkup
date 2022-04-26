import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constants/constants.dart';
import 'controllers/controllers.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // navigatorObservers: [
      // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      // ],
      debugShowCheckedModeBanner: true,
      defaultTransition: Transition.fade,
      themeMode: ThemeMode.system,
      initialRoute: "/",
      getPages: AppRoutes.routes,
    );
  }
}
