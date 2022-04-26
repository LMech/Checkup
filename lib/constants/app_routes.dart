import 'package:checkup/views/auth/auth.dart';
import 'package:checkup/views/home/home_ui.dart';
import 'package:checkup/views/profile/about_user_ui.dart';
import 'package:checkup/views/profile/profile_ui.dart';
import 'package:checkup/views/profile/settings_ui.dart';
import 'package:checkup/views/splash_ui.dart';
import 'package:checkup/views/tabbar_ui.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const SplashUI()),
    GetPage(name: '/signin', page: () => SignInUI()),
    GetPage(name: '/signup', page: () => SignUpUI()),
    GetPage(name: '/tabbar', page: () => const TabbarUI()),
    GetPage(name: '/tabbar/home', page: () => const HomeUI()),
    GetPage(name: '/tabbar/profile', page: () => ProfileUI()),
    GetPage(
        name: '/tabbar/profile/about-user', page: () => const AboutUserUI()),
    GetPage(name: '/tabbar/profile/settings', page: () => const SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
  ];
}
