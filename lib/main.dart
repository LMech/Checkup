import 'package:checkup/controllers/auth_controller.dart';
import 'package:checkup/firebase_options.dart';
import 'package:checkup/views/auth/reset_password_ui.dart';
import 'package:checkup/views/auth/sign_in_ui.dart';
import 'package:checkup/views/auth/sign_up_ui.dart';
import 'package:checkup/views/chatbot_ui.dart';
import 'package:checkup/views/connections_ui.dart';
import 'package:checkup/views/home/connect_ui.dart';
import 'package:checkup/views/home/home_ui.dart';
import 'package:checkup/views/profile/profile_ui.dart';
import 'package:checkup/views/splash_ui.dart';
import 'package:checkup/views/tabbar_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      theme: ThemeData(primarySwatch: Colors.indigo),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.teal),
      themeMode: ThemeMode.light,
      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object

  static final routes = [
    // Initial Path
    GetPage(name: '/', page: () => const SplashUI()),

    // /
    GetPage(name: '/signin', page: () => SignInUI()),
    GetPage(name: '/signup', page: () => SignUpUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/tabbar', page: () => const TabbarUI()),

    // /tabbar
    GetPage(name: '/tabbar/home', page: () => HomeUI()),
    GetPage(name: '/tabbar/chat', page: () => const ChatbotUI()),
    GetPage(name: '/tabbar/connections', page: () => ConnectionsUI()),
    GetPage(name: '/tabbar/profile', page: () => ProfileUI()),

    // /tabbar/home
    GetPage(name: '/tabbar/home/connect', page: () => const ConnectUI()),
  ];
}
