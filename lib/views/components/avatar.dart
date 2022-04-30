import 'package:checkup/views/components/logo_graphic_header.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar(
    this.user, {
    Key? key,
    required this.radius,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double radius;
  final String user;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (user == '') {
      return LogoGraphicHeader(
        radius: radius,
      );
    }
    return CircleAvatar(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        radius: radius,
        child: ClipOval(
          child: Image.network(
            user,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        ));
  }
}
