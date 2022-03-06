import 'package:checkup/screens/onboarding/page/onboarding_page.dart';
import 'package:checkup/screens/tab_bar/page/tab_bar_page.dart';
import 'package:fireauth/fireauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/const/color_constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckUp',
      theme: ThemeData(
        textTheme: const TextTheme(
            bodyText1: TextStyle(color: ColorConstants.textColor)),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isLoggedIn ? const TabBarPage() : const OnboardingPage(),
    );
  }
}
