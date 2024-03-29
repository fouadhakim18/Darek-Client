// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  const AppIcon(
      {super.key,
      required this.icon,
      this.backgroundColor = const Color(0xFFFCF4E4),
      this.iconColor = const Color(0xFF756D54),
      this.size = 40,
      this.iconSize = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(size / 2)),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
