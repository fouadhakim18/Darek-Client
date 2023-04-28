import 'package:flutter/material.dart';

final ButtonStyle stylePrimary = ElevatedButton.styleFrom(
    minimumSize: Size(20, 30),
    primary: Color(0xffFFFFFF),
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ));
