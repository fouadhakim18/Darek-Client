import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../bookings/schedule.dart';
import '../chat/chat.dart';
import '../profile/profile_settings.dart';
import 'categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentScreen = 0;
  final screens = [];

  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentPosition = position;
      });
      print(position.latitude);
      print(position.longitude);
      await storeUserLocation(FirebaseAuth.instance.currentUser!.uid,
          position.latitude, position.longitude);
    }
  }

  Future<void> storeUserLocation(
      String userId, double latitude, double longitude) async {
    try {
      await FirebaseFirestore.instance
          .collection('clients')
          .doc(userId)
          .update({'latitude': latitude, 'longitude': longitude});
      print('User location stored in Firestore.');
    } catch (e) {
      print('Error storing user location: $e');
    }
  }

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
