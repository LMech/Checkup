import 'package:checkup/controllers/controllers.dart';
import 'package:flutter/material.dart';

class LogoGraphicHeader extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  LogoGraphicHeader({
    Key? key,
    required this.radius,
    required this.width,
    required this.height,
  }) : super(key: key);
  final ThemeController themeController = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    String _imageLogo = 'assets/images/default.png';
    if (themeController.isDarkModeOn == true) {
      _imageLogo = 'assets/images/defaultDark.png';
    }
    return Hero(
      tag: 'App Logo',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
          radius: radius,
          child: ClipOval(
            child: Image.asset(
              _imageLogo,
              fit: BoxFit.cover,
              width: width,
              height: height,
            ),
          )),
    );
  }
}
