import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/button.dart';

class Ratings extends StatelessWidget {
  const Ratings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ElevatedButton(
                onPressed: () {},
                style: stylePrimary,
                child: Row(
                  children: const [
                    Icon(
                      Icons.star_outlined,
                      color: Color(0xFF34478C),
                    ),
                    Text(
                      'All',
                      style: TextStyle(
                        color: Color(0xFF34478C),
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: () {},
                style: stylePrimary,
                child: Row(
                  children: const [
                    Icon(
                      Icons.star_outlined,
                      color: Color(0xFF34478C),
                    ),
                    Text(
                      '5',
                      style: TextStyle(
                        color: Color(0xFF34478C),
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: () {},
                style: stylePrimary,
                child: Row(
                  children: const [
                    Icon(
                      Icons.star_outlined,
                      color: Color(0xFF34478C),
                    ),
                    Text(
                      '4',
                      style: TextStyle(
                        color: Color(0xFF34478C),
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: () {},
                style: stylePrimary,
                child: Row(
                  children: const [
                    Icon(
                      Icons.star_outlined,
                      color: Color(0xFF34478C),
                    ),
                    Text(
                      '3',
                      style: TextStyle(
                        color: Color(0xFF34478C),
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: () {},
                style: stylePrimary,
                child: Row(
                  children: const [
                    Icon(
                      Icons.star_outlined,
                      color: Color(0xFF34478C),
                    ),
                    Text(
                      '2',
                      style: TextStyle(
                        color: Color(0xFF34478C),
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: () {},
                style: stylePrimary,
                child: Row(
                  children: const [
                    Icon(
                      Icons.star_outlined,
                      color: Color(0xFF34478C),
                    ),
                    Text(
                      '1',
                      style: TextStyle(
                        color: Color(0xFF34478C),
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
