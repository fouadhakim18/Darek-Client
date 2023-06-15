class WorkerDetails {
  String? id;
  String name;
  final String? wilaya;
  final String service;
  final String? phone;
  final String email;
  final String? pic;
  final String? about;
  String? employeeToken = "";
  final num? averageRating;
  bool isVerified;

  WorkerDetails(
      {this.id,
      required this.name,
      required this.wilaya,
      required this.service,
      required this.phone,
      required this.email,
      this.pic,
      this.about,
      this.employeeToken,
      this.averageRating,
      required this.isVerified});

  factory WorkerDetails.fromMap(Map<String, dynamic> map) {
    return WorkerDetails(
        name: map['Name'],
        wilaya: map['State'],
        service: map['Service'],
        phone: map['Phone'],
        email: map['Email'],
        pic: map['Pic'],
        about: map['AboutEmployee'],
        employeeToken: map['EmployeeToken'],
        averageRating: map['AverageRating'],
        isVerified: map['IsVerified']);
  }
}
