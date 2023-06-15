// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servili_client/main.dart';
import 'package:servili_client/pages/login/sign_up.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../utils/colors.dart';
import '../../widgets/button.dart';
import '../home/home.dart';
import 'forgot_password.dart';

// ignore: must_be_immutable
class LogInpage extends StatefulWidget {
  const LogInpage({
    Key? key,
  }) : super(key: key);

  @override
  State<LogInpage> createState() => _LogInpageState();
}

class _LogInpageState extends State<LogInpage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false ,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const SizedBox(
                  width: 330,
                  child: Image(image: AssetImage('assets/images/login.png')),
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Welcome back, ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            SizedBox(
                              height: 50,
                              child: TextField(
                                  controller: emailController,
                                  style: TextStyle(fontSize: 15.sp),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: AppColors.mainBlue,
                                    ),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(fontSize: 14.sp),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    fillColor: const Color(0xfff5f5f5),
                                    filled: true,
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              child: TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 15.sp),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Color(0xff34478C)),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(fontSize: 14.sp),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.secBlue)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.secBlue),
                                    ),
                                    fillColor: const Color(0xfff5f5f5),
                                    filled: true,
                                  )),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                onPressed: () {
                                  //forgot password screen
                                  Get.to(() => const ForgotPassword());
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xffADD5F8)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            InkWell(
                              onTap: () => Get.to(() => const HomeScreen(),
                                  transition: Transition.fadeIn),
                              child: Button(
                                  // size: 20.sp,
                                  text: "Sign in",
                                  color: AppColors.secBlue,
                                  clicked: signIn),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Do not have an account?",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppColors.textColor),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => const SignUpPage(),
                                  transition: Transition.fadeIn);
                                    
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        color: AppColors.lightBlue,
                                        fontSize: 13.sp),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
// global declaration

  Future signIn() async {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      Navigator.pop(context, true);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'you are succesfully logged in',
        ),
      );
      Get.to(() => const HomeScreen(),
                                  transition: Transition.fadeIn);
      
    } on FirebaseAuthException catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: e.message!,
        ),
      );
      Navigator.pop(context, true);
    }
  }
}
