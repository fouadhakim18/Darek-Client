import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../../widgets/button.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    String countryValue = "";
    String stateValue = "";
    String cityValue = "";
    String address = "";

    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Fill your profile ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 19.sp),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(children: [
                const SizedBox(
                  height: 170,
                  child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('assets/images/Cleaning.png')),
                ),
                Expanded(
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
                            height: 48,
                            child: TextField(
                                decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color(0xff34478C),
                              ),
                              hintText: 'Full name ',
                              hintStyle: TextStyle(fontSize: 14.sp),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: const Color(0xfff5f5f5),
                              filled: true,
                            )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 48,
                            child: TextField(
                                decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Color(0xff34478C),
                              ),
                              hintText: 'Phone number',
                              hintStyle: TextStyle(fontSize: 14.sp),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: const Color(0xfff5f5f5),
                              filled: true,
                            )),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 48,
                            child: TextField(
                                decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Color(0xff34478C),
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(fontSize: 14.sp),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: const Color(0xfff5f5f5),
                              filled: true,
                            )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 48,
                            child: TextField(
                                decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color(0xff34478C)),
                              hintText: 'Password',
                              hintStyle: TextStyle(fontSize: 14.sp),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: const Color(0xfff5f5f5),
                              filled: true,
                            )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // SizedBox(
                          //   height: 58.h,
                          //   child: DropdownButtonFormField(
                          //       value: dropdownValue,
                          //       style: TextStyle(
                          //           fontSize: 14.sp,
                          //           color: const Color.fromARGB(
                          //               255, 104, 103, 103),
                          //           fontFamily: "Montserrat Medium"),
                          //       icon: const Icon(Icons.keyboard_arrow_down),
                          //       items: items.map((String items) {
                          //         return DropdownMenuItem(
                          //           value: items,
                          //           child: Text(items),
                          //         );
                          //       }).toList(),
                          //       onChanged: (String? newValue) {
                          //         setState(() {
                          //           dropdownValue = newValue!;
                          //         });
                          //       },
                          //       decoration: const InputDecoration(
                          //         prefixIcon: Icon(Icons.location_city,
                          //             color: Color(0xff34478C)),
                          //         hintText: 'Wilaya',
                          //         hintStyle: TextStyle(fontSize: 5),
                          //         enabledBorder: OutlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.white)),
                          //         focusedBorder: OutlineInputBorder(
                          //           borderSide: BorderSide(color: Colors.white),
                          //         ),
                          //         fillColor: Color(0xfff5f5f5),
                          //         filled: true,
                          //       )),
                          // ),

                          const SizedBox(
                            height: 10,
                          ),

                          CSCPicker(
                            onCountryChanged: (value) {},
                            onStateChanged: (value) {},
                            onCityChanged: (value) {},
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Button(
                            text: "Sign Up",
                            color: AppColors.secBlue,
                            clicked: (){}
                          ),
                          const SizedBox(
                            height: 10,
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
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: AppColors.lightBlue,
                                      fontSize: 13.sp),
                                ),
                                onPressed: () {
                                  //login screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LogInpage()),
                                  );
                                },
                              )
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                )
              ]),
            )
          ],
        ));
  }
}
