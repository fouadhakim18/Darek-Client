import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../model/worker_details.dart';
import '../../utils/colors.dart';
import '../employee_details/employee_details_screen.dart';

class Swipetodelete extends StatefulWidget {
  const Swipetodelete({super.key});

  @override
  State<Swipetodelete> createState() => _SwipetodeleteState();
}

class _SwipetodeleteState extends State<Swipetodelete> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final favoritesRef = FirebaseFirestore.instance
        .collection('clients')
        .doc(user!.uid)
        .collection('favorites');
    return StreamBuilder<QuerySnapshot>(
      stream: favoritesRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final favoritesDocs = snapshot.data!.docs;

        if (favoritesDocs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/not-found.png'),
                Text(
                  "Ups!... no results found",
                  style:
                      TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        }

        return Expanded(
            child: AnimationLimiter(
          child: ListView.builder(
            itemCount: favoritesDocs.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: ScaleAnimation(
                      duration: const Duration(milliseconds: 800),
                      child: FadeInAnimation(
                          child: Dismissible(
                        background: Container(
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        key: ValueKey<Object>(favoritesDocs[index]),
                        onDismissed: (DismissDirection direction) {
                          _deleteFavorite(favoritesDocs[index].id);
                        },
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                () => EmployeeDetails(
                                      worker: WorkerDetails(
                                          id: favoritesDocs[index].id,
                                          name: favoritesDocs[index]['Name'],
                                          wilaya: favoritesDocs[index]
                                              ['Wilaya'],
                                          service: favoritesDocs[index]
                                              ['Service'],
                                          averageRating: favoritesDocs[index]
                                              ['AverageRating'],
                                          email: favoritesDocs[index]['Email'],
                                          phone: favoritesDocs[index]['Phone'],
                                          pic: favoritesDocs[index]['Pic'],
                                          about: favoritesDocs[index]['About'],
                                          isVerified: favoritesDocs[index]
                                              ['IsVerified']),
                                    ),
                                transition: Transition.fadeIn);
                          },
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
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl: favoritesDocs[index]['Pic'],
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/add-pic.png"),
                                          fit: BoxFit.cover,
                                          width: 70,
                                          height: 70,
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
                                              child: Row(
                                                children: [
                                                  Text(
                                                    favoritesDocs[index]
                                                            ['Name'] ??
                                                        "unknown",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  favoritesDocs[index]
                                                          ['IsVerified']
                                                      ? const Icon(
                                                          Icons
                                                              .verified_rounded,
                                                          color: AppColors
                                                              .mainBlue,
                                                        )
                                                      : const SizedBox()
                                                ],
                                              ),
                                            ),
                                            Card(
                                              color: const Color(0xff34478C),
                                              shape: const StadiumBorder(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                      favoritesDocs[index]
                                                              ['AverageRating']
                                                          .toStringAsFixed(1),
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
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          favoritesDocs[index]['Service'] ??
                                              "unknown",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                favoritesDocs[index]
                                                        ['Wilaya'] ??
                                                    "unknown",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              )),
                        ),
                      ))));
            },
          ),
        ));
      },
    );
  }

  void _deleteFavorite(String employeeId) async {
    final user = FirebaseAuth.instance.currentUser;
    final favoritesRef = FirebaseFirestore.instance
        .collection('clients')
        .doc(user!.uid)
        .collection('favorites');
    try {
      await favoritesRef.doc(employeeId).delete();
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting favorite: $e');
    }
  }
}
