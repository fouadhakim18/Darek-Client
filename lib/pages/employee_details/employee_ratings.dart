// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../utils/colors.dart';
import '../../utils/user_data.dart';

// ignore: must_be_immutable
class EmployeeRatings extends StatefulWidget {
  String employeeId;

  EmployeeRatings({Key? key, required this.employeeId}) : super(key: key);

  @override
  State<EmployeeRatings> createState() => _EmployeeRatingsState();
}

class _EmployeeRatingsState extends State<EmployeeRatings> {
  String? pic;

  Future<String> _loadPic() async {
    final userData = await UserData().getUserData();
    pic = userData.get("Pic");
    return pic!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ratings')
          .where('employeeId', isEqualTo: widget.employeeId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("error"),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("Empty"),
          );
        }
        return AnimationLimiter(
          child: Container(
            margin: const EdgeInsets.only(bottom: 400),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot rating = snapshot.data!.docs[index];
                print(rating['ratingDetails']);
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: ScaleAnimation(
                        duration: const Duration(milliseconds: 800),
                        child: FadeInAnimation(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: const Color(0xfff5f5f5),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 5,
                                            right: 15),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                                color: AppColors.lightBlue,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: CachedNetworkImage(
                                                imageUrl: rating['userPic'],
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset("assets/images/add-pic.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  rating['userName'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                color: const Color(0xff34478C),
                                                shape: const StadiumBorder(),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Icon(
                                                        size: 17,
                                                        Icons.star,
                                                        color: Colors.white,
                                                      ),
                                                      const SizedBox(
                                                        width: 7,
                                                      ),
                                                      Text(
                                                        rating['ratingValue']
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            rating['ratingDetails'],
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                )))));
              },
            ),
          ),
        );
      },
    );
  }
}
