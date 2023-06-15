// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../main.dart';
import '../../model/booking.dart';
import '../../utils/colors.dart';
import 'add_rate.dart';

// this is for both completed and canceled since only booking state color will change
class CompletedBookingContainer extends StatefulWidget {
  Booking booking;
  String userName;
  String userLocation;
  String userPic;
  String userPhone;
  BuildContext ctx;
  String employeeId;

  CompletedBookingContainer({
    Key? key,
    required this.booking,
    required this.userName,
    required this.userLocation,
    required this.userPic,
    required this.userPhone,
    required this.ctx,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<CompletedBookingContainer> createState() =>
      _CompletedBookingContainerState();
}

class _CompletedBookingContainerState extends State<CompletedBookingContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSize(
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 4, spreadRadius: 2)
                ]),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                      title: Text(
                        widget.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(widget.userLocation == ""
                          ? "Unknown"
                          : widget.userLocation),
                      trailing: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.userPic,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                             Image.asset("assets/images/add-pic.png"),
                          fit: BoxFit.cover,
                          width: 55,
                          height: 55,
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      thickness: 1,
                      height: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.black54,
                            size: 22.sp,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            widget.booking.date,
                            style: TextStyle(fontSize: 13.sp),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            color: Colors.black54,
                            size: 22.sp,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(widget.booking.time,
                              style: TextStyle(fontSize: 13.sp)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: widget.booking.status == "Completed"
                                    ? Colors.green
                                    : AppColors.red,
                                shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            widget.booking.status,
                            style: TextStyle(
                                color: widget.booking.status == "Completed"
                                    ? Colors.green
                                    : AppColors.red,
                                fontSize: 13.sp),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _delete(widget.booking.id, widget.ctx);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Delete",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          widget.booking.status == "Completed"
                              ? Expanded(
                                  child: InkWell(
                                    onTap: () {
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
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(30),
                                                            topRight:
                                                                Radius.circular(
                                                                    30))),
                                                child: Addrate(
                                                  employeeId: widget.employeeId,
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                          color: AppColors.secBlue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.star_rate_rounded,
                                            color: Colors.white,
                                            size: 26,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Rate",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  isExpanded
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 9.0, right: 9, top: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Note :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.mainBlue),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(widget.booking.moreDetails == ""
                                  ? "Not given"
                                  : widget.booking.moreDetails),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Location :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.mainBlue),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(widget.booking.locationUser == ""
                                  ? "Not given"
                                  : widget.booking.locationUser),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Phone :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.mainBlue),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(widget.userPhone),
                              const SizedBox(
                                height: 7,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Icon(
                              isExpanded
                                  ? Icons.arrow_upward_sharp
                                  : Icons.arrow_downward_sharp,
                              size: 25,
                              color: AppColors.mainBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _delete(String? id, BuildContext ctx) async {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(ctx, true);
      showTopSnackBar(
          Overlay.of(ctx),
          const CustomSnackBar.error(
            message: 'Booking deleted',
          ));
      await FirebaseFirestore.instance.collection("bookings").doc(id).delete();
    } catch (e) {
      print(e);
      // Navigator.pop(context, true);

      showTopSnackBar(
          Overlay.of(ctx),
          const CustomSnackBar.error(
            message: 'Booking non deleted',
          ));
    }
  }
}
