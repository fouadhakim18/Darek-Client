// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:servili_client/pages/bookings/book_now.dart';

import 'package:servili_client/model/worker_details.dart';

import '../../widgets/button.dart';
import 'employee_details_appbar.dart';
import 'employee_infos.dart';

// ignore: must_be_immutable
class EmployeeDetails extends StatefulWidget {
  WorkerDetails worker;

  EmployeeDetails({
    Key? key,
    required this.worker,
  }) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

bool isFav = false;

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> setFav() {
    return Future.delayed(Duration.zero, () async {
      isFav = await isFavorite(widget.worker.id!);
      return isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
        initialData: isFav,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                ),
              );
            } else if (snapshot.hasData) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      EmployeeDetailsAppbar(
                        pic: widget.worker.pic,
                      ),
                      EmployeeInfos(
                        worker: widget.worker,
                        isFav: isFav,
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Button(
                              text: "Book Now",
                              clicked: () {
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
                                                  topRight:
                                                      Radius.circular(30))),
                                          child: BookNow(
                                              employeeId: widget.worker.id!),
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: setFav(),
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
}
