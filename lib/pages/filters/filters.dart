import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/load_services.dart';
import '../../widgets/button.dart';
import '../workers/workers.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  int _selectedIndexStar = -1;

  String selecteditem = LoadServices.serviceDisplay[0];

  String? countryValue;

  String? stateValue;

  String? cityValue;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myWidget(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      height: 4,
                      width: 90,
                      decoration: BoxDecoration(
                          color: const Color(0xffD0D0D0),
                          borderRadius: BorderRadius.circular(13)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Center(
                    child: Text(
                      'Set filters',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF34478C),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Category',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 53.h,
                    child: DropdownButtonFormField(
                        value: selecteditem,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color.fromARGB(255, 104, 103, 103),
                            fontFamily: "Montserrat Medium"),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: LoadServices.serviceDisplay.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: AppColors.mainBlackColor),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newvalue) {
                          setState(() {
                            selecteditem = newvalue!;
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.build, color: Color(0xff34478C)),
                          hintText: 'service',
                          hintStyle: TextStyle(fontSize: 14.sp),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          filled: true,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Location ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  snapshot.data!,
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Ratings ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 33,
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedIndexStar = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              margin: const EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                  color: _selectedIndexStar == index
                                      ? AppColors.mainBlue
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                  border:
                                      Border.all(color: AppColors.mainBlue)),
                              width: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: _selectedIndexStar == index
                                        ? Colors.white
                                        : AppColors.mainBlue,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: _selectedIndexStar == index
                                          ? Colors.white
                                          : AppColors.mainBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 20),
                  Button(
                      text: "Apply Filters",
                      clicked: () {
                        Get.to(
                            () => WorkersScreen(
                                  service: selecteditem,
                                  country: countryValue,
                                  state: stateValue,
                                  city: cityValue,
                                  rating: _selectedIndexStar + 1,
                                ),
                            transition: Transition.fadeIn);
                      }),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<CSCPicker> myWidget() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return CSCPicker(
      onCountryChanged: (value) {
        countryValue = value;
      },
      onStateChanged: (value) {
        stateValue = value;
      },
      onCityChanged: (value) {
        cityValue = value;
      },
    );
  }
}
