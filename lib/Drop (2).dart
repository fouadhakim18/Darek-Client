import 'package:flutter/material.dart';

const List<String> list = <String>[
  'LIVRAISON',
  'HOUSE CARE',
  'MAIN D OEUVRE',
];

class Drop extends StatefulWidget {
  const Drop({super.key});

  @override
  State<Drop> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Drop> {
  String selecteditem = list.first;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30),
      child: DropdownButtonFormField(
          value: selecteditem,
          isExpanded: true,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1)),
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
          }),
    );
  }
}
