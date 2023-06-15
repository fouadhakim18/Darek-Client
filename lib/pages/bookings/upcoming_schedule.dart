// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servili_client/model/worker_details.dart';
import 'package:servili_client/pages/bookings/upcoming_booking_container.dart';

import '../../model/booking.dart';

class UpcomingSchedule extends StatefulWidget {
  Query<Map<String, dynamic>> bookingRef;
  UpcomingSchedule({
    Key? key,
    required this.bookingRef,
  }) : super(key: key);

  @override
  State<UpcomingSchedule> createState() => _UpcomingScheduleState();
}

class _UpcomingScheduleState extends State<UpcomingSchedule> {
  late Stream<QuerySnapshot<Object?>>? _myStream;

  @override
  void initState() {
    super.initState();
    _myStream = widget.bookingRef
        .where('status', whereIn: ["Pending", "Confirmed"]).snapshots();
  }

  Future<WorkerDetails> getDocumentById(String id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('employees').doc(id).get();
    return WorkerDetails.fromMap(snapshot.data()!);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _myStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
                height: 600, child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            print(snapshot.error);
          } else if (snapshot.data!.docs.isEmpty) {
            print("empty");
          }

          final bookings = snapshot.data!.docs.map((doc) {
            return Booking.fromSnapshot(doc);
          }).toList();
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return FutureBuilder(
                          future: getDocumentById(booking.employeeId),
                          builder:
                              (context, AsyncSnapshot<WorkerDetails> snapshot) {
                            if (snapshot.hasData) {
                              WorkerDetails worker = snapshot.data!;
                              return UpcomingBookingContainer(
                                userName: worker.name,
                                userPic: worker.pic!,
                                userLocation: worker.wilaya!,
                                booking: booking,
                                userPhone: worker.phone!,
                                ctx: context,
                              );
                            } else if (snapshot.hasError) {
                              print("khra");
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              return const Padding(
                                padding: EdgeInsets.all(70.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                          });
                    }),
              ],
            ),
          );
        });
  }
}
