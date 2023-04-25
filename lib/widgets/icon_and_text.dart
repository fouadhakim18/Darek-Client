// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:onboading/widgets/small_text.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndText(
      {super.key,
      required this.icon,
      required this.text,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        icon,
        color: iconColor,
        size: 23,
      ),
      const SizedBox(
        width: 4,
      ),
      SmallText(
        text: text,
      )
    ]);
  }
}
