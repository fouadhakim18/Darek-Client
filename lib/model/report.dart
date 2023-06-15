import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String? id;
  String employeeId;
  String details;

  Report({
    this.id,
    required this.employeeId,
    required this.details,
  });
  Map<String, dynamic> toJson() {
    return {'id': id, 'employeeId': employeeId, 'details': details};
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
        id: map['id'], employeeId: map['employeeId'], details: map['details']);
  }

  factory Report.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Report(
        id: data['id'],
        employeeId: data['employeeId'],
        details: data['details']);
  }
}
