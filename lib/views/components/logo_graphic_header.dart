import 'package:flutter/material.dart';

class LogoGraphicHeader extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  const LogoGraphicHeader({
    Key? key,
    required this.radius,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _imageLogo = 'assets/images/default.png';
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
