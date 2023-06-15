// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class RatingContainer extends StatelessWidget {
  String pic;
  String userName;
  String ratingDetails;
  double ratingValue;
  RatingContainer({
    Key? key,
    required this.pic,
    required this.userName,
    required this.ratingDetails,
    required this.ratingValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textGrey,
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: pic,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                Image.asset("assets/images/add-pic.png"),
            fit: BoxFit.cover,
            width: 30,
            height: 30,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(userName),
                  Card(
                    color: const Color(0xff34478C),
                    shape: const StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            size: 19,
                            Icons.star,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            ratingValue.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Text(ratingDetails),
            ],
          )
        ],
      ),
    );
  }
}
