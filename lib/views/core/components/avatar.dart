import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar(
    this.photoUrl, {
    Key? key,
    required this.radius,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final String photoUrl;
  final double radius;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          image: photoUrl,
          placeholder: 'assets/images/default.png',
        ),
      ),
    );
  }
}
