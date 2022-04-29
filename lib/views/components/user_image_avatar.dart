import 'package:flutter/material.dart';

class UserImageAvatar extends StatelessWidget {
  const UserImageAvatar({
    Key? key,
    required this.imageUrl,
    required this.onTap,
    this.height = 45.0,
    this.width = 45.0,
  }) : super(key: key);

  final double height;
  final String imageUrl;
  final Function() onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 7.0,
        horizontal: 7.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 0.8,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
        ),
        image: DecorationImage(
          image: imageUrl == '' || imageUrl.isEmpty
              ? const AssetImage('assets/images/icon_user.png') as ImageProvider
              : NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
