// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:onboading/widgets/small_text.dart';
import '../utils/colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final double textHeight;
  const ExpandableText(
      {super.key, required this.text, required this.textHeight});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > widget.textHeight) {
      firstHalf = widget.text.substring(0, widget.textHeight.toInt());
      secondHalf = widget.text
          .substring(widget.textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf == ""
          ? SmallText(color: AppColors.textGrey, text: firstHalf)
          : Column(
              children: [
                SmallText(
                    size: 14,
                    height: 1.6,
                    text: hiddenText
                        ? ("$firstHalf...")
                        : (firstHalf + secondHalf)),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText ? "Show more" : "Show less",
                        color: AppColors.mainBlue,
                        size: 14,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: AppColors.mainBlue,
                        size: 21,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
