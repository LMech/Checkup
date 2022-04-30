import 'package:flutter/material.dart';

class LogoGraphicHeader extends StatelessWidget {
  const LogoGraphicHeader({
    Key? key,
    required this.radius,
  }) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    String _imageLogo = 'assets/images/default.png';
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: radius,
      backgroundImage: Image.asset(
        _imageLogo,
        fit: BoxFit.cover,
      ).image,
    );
  }
}
