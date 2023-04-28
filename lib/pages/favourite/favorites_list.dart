import 'package:flutter/material.dart';

import '../models/favorites.dart';

final List<Favorite> favourites = [
  Favorite(
      name: 'Assil Kahlerras', wilaya: 'Tipasa', service: 'Service', rating: 5),
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

class Swipetodelete extends StatefulWidget {
  const Swipetodelete({super.key});

  @override
  State<Swipetodelete> createState() => _SwipetodeleteState();
}

class _SwipetodeleteState extends State<Swipetodelete> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: favourites.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Container(
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            key: ValueKey<Favorite>(favourites[index]),
            onDismissed: (DismissDirection direction) {
              setState(() {
                favourites.removeAt(index);
              });
            },
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
                            favourites[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            favourites[index].wilaya,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            favourites[index].service,
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
                              favourites[index].rating.toString(),
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
        });
  }
}
