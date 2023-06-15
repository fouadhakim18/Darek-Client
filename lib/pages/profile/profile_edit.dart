// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../main.dart';
import '../../utils/colors.dart';

String? countryValue;
String? stateValue;
String? cityValue;

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController phoneController;

  String? currentCountry;
  String? currentState;
  String? currentCity;
  String? pic;
  Profile(
      {Key? key,
      required this.nameController,
      required this.emailController,
      required this.phoneController,
      this.currentCountry,
      this.currentState,
      this.currentCity,
      this.pic})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    showDialogToWait();
  }

  void showDialogToWait() async {
    await Future.delayed(Duration.zero);

    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pop(context, true);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: widget.pic!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Image.asset("assets/images/add-pic.png"),
                            fit: BoxFit.cover,
                            width: 130,
                            height: 130,
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
                      widget.nameController,
                      'Name',
                      Icons.person_outlined,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      widget.emailController,
                      'Email',
                      Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      widget.phoneController,
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
                      currentCountry: widget.currentCountry,
                      onCountryChanged: (value) {
                        widget.currentCountry = value;
                      },
                      currentState: widget.currentState,
                      onStateChanged: (value) {
                        widget.currentState = value;
                      },
                      currentCity: widget.currentCity,
                      onCityChanged: (value) {
                        widget.currentCity = value;
                      },
                    ),
                    
                    const SizedBox(
                      height: 25,
                    ),
                    Button('Update', () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      updateUserData();
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
    TextEditingController controller,
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
            controller: controller,
            style: TextStyle(fontSize: 15.sp),
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

  Future<void> updateUserData() async {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    try {
      final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('clients')
          .doc(currentUserUid)
          .update({
        'Name': widget.nameController.text,
        'Email': widget.emailController.text,
        'Phone': widget.phoneController.text,
        'Country': widget.currentCountry,
        'State': widget.currentState,
        'City': widget.currentCity,
      });
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: "Data updated successfully",
        ),
      );
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: e.toString(),
        ),
      );
    }
    Navigator.pop(context, true);
  }
}
