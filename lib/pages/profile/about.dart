import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:servili_client/utils/colors.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
              child: Column(
            children: [
              Text(
                  "Our application is designed to connect clients with skilled professionals in various trades such as masonry, electrical work, and general labor. It consists of three main components: a client app, an employee app, and an admin panel.\nThe client app enables users to browse through a list of qualified employees, view their profiles, and book their services. Clients can also create a favorites list of preferred employees and provide ratings and reviews based on their experiences. Additionally, the app allows clients to report any issues or concerns they may encounter during the service.\nOn the other hand, the employee app empowers workers to manage their bookings, accept or decline service requests, and communicate with clients to discuss service details. Employees can also receive ratings and feedback from clients, helping them build a reputable professional profile.\nOverall, our app aims to streamline the process of hiring skilled workers for clients while providing a platform for employees to showcase their expertise. It prioritizes user satisfaction, trust, and efficient communication between clients and employees, ultimately enhancing the overall experience for both parties involved."),
              Text(
                "Developed by :",
                style: TextStyle(
                  color: AppColors.mainBlue,
                  decoration: TextDecoration.underline,
                ),
              ),
              Text(
                "MAROC Abdelhakim Fouad",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "KAHLERRAS Assil",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "HADJABDERRAHMANE Chahinez",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "BELABBES Asma",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )),
        ),
      ),
    );
  }
}
