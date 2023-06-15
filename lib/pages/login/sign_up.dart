import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servili_client/pages/home/home.dart';
import 'package:servili_client/pages/login/verifyemail.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../main.dart';
import '../../model/users.dart';
import '../../utils/colors.dart';
import '../../widgets/button.dart';
import 'login.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _db = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? countryValue;
  String? stateValue;
  String? cityValue;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
              color: Colors.black,
              onPressed: () => Get.to(() => const LogInpage(),
                  transition: Transition.fadeIn)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Fill your profile ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(children: [
                SizedBox(
                    height: 170,
                    child: Stack(
                      children: [
                        CircleAvatar(
                            radius: 60,
                            backgroundImage: _imageFile == null
                                ? const AssetImage('assets/images/add-pic.png')
                                : FileImage(File(_imageFile!.path))
                                    as ImageProvider),
                        Positioned(
                            bottom: 45,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) => bottomSheet());
                              },
                              child: const Icon(
                                Icons.camera_alt,
                                color: AppColors.mainBlue,
                              ),
                            ))
                      ],
                    )),
                Form(
                  key: formKey,
                  child: Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColors.mainBlue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(children: [
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              height: 55,
                              child: TextFormField(
                                style: TextStyle(fontSize: 16.sp),
                                controller: nameController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Color(0xff34478C),
                                  ),
                                  hintText: 'Full name ',
                                  hintStyle: TextStyle(fontSize: 14.sp),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  fillColor: const Color(0xfff5f5f5),
                                  filled: true,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 55,
                              child: TextFormField(
                                style: TextStyle(fontSize: 16.sp),
                                controller: phoneController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.phone,
                                    color: Color(0xff34478C),
                                  ),
                                  hintText: 'Phone number',
                                  hintStyle: TextStyle(fontSize: 14.sp),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  fillColor: const Color(0xfff5f5f5),
                                  filled: true,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              // height: 55,
                              child: TextFormField(
                                style: TextStyle(fontSize: 16.sp),
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Color(0xff34478C),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(fontSize: 14.sp),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  fillColor: const Color(0xfff5f5f5),
                                  filled: true,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
                                    ? "enter a valid email"
                                    : null,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              // height: 55,
                              child: TextFormField(
                                style: TextStyle(fontSize: 16.sp),
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Color(0xff34478C)),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(fontSize: 14.sp),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  fillColor: const Color(0xfff5f5f5),
                                  filled: true,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (password) =>
                                    password != null && password.length < 6
                                        ? "enter min. 6 characters"
                                        : null,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CSCPicker(
                              onCountryChanged: (value) {
                                countryValue = value;
                              },
                              onStateChanged: (value) {
                                stateValue = value;
                              },
                              onCityChanged: (value) {
                                cityValue = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Button(
                                // size: 19.sp,
                                text: "Sign Up",
                                color: AppColors.secBlue,
                                clicked: signUp),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Already have an acount?",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppColors.textColor),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => const LogInpage(),
                                        transition: Transition.fadeIn);
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: AppColors.lightBlue,
                                        fontSize: 13.sp),
                                  ),
                                )
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            )
          ],
        ));
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Choose profile picture",
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.camera,
                        color: AppColors.mainBlue,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Camera",
                        style: TextStyle(color: AppColors.mainBlue),
                      )
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.image,
                        color: AppColors.mainBlue,
                      ),
                      SizedBox(width: 10),
                      Text("Gallery",
                          style: TextStyle(color: AppColors.mainBlue))
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    String imageUrl;
    if (_imageFile == null) {
      imageUrl = "";
    } else {
      imageUrl = await uploadImageToFirebase(_imageFile!);
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      final user = UserModel(
          email: emailController.text.trim(),
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          password: passwordController.text.trim(),
          country: countryValue ?? "",
          state: stateValue ?? "",
          city: cityValue ?? "",
          pic: imageUrl,
          userToken: "");

      await _db
          .collection("clients")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.toJson())
          .then((_) {
        Navigator.pop(context, true);

        showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
              message: 'Your account has successfully been created',
            ));
        Get.to(() => const VerifyEmail(), transition: Transition.fadeIn);
      }).catchError((e) {
        Navigator.pop(context, true);

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: e.message!,
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context, true);

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: e.message!,
        ),
      );
    }
  }

  Future<String> uploadImageToFirebase(XFile? file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages =
        referenceRoot.child('userProfileImages/$fileName.jpg');
    Reference referenceImage = referenceDirImages.child(fileName);
    if (file != null) {
      try {
        await referenceImage.putFile(File(file.path));
        String imageUrl = await referenceImage.getDownloadURL();
        return imageUrl;
      } catch (e) {
        return e.toString();
      }
    } else {
      return "";
    }
  }
}
