import 'package:flutter/material.dart';

import '../../model/favorites.dart';
import '../employee_details/employee_details_screen.dart';

class FavList extends StatelessWidget {
  FavList({super.key});

  final List<Favorite> favourites = [
    Favorite(
        name: 'Assil Kahlerras',
        wilaya: 'Tipasa',
        service: 'Service',
        rating: 5),
    Favorite(
        name: 'Chahinez Hadj Abderrahmane',
        wilaya: 'Alger',
        service: 'Service',
        rating: 5),
    Favorite(
      name: 'Full Name',
      wilaya: 'Wilaya',
      service: 'Service',
      rating: 4.5,
    ),
    Favorite(
      name: 'Full Name',
      wilaya: 'Wilaya',
      service: 'Service',
      rating: 4.7,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: favourites.map((fv) {
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EmployeeDetails(),
              ),
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xfff5f5f5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 5, right: 15),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          height: 60,
                          width: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            fv.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            fv.wilaya,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            fv.service,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      color: const Color(0xff34478C),
                      shape: const StadiumBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              size: 15,
                              Icons.star,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              fv.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
