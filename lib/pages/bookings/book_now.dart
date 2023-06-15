// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../main.dart';
import '../../model/booking.dart';
import '../../utils/colors.dart';
import '../../utils/notifs.dart';
import '../../utils/user_data.dart';
import '../../widgets/button.dart';

class BookNow extends StatefulWidget {
  String employeeId;
  BookNow({
    Key? key,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<BookNow> createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _date = DateTime.now();
  String _selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  TimeOfDay _time = TimeOfDay.now();
  String _selectedTime = DateFormat('h:mm a').format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute));

  

  

  getMessage() {
    FirebaseMessaging.onMessage.listen((message) {
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _selectedDate = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      DateTime now = DateTime.now();
      setState(() {
        _time = picked;
        _selectedTime = DateFormat('h:mm a').format(
            DateTime(now.year, now.month, now.day, _time.hour, _time.minute));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMessage();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 2,
              ),
              Center(
                child: Container(
                  height: 4,
                  width: 90,
                  decoration: BoxDecoration(
                      color: const Color(0xffD0D0D0),
                      borderRadius: BorderRadius.circular(13)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  // select date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Date",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => _selectDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 13),
                            decoration: BoxDecoration(
                                color: AppColors.secBlue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  _selectedDate,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  // select time
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Time",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => _selectTime(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 13),
                            decoration: BoxDecoration(
                                color: AppColors.secBlue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  _selectedTime,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Your location",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: TextFormField(
                  maxLines: null, // set to null to allow multiple lines
                  controller: _locationController,
                  decoration: const InputDecoration(
                    hintText: "Enter your detailed location",
                    hintStyle: TextStyle(fontSize: 13),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Add Note",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: TextFormField(
                  maxLines: null, // set to null to allow multiple lines
                  controller: _noteController,
                  decoration: const InputDecoration(
                    hintText: "details about the job",
                    hintStyle: TextStyle(fontSize: 13),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 45),
              Button(
                text: "Confirm booking",
                clicked: () {
                  _addBooking();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addBooking() async {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    final userData = await UserData().getUserData();
    final user = FirebaseAuth.instance.currentUser;
    final id = DateTime.now().toString();

    final booking = Booking(
      id: id,
      userId: user!.uid,
      employeeId: widget.employeeId,
      date: _selectedDate,
      time: _selectedTime,
      locationUser: _locationController.text.trim(),
      moreDetails: _noteController.text.trim(),
      status: "Pending",
    );

    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(id)
          .set(booking.toJson());
      Navigator.pop(context, true);

      showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Booking confirmed',
          ));

      DocumentReference docRef = FirebaseFirestore.instance
          .collection('employees')
          .doc(widget.employeeId);
      DocumentSnapshot docSnapshot = await docRef.get();
      sendNotif("New booking", '${userData.get("Name")} requested a booking',
          docSnapshot.get('EmployeeToken'));
    } catch (e) {
    }
  }
}
