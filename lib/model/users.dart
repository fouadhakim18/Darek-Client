// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String name;
  String phone;
  String email;
  String password;
  String? country;
  String? state;
  String? city;
  String? pic;
  String? userToken = "";

  UserModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone,
      this.country,
      this.state,
      this.city,
      this.pic,
      this.userToken});

  toJson() {
    return {
      "Name": name,
      "Phone": phone,
      "Email": email,
      "Password": password,
      "Country": country,
      "State": state,
      "City": city,
      "Pic": pic,
      "UserToken": userToken
    };
  }
}
