// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:onboading/pages/login/login.dart';

import 'package:onboading/pages/onboarding/on_boarding.dart';
import 'package:onboading/utils/colors.dart';


class SplashScreen extends StatelessWidget {
  final int? isViewed;
  const SplashScreen({
    Key? key,
    this.isViewed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Text("Servili", style: TextStyle(color: Colors.white, fontSize: 27),),
      nextScreen: isViewed != 0 ? const OnBoarding() : const LogInpage(),
      duration: 1000,
      backgroundColor: AppColors.mainBlue,
    );
  }
}
