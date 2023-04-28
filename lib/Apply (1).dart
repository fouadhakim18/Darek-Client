import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Apply extends StatelessWidget {
  const Apply({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ElevatedButton(
        onPressed: () {},
        style: stylePrimary1,
        child: const Text(
          'Apply Filters ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

final ButtonStyle stylePrimary1 = ElevatedButton.styleFrom(
    minimumSize: const Size(270, 50),
    primary: const Color(0xFF34478C),
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ));
