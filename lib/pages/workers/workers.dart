import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../home/home.dart';
import 'workers_list.dart';

// ignore: must_be_immutable
class WorkersScreen extends StatefulWidget {
  String service;
  String? country;
  String? state;
  String? city;
  num? rating;
  WorkersScreen(
      {Key? key,
      required this.service,
      this.country,
      this.state,
      this.city,
      this.rating})
      : super(key: key);

  @override
  State<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black,
            onPressed: () => Get.to(() => const HomeScreen(),
                transition: Transition.fadeIn)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Workers',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 21.sp,
          ),
        ),
      ),
      body: WorkersList(
        service: widget.service,
        country: widget.country,
        state: widget.state,
        city: widget.city,
        rating: widget.rating,
      ),
    );
  }
}
