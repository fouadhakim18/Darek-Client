import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContinueButton extends StatelessWidget {
  void clicked;

  ContinueButton({super.key, required this.clicked});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: const EdgeInsets.all(15),
    //   margin: const EdgeInsets.symmetric(horizontal: 30),
    //   decoration: BoxDecoration(
    //     color: const Color(0xff34478C),
    //     borderRadius: BorderRadius.circular(50),
    //   ),
    //   child: const Center(
    //       child: Text(
    //     'Continue ',
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontWeight: FontWeight.bold,
    //       fontSize: 20,
    //     ),
    //   )),
    // );
    return ElevatedButton(
      onPressed: () => clicked,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
        backgroundColor: const Color(0xff34478C),
        shape: const StadiumBorder(),
      ),
      child: const Text(
        'Continue',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
