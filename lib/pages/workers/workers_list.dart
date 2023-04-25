import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboading/pages/employee_details/employee_details_screen.dart';

import '../../model/worker_details.dart';
import '../../utils/colors.dart';

class WorkersList extends StatefulWidget {
  const WorkersList({super.key});

  @override
  State<WorkersList> createState() => _WorkersListState();
}

class _WorkersListState extends State<WorkersList> {
  bool isFav = false;

  final List<WorkerDetails> workers = [
    WorkerDetails(
        name: 'Assil Kahlerras',
        wilaya: 'Tipasa',
        service: 'Service',
        rating: 5,
        isFav: false),
    WorkerDetails(
        name: 'Chahinez Hadj Abderrahmane',
        wilaya: 'Alger',
        service: 'Service',
        rating: 5,
        isFav: false),
    WorkerDetails(
        name: 'Full Name',
        wilaya: 'Wilaya',
        service: 'Service',
        rating: 4.5,
        isFav: false),
    WorkerDetails(
        name: 'Full Name',
        wilaya: 'Wilaya',
        service: 'Service',
        rating: 4.7,
        isFav: false),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: workers.map((wk) {
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EmployeeDetails(),
              ),
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xfff5f5f5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 5, right: 15),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          height: 70,
                          width: 70,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  wk.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    wk.isFav = !wk.isFav;
                                  });
                                },
                                child: Icon(
                                  wk.isFav
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border,
                                  color: AppColors.mainBlue,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            wk.wilaya,
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                wk.service,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                              Card(
                                color: const Color(0xff34478C),
                                shape: const StadiumBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Icon(
                                        size: 15,
                                        Icons.star,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        wk.rating.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
