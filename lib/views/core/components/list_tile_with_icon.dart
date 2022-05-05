import 'package:flutter/material.dart';

class ListTileWithIcon extends StatelessWidget {
  const ListTileWithIcon({
    Key? key,
    required this.title,
    this.color = Colors.transparent,
    required this.icon,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final void Function() onTap;
  final double size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
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
