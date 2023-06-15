// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../utils/colors.dart';
import '../../utils/user_data.dart';
import '../login/login.dart';
import 'about.dart';
import 'notifications.dart';
import 'profile_edit.dart';
import 'profile_menu.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();

  String? currentCountry;
  String? currentState;
  String? currentCity;
  String? pic;
  late Future<String> _loadedPic;
  late String _newPic;
  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadedPic = _loadPic();
  }

  Future<void> _loadUserData() async {
    final userData = await UserData().getUserData();
    nameController.text = userData.get('Name');
    emailController.text = userData.get('Email');
    phoneController.text = userData.get('Phone');
    aboutController.text = "Hakim";
    currentCountry = userData.get("Country");
    currentState = userData.get("State");
    currentCity = userData.get("City");
  }

  Future<String> _loadPic() async {
    final userData = await UserData().getUserData();
    pic = userData.get("Pic");
    return pic!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(onTap: () {}, child: const SizedBox()),
          backgroundColor: AppColors.mainBlue,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.23,
              child: Stack(
                children: [
                  blueIntroWidgetWithoutLogos(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FutureBuilder(
                      future: _loadedPic,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _newPic = snapshot.data!;
                          return InkWell(
                              onTap: () {},
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset("assets/images/add-pic.png"),
                                  fit: BoxFit.cover,
                                  width: 130,
                                  height: 130,
                                ),
                              ));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ProfileMenu(
              text: "Edit Profile",
              icon: Icons.person_2_outlined,
              press: () async {
                await Future.delayed(const Duration(milliseconds: 100));
                Get.to(
                    () => Profile(
                          nameController: nameController,
                          emailController: emailController,
                          phoneController: phoneController,
                          currentCountry: currentCountry,
                          currentCity: currentCity,
                          currentState: currentState,
                          pic: _newPic,
                        ),
                    transition: Transition.fadeIn);
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: Icons.notifications_on_outlined,
              press: () => {
                Get.to(() => const Notifications(), transition: Transition.fade)
              },
            ),
            ProfileMenu(
              text: "Dark Mode",
              icon: Icons.dark_mode_outlined,
              press: () => {},
            ),
            ProfileMenu(
              text: "About App",
              icon: Icons.info_outline,
              press: () =>
                  {Get.to(() => const AboutApp(), transition: Transition.fade)},
            ),
            ProfileMenu(
                text: "Log Out",
                icon: Icons.logout_outlined,
                color: AppColors.red,
                press: () => signOut()),
          ],
        )));
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Succeffully logged out',
        ),
      );
      Get.to(() => const LogInpage());
    } catch (e) {
      print(e.toString());
    }
  }

  Widget blueIntroWidgetWithoutLogos() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/mask.png'), fit: BoxFit.fill)),
      height: MediaQuery.of(context).size.height * 0.16,
    );
  }
}
