import 'package:checkup/views/core/components/avatar.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({
    Key? key,
    required this.photoUrl,
    required this.name,
    required this.email,
  }) : super(key: key);

  String photoUrl;
  String name;
  String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // TODO: make a white space component
        const SizedBox(
          height: 8.0,
        ),
        Avatar(
          photoUrl,
          radius: 50.0,
          height: 50.0,
          width: 50.0,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 28.0),
        ),
        const SizedBox(height: 8),
        Text(email),
      ],
    );
  }
}
