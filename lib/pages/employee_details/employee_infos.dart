// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servili_client/model/report.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../../model/worker_details.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/button.dart';
import '../../widgets/expandable_text.dart';
import 'employee_ratings.dart';

class EmployeeInfos extends StatefulWidget {
  WorkerDetails worker;
  bool isFav;

  EmployeeInfos({
    Key? key,
    required this.worker,
    required this.isFav,
  }) : super(key: key);

  @override
  State<EmployeeInfos> createState() => _EmployeeInfosState();
}

class _EmployeeInfosState extends State<EmployeeInfos> {
  final TextEditingController _reportController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        BigText(
                          text: widget.worker.name,
                          size: 23.sp,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        widget.worker.isVerified
                            ? const Icon(
                                Icons.verified_rounded,
                                color: AppColors.mainBlue,
                              )
                            : const SizedBox()
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        toggleFavorite(widget.worker.id!);
                      },
                      child: Icon(
                        widget.isFav
                            ? Icons.favorite_rounded
                            : Icons.favorite_border,
                        color: AppColors.mainBlue,
                        size: 33,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                BigText(
                  text: widget.worker.service,
                  color: AppColors.mainBlue,
                  size: 20.sp,
                ),
                const SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: AppColors.mainBlue,
                            size: 21,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Flexible(
                            child: Text(
                              widget.worker.wilaya ?? "unknown",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: FloatingActionButton(
                            heroTag: const Text("btn2"),
                            onPressed: () {
                              // ignore: deprecated_member_use
                              launch('tel:+${widget.worker.phone!}');
                            },
                            elevation: 0,
                            backgroundColor: Colors.white,
                            shape: const StadiumBorder(
                                side: BorderSide(color: AppColors.mainBlue)),
                            child: const Icon(
                              Icons.phone,
                              color: AppColors.mainBlue,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: FloatingActionButton(
                            heroTag: const Text("btn1"),
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  barrierColor:
                                      const Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.86),
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return FractionallySizedBox(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 245, 245, 245),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30))),
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      height: 4,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xffD0D0D0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      13)),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  Text(
                                                    "Report " +
                                                        widget.worker.name +
                                                        " ?",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color:
                                                                  Colors.grey)),
                                                    ),
                                                    child: TextFormField(
                                                      maxLines:
                                                          null, // set to null to allow multiple lines
                                                      controller:
                                                          _reportController,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: "Add details",
                                                        hintStyle: TextStyle(
                                                            fontSize: 13),
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 45),
                                                  Button(
                                                    text: "Confirm report",
                                                    clicked: () {
                                                      _addReport();
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            elevation: 0,
                            backgroundColor: Colors.white,
                            shape: const StadiumBorder(
                                side: BorderSide(color: AppColors.mainBlue)),
                            child: const Icon(
                              Icons.report_sharp,
                              color: AppColors.mainBlue,
                              size: 22,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        dividerColor: AppColors.mainBlue,
                        indicatorColor: AppColors.mainBlue,
                        labelColor: AppColors.mainBlue,
                        tabs: [
                          Tab(
                            text: "About",
                          ),
                          Tab(
                            text: "Ratings",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 10),
                              child: ExpandableText(
                                  text: widget.worker.about!,
                                  textHeight:
                                      MediaQuery.of(context).size.height /
                                          5.63),
                            ),
                            EmployeeRatings(
                              employeeId: widget.worker.id!,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> isFavorite(String employeeId) async {
    final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance
        .collection('clients')
        .doc(user!.uid)
        .collection('favorites')
        .doc(employeeId)
        .get();
    return doc.exists;
  }

  Future<void> toggleFavorite(String employeeId) async {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    final user = FirebaseAuth.instance.currentUser;
    final isCurrentlyFavorite = await isFavorite(employeeId);
    if (isCurrentlyFavorite) {
      await FirebaseFirestore.instance
          .collection('clients')
          .doc(user!.uid)
          .collection('favorites')
          .doc(employeeId)
          .delete();
      setState(() {
        widget.isFav = false;
      });
      Navigator.pop(context, true);

      showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: 'Deleted from favorite',
          ));
    } else {
      addToFavorites(widget.worker);
      setState(() {
        widget.isFav = true;
      });
      Navigator.pop(context, true);

      showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Added to favorite',
          ));
    }
  }

  Future<void> addToFavorites(WorkerDetails worker) async {
    final user = FirebaseAuth.instance.currentUser;
    final favoritesRef = FirebaseFirestore.instance
        .collection('clients')
        .doc(user!.uid)
        .collection('favorites');

    // Add a new document to the "favorites" collection with the employee's ID
    await favoritesRef.doc(worker.id).set({
      'Id': worker.id,
      'Name': worker.name,
      'Wilaya': worker.wilaya,
      'Service': worker.service,
      'Email': worker.email,
      'Phone': worker.phone,
      'AverageRating': worker.averageRating,
      'Pic': worker.pic,
      'About': worker.about,
      'IsVerified': worker.isVerified
    });
  }

  Future<void> _addReport() async {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    final id = DateTime.now().toString();

    final report = Report(
      id: id,
      employeeId: widget.worker.id!,
      details: _reportController.text.trim(),
    );

    try {
      await FirebaseFirestore.instance
          .collection('reports')
          .doc(id)
          .set(report.toJson());
      Navigator.pop(context, true);

      showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Admin will receive your report',
          ));
    } catch (e) {}
  }
}
