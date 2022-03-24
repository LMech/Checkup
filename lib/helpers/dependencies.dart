import 'package:get/get.dart';
import '../controllers/add_friends_controll.dart';
import '../controllers/auth_controller.dart';
import '../controllers/friends_controll.dart';
import '../controllers/get_user_map_controller.dart';
import '../controllers/language_controller.dart';
import '../controllers/theme_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ThemeController());

    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => AddFriendController());
    Get.lazyPut(() => friendsControll());
    Get.lazyPut(() => GetUserMap());


  }
}
