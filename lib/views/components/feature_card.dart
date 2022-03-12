import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String description;
  final Function() onTap;
  final double iconSize;

  const FeatureCard({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.iconSize = 24,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          top: 10,
          right: 12,
        ),
        height: 160,
        width: screenWidth * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Icon(
              icon,
              size: iconSize,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
