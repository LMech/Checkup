import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  final bool hasNavigation;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ).copyWith(
        bottom: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade300,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 25,
          ),
          const SizedBox(width: 15),
          Text(
            text,
          ),
          const Spacer(),
          if (hasNavigation)
            const Icon(
              Icons.arrow_back_ios,
              size: 25,
            ),
        ],
      ),
    );
  }
}
