import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
String countryValue = "";
String stateValue = "";
String cityValue = "";

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  String dropdownValue = list.first;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_outlined)),
        backgroundColor: AppColors.mainBlue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.23,
              child: Stack(
                children: [
                  blueIntroWidgetWithoutLogos(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 120,
                          height: 120,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffD6D6D6)),
                          child: const Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      'Name',
                      Icons.person_outlined,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      'Email',
                      Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      'Phone',
                      Icons.phone_outlined,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Adress",
                      style: TextStyle(color: AppColors.mainBlue),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CSCPicker(
                      onCountryChanged: (value) {},

                      ///triggers once state selected in dropdown
                      onStateChanged: (value) {},

                      ///triggers once city selected in dropdown
                      onCityChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Button('Update', () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                    }, AppColors.mainBlue),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  TextFieldWidget(
    String title,
    IconData iconData,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: AppColors.mainBlue),
        ),
        const SizedBox(
          height: 9,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: title,
              hintStyle:
                  const TextStyle(color: AppColors.textGrey, fontSize: 13),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  iconData,
                  color: AppColors.mainBlue,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget Button(String title, Function onPressed, Color color) {
    return MaterialButton(
      height: 50,
      minWidth: MediaQuery.of(context).size.width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: color,
      onPressed: () => onPressed(),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget blueIntroWidgetWithoutLogos() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/mask.png'), fit: BoxFit.fill)),
      height: MediaQuery.of(context).size.height * 0.15,
    );
  }
}
