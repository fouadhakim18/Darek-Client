// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:servili_client/model/worker_details.dart';
import 'package:servili_client/pages/employee_details/employee_details_screen.dart';
import 'package:servili_client/utils/colors.dart';

import '../../utils/user_data.dart';

// ignore: must_be_immutable
class WorkersList extends StatefulWidget {
  String service;

  // for set filters
  String? country;
  String? state;
  String? city;
  num? rating;
  WorkersList(
      {Key? key,
      required this.service,
      this.country,
      this.state,
      this.city,
      this.rating})
      : super(key: key);

  @override
  State<WorkersList> createState() => _WorkersListState();
}

class _WorkersListState extends State<WorkersList> {
  String? pic;

  String searchText = "";
  Future<String> _loadWilaya() async {
    final userData = await UserData().getUserData();
    return userData.get('State');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CupertinoSearchTextField(
            onChanged: (text) {
              setState(() {
                searchText = text;
              });
            },
            itemSize: 24,
            placeholderStyle: TextStyle(
                fontSize: 19.sp,
                color: const Color.fromARGB(255, 151, 150, 150)),
            backgroundColor: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(30),
            padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Icon(
                Icons.search,
                size: 32.sp,
              ),
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: queryEmployees(widget.service, widget.country, widget.state,
                  widget.city, widget.rating)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Center(
                child: Image.asset('assets/images/not-found.png'),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Expanded(
                child: Column(
                  children: [
                    Image.asset('assets/images/not-found.png'),
                    Text(
                      "Ups!... no employees found",
                      style: TextStyle(
                          fontSize: 19.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            }
            final List<DocumentSnapshot> allEmployees = snapshot.data!.docs;

            return FutureBuilder(
                future: _loadWilaya(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: SizedBox());
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final List<DocumentSnapshot> employeesSameWilaya = [];
                  final List<DocumentSnapshot> remainingEmployees = [];

                  for (final employee in allEmployees) {
                    if (employee['State'] == snapshot.data) {
                      employeesSameWilaya.add(employee);
                    } else {
                      remainingEmployees.add(employee);
                    }
                  }
                  employeesSameWilaya.sort(compareVerified);
                  remainingEmployees.sort(compareVerified);
                  List<DocumentSnapshot> combinedList =
                      employeesSameWilaya + remainingEmployees;
                  combinedList = combinedList.where((employee) {
                    return employee['Name']
                            .toLowerCase()
                            .contains(searchText.toLowerCase()) ||
                        employee['State']
                            .toLowerCase()
                            .contains(searchText.toLowerCase());
                  }).toList();
                  return Expanded(
                      child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: combinedList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot employee = combinedList[index];
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            child: ScaleAnimation(
                                duration: const Duration(milliseconds: 800),
                                child: FadeInAnimation(
                                    child: InkWell(
                                  onTap: () {
                                    Get.to(
                                        () => EmployeeDetails(
                                              worker: WorkerDetails(
                                                  id: employee.id,
                                                  name: employee['Name'],
                                                  wilaya: employee['State'],
                                                  service: employee['Service'],
                                                  averageRating:
                                                      employee['AverageRating'],
                                                  email: employee['Email'],
                                                  phone: employee['Phone'],
                                                  pic: employee['Pic'],
                                                  about:
                                                      employee['AboutEmployee'],
                                                  isVerified:
                                                      employee['IsVerified']),
                                            ),
                                        transition: Transition.fadeIn);
                                  },
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
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
                                                  imageUrl: employee['Pic'],
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  errorWidget: (context, url,
                                                          error) =>
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            employee['Name'] ??
                                                                "unknown",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16.sp,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          employee['IsVerified']
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
                                                      color: const Color(
                                                          0xff34478C),
                                                      shape:
                                                          const StadiumBorder(),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
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
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            const SizedBox(
                                                              width: 7,
                                                            ),
                                                            Text(
                                                              employee[
                                                                      'AverageRating']
                                                                  .toStringAsFixed(
                                                                      1),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                                  employee['Service'] ??
                                                      "unknown",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        employee['State'] ??
                                                            "unknown",
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                ))));
                      },
                    ),
                  ));
                });
          },
        ),
      ],
    );
  }

  Query<Map<String, dynamic>> queryEmployees(String service, String? country,
      String? state, String? city, num? rating) {
    final emplRef = FirebaseFirestore.instance.collection('employees');
    var query = emplRef.where('Service', isEqualTo: service);

    if (country != null) {
      query = query.where('Country', isEqualTo: country);
    }
    if (state != null) {
      query = query.where('State', isEqualTo: state);
    }
    if (city != null) {
      query = query.where('City', isEqualTo: city);
    }
    if (rating != null) {
      query = query.where('AverageRating', isGreaterThanOrEqualTo: rating);
    }
    return query;
  }

  // Custom comparator function
  int compareVerified(DocumentSnapshot a, DocumentSnapshot b) {
    bool isVerifiedA =
        a['IsVerified'] ?? false; // Assuming 'isVerified' is a boolean field
    bool isVerifiedB = b['IsVerified'] ?? false;

    if (isVerifiedA == isVerifiedB) {
      return 0; // Elements have the same isVerified status, maintain the original order
    } else if (isVerifiedA) {
      return -1; // a comes before b (a is verified, b is not)
    } else {
      return 1; // b comes before a (b is verified, a is not)
    }
  }
}
