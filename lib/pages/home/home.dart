import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:onboading/pages/home/categories.dart';
import 'package:onboading/pages/chat/chat.dart';
import 'package:onboading/pages/profile/profile_settings.dart';
import 'package:onboading/pages/bookings/schedule.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentScreen = 0;
  final screens = [];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        Icons.home_outlined,
        size: 30,
      ),
      const Icon(
        Icons.calendar_month_outlined,
        size: 30,
      ),
      const Icon(
        Icons.chat_outlined,
        size: 30,
      ),
      const Icon(
        Icons.person_2_outlined,
        size: 30,
      ),
    ];
    return Scaffold(
      extendBody:
          true, // if we add background image it extends under bottom nav bar       
      // appBar: AppBar(),
      body: getSelectedWidget(index: currentScreen),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          color: const Color(0xFF34478C),
          backgroundColor: Colors.transparent,
          items: items,
          height: 60,
          animationDuration: const Duration(milliseconds: 300),
          index: currentScreen,
          onTap: (index) => setState(() => currentScreen = index),
        ),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    switch (index) {
      case 0:
        return const SelectService();
      case 1:
        return const ScheduleScreen();
      case 2:
        return const Chat();
      case 3:
        return const ProfileSettings();
      default:
        return Container();
    }
  }
}
