import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboading/pages/home/home.dart';
import 'package:onboading/pages/login/forgot_password.dart';
import 'package:onboading/pages/login/sign_up.dart';
import 'package:onboading/utils/colors.dart';
import 'package:onboading/widgets/button.dart';

class LogInpage extends StatefulWidget {
  const LogInpage({super.key});

  //void signin(){} //chemin vers sign in page

  @override
  State<LogInpage> createState() => _LogInpageState();
}

class _LogInpageState extends State<LogInpage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // resizeToAvoidBottomInset: false ,
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                                    borderSide: BorderSide(color: Colors.white),
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
                                style: TextStyle(fontSize: 15.sp),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Color(0xff34478C)),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(fontSize: 14.sp),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.secBlue)),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ForgotPassword()),
                                );
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
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            ),
                            child: Button(
                                text: "Sign in",
                                color: AppColors.secBlue,
                                clicked: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                  );
                                }),
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
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: AppColors.lightBlue,
                                      fontSize: 13.sp),
                                ),
                                onPressed: () {
                                  //signup screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()),
                                  );
                                },
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
    );
  }
}
