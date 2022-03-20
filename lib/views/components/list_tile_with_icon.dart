import 'package:flutter/material.dart';

class ListTileWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final double size;
  final void Function() onTap;

  const ListTileWithIcon(
      {Key? key,
      required this.title,
      required this.icon,
      required this.size,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: size,
          ),
        ),
        trailing: Icon(
          icon,
          size: size,
        ),
        onTap: onTap,
      ),
    );
  }
}
