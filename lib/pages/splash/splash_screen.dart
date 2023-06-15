// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:servili_client/pages/home/home.dart';
import 'package:servili_client/pages/login/login.dart';
import 'package:servili_client/pages/login/verifyemail.dart';

import '../../utils/colors.dart';
import '../onboarding/on_boarding.dart';

class SplashScreen extends StatelessWidget {
  final int? isViewed;
  const SplashScreen({
    Key? key,
    this.isViewed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset("assets/images/darek-logo.png")),
      nextScreen: isViewed != 0
          ? const OnBoarding()
          : StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                } else if (snapshot.hasData) {
                  return const VerifyEmail();
                } else {
                  return const LogInpage();
                }
              }),
      duration: 1000,
      backgroundColor: AppColors.mainBlue,
    );
  }
}
