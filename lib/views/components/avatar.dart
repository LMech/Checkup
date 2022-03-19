import 'package:checkup/models/models.dart';
import 'package:checkup/views/components/components.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final double height;
  final double width;
  const Avatar(
    this.user, {
    Key? key,
    required this.radius,
    required this.height,
    required this.width,
  }) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    if (user.photoUrl == '') {
      return LogoGraphicHeader(
        radius: radius,
        width: width,
        height: height,
      );
    }
    return Hero(
      tag: 'User Avatar Image',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          radius: radius,
          child: ClipOval(
            child: Image.network(
              user.photoUrl,
              fit: BoxFit.cover,
              width: width,
              height: height,
            ),
          )),
    );
  }
}
