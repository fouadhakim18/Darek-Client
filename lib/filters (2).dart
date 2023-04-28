// ignore: depend_on_referenced_packages
import 'package:dzair_data_usage/langs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Apply.dart';
import 'package:flutter_application_1/Drop.dart';
import 'package:flutter_application_1/Ratings.dart';
import 'package:dzair_data_usage/dzair.dart';
import 'package:dzair_data_usage/wilaya.dart';

class Filters extends StatelessWidget {
  Filters({super.key});

  String? selecteditem = "choose a category";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(height: 10),
          Divider(
            color: Color(0xffD0D0D0),
            height: 10,
            thickness: 5,
            indent: 140,
            endIndent: 140,
          ),
          SizedBox(height: 5),
          Text(
            'Set filters',
            style: TextStyle(
                fontSize: 25,
                color: Color(0xFF34478C),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(right: 180),
            child: Text(
              'Category',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Drop(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(right: 130),
            child: Expanded(
              child: Text(
                'Sub Category',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Drop2(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: 180),
            child: Text(
              'Location ',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Drop3(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(right: 180),
            child: Text(
              'Ratings ',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Ratings(),
          SizedBox(height: 20),
          Apply(),
        ],
      ),
    );
  }
}

const List<String> list = <String>[
  'Plomberie ',
  'Maçonnerie',
  'Peinture ',
  'Electricité',
  'Menuiserie',
  'Poids fort',
  'Poids léger',
  'House cleaning',
  'Chefs',
  'Infermier',
];

class Drop2 extends StatefulWidget {
  const Drop2({super.key});

  @override
  State<Drop2> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Drop2> {
  String selecteditem = list.first;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30),
        child: DropdownButtonFormField(
          value: selecteditem,
          isExpanded: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Color(0xffFFFFFF),
            filled: true,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_outlined,
          ),
          elevation: 20,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              selecteditem = value!;
            });
          },
        ));
  }
}

Dzair dzair = Dzair();

List<Wilaya?>? list1 = dzair.getWilayat();
List<String?>? list11 = <String>[];

class Drop3 extends StatefulWidget {
  const Drop3({super.key});

  @override
  State<Drop3> createState() => _MyWidgetState1();
}

class _MyWidgetState1 extends State<Drop3> {
  String? selecteditem = list1![0]!.getWilayaName(Language.FR);
  copy() {
    for (int i = 0; i < list1!.length; i++) {
      list11!.add(list1![i]!.getWilayaName(Language.FR));
    }
    return list11!;
  }

  List<String> list12 = <String>[];
  @override
  Widget build(BuildContext context) {
    list12.addAll(copy());
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30),
      child: DropdownButtonFormField(
          value: selecteditem,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_outlined,
          ),
          elevation: 20,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Color(0xffFFFFFF),
            filled: true,
          ),
          items: list12.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              selecteditem = value!;
            });
          }),
    );
  }
}
