import 'package:checkup/controllers/bluetooth_controller.dart';
import 'package:checkup/controllers/google_fit_controller.dart';
import 'package:checkup/views/auth/reset_password_ui.dart';
import 'package:checkup/views/auth/sign_in_ui.dart';
import 'package:checkup/views/auth/sign_up_ui.dart';
import 'package:checkup/views/chatbot_ui.dart';
import 'package:checkup/views/connections/connection_ui.dart';
import 'package:checkup/views/connections/connections_list_ui.dart';
import 'package:checkup/views/core/splash_ui.dart';
import 'package:checkup/views/core/tabbar_ui.dart';
import 'package:checkup/views/home/bluetooth_devices_ui.dart';
import 'package:checkup/views/home/home_ui.dart';
import 'package:checkup/views/profile/about_you_ui.dart';
import 'package:checkup/views/profile/profile_ui.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object

  static final routes = [
    // Initial Path
    GetPage(name: '/', page: () => const SplashUI()),

    // /
    GetPage(name: '/signin', page: () => SignInUI()),
    GetPage(name: '/signup', page: () => SignUpUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(
      name: '/tabbar',
      page: () => const TabbarUI(),
      binding: HomeBinding(),
    ),

    // /tabbar
    GetPage(
      name: '/tabbar/home',
      page: () => const HomeUI(),
    ),
    GetPage(name: '/tabbar/chat', page: () => const ChatbotUI()),
    GetPage(name: '/tabbar/connections_list', page: () => ConnectionsListUI()),
    GetPage(name: '/tabbar/profile', page: () => ProfileUI()),

    // /tabbar/home/bluetooth_search
    GetPage(
      name: '/tabbar/home/bluetooth_search',
      page: () => BluetoothDevicesUI(),
    ),

    // /tabbar/connections_list/connection
    GetPage(
      name: '/tabbar/connections_list/connection',
      page: () => const ConnectionUI(),
    ),

    // /tabbar/profile/about_you
    GetPage(
      name: '/tabbar/profile/about_you',
      page: () => const AbouYouUI(),
    ),
  ];
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BluetoothController>(() => BluetoothController());
    Get.lazyPut<GoogleFitController>(() => GoogleFitController());
  }
}
