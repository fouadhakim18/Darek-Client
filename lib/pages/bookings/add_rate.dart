// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:servili_client/model/rating.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/notifs.dart';
import '../../utils/user_data.dart';
import '../../widgets/button.dart';

class Addrate extends StatefulWidget {
  String employeeId;
  Addrate({
    Key? key,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<Addrate> createState() => _AddrateState();
}

class _AddrateState extends State<Addrate> {
  final TextEditingController _ratingController = TextEditingController();
  double ratingValue = 3;
  bool _switch = false;

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
              const Text(
                "How was your work experience ?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: ratingValue,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return const Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return const Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return const Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return const Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      default:
                        return const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                    }
                  },
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratingValue = rating;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text("Rating: $ratingValue",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textGrey)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Tell us few words about your experience",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: TextFormField(
                  maxLines: null, // set to null to allow multiple lines
                  controller: _ratingController,
                  decoration: const InputDecoration(
                    hintText: "few words about the employee",
                    hintStyle: TextStyle(fontSize: 13),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text("Rating Anonyme",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Switch(
                    activeColor: AppColors.mainBlue,
                    value: _switch,
                    onChanged: (value) {
                      setState(() {
                        _switch = value;
                        print(_switch);
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Button(
                text: "Submit",
                clicked: () {
                  _addRate();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addRate() async {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    final userData = await UserData().getUserData();
    final id = DateTime.now().toString();
    final rating = Rating(
        id: id,
        userName: _switch ? "Anonyme" : userData.get("Name"),
        employeeId: widget.employeeId,
        ratingDetails: _ratingController.text.trim(),
        ratingValue: ratingValue,
        userPic: _switch ? "Anonyme" : userData.get("Pic"));

    DocumentReference docRef = FirebaseFirestore.instance
        .collection('employees')
        .doc(widget.employeeId);
    DocumentSnapshot docSnapshot = await docRef.get();
    sendNotif(
        "New Rating",
        '${_switch ? "Anonyme" : userData.get("Name")} added new rating',
        docSnapshot.get('EmployeeToken'));
    try {
      print("added");
      Navigator.pop(context, true);
      await FirebaseFirestore.instance
          .collection("ratings")
          .doc(id)
          .set(rating.toJson());
      showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Rating Submitted',
          ));
    } catch (e) {
      print(e);
    }
  }
}
