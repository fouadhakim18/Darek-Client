import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final List<Introduction> list = [
    Introduction(
      title: 'Connect',
      subTitle: 'Connect with reliable  handymen in your area.',
      subTitleTextStyle: const TextStyle(fontSize: 19),
      imageUrl: 'assets/images/illustration.png',
    ),
    Introduction(
      title: 'Free',
      subTitle: 'Hassle-free home maintenance',
      subTitleTextStyle: const TextStyle(fontSize: 19),
      imageUrl: 'assets/images/illustration2.png',
    ),
    Introduction(
      title: 'And much more',
      titleTextStyle: const TextStyle(fontSize: 27),
      subTitle: '',
      imageUrl: 'assets/images/illustration3.png',
    ),
  ];

  _storeOnBoardingInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('OnBoarding', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntroScreenOnboarding(
        skipTextStyle: const TextStyle(color: Color(0xFF34478C), fontSize: 18),
        introductionList: list,
        backgroudColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 54, 71, 135),
        onTapSkipButton: () async {
          await _storeOnBoardingInfo();
          // ignore: use_build_context_synchronously
          Get.to(() => const LogInpage(), transition: Transition.fadeIn);
        },
      ),
    ));
  }
}
