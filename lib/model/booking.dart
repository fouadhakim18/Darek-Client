// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String? id;
  String userId;
  String employeeId;
  String date;
  String time;
  String locationUser;
  String moreDetails;
  String status;

  Booking({
    this.id,
    required this.userId,
    required this.employeeId,
    required this.date,
    required this.time,
    required this.locationUser,
    required this.moreDetails,
    required this.status,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'employeeId': employeeId,
      'date': date,
      'time': time,
      'locationUser': locationUser,
      'moreDetails': moreDetails,
      'status': status,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
        id: map['id'],
        userId: map['userId'],
        employeeId: map['employeeId'],
        date: map['date'],
        time: map['time'],
        locationUser: map['locationUser'],
        moreDetails: map['moreDetails'],
        status: map['status']);
  }

  factory Booking.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Booking(
      id: data['id'],
      userId: data['userId'],
      employeeId: data['employeeId'],
      date: data['date'],
      time: data['time'],
      locationUser: data['locationUser'],
      moreDetails: data['moreDetails'],
      status: data['status'],
    );
  }
}
