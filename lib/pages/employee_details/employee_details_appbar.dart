// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class EmployeeDetailsAppbar extends StatefulWidget {
  String? pic;

  EmployeeDetailsAppbar({
    Key? key,
    this.pic,
  }) : super(key: key);

  @override
  State<EmployeeDetailsAppbar> createState() => _EmployeeDetailsAppbarState();
}

class _EmployeeDetailsAppbarState extends State<EmployeeDetailsAppbar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppColors.mainBlue,
          child: InkWell(
            onTap: () {},
            child: CachedNetworkImage(
              imageUrl: widget.pic!,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const SizedBox(),
              fit: BoxFit.cover,
              width: 30,
              height: 30,
            ),
          ),
        ),
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground
        ],
      ),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            alignment: Alignment.center,
            height: 32,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              color: Colors.white,
            ),
            child: Container(
              width: 80,
              height: 3,
              decoration: BoxDecoration(
                  color: const Color(0xFF6F6D6D),
                  borderRadius: BorderRadius.circular(100)),
            ),
          )),
      leadingWidth: 80,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.only(left: 8, top: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                width: 2,
                height: 2,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black54,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
