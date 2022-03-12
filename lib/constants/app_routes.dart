import 'package:checkup/views/auth/auth.dart';
import 'package:checkup/views/home_ui.dart';
import 'package:checkup/views/ui.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashUI()),
    GetPage(name: '/signin', page: () => SignInUI()),
    GetPage(name: '/signup', page: () => SignUpUI()),
    GetPage(name: '/tabbar', page: () => TabbarUI()),
    GetPage(name: '/tabbar/home', page: () => HomeUI()),
    GetPage(name: '/tabbar/profile', page: () => ProfileUI()),
    GetPage(name: '/tabbar/profile/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
  ];
}
