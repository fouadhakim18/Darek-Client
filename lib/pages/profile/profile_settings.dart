import 'package:flutter/material.dart';
import 'package:onboading/pages/login/login.dart';
import 'package:onboading/pages/profile/profile_edit.dart';
import 'package:onboading/pages/profile/profile_menu.dart';
import 'package:onboading/utils/colors.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_outlined)),
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
                  child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffD6D6D6)),
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      )),
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
            press: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile())),
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: Icons.notifications_on_outlined,
            press: () => {},
          ),
          ProfileMenu(
            text: "Dark Mode",
            icon: Icons.dark_mode_outlined,
            press: () => {},
          ),
          ProfileMenu(
            text: "About App",
            icon: Icons.info_outline,
            press: () => {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: Icons.logout_outlined,
            color: AppColors.red,
            press: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogInpage(),
                ),
              )
            },
          ),
        ],
      )),
    );
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
