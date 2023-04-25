// ignore: depend_on_referenced_packages
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboading/model/service.dart';
import 'package:onboading/widgets/circle_button.dart';
import 'dart:convert';

import '../favourite/my_fav.dart';
import '../workers/workers.dart';

class SelectService extends StatefulWidget {
  const SelectService({Key? key}) : super(key: key);

  @override
  _SelectServiceState createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  int selectedService = -1;
  var serviceDisplay = [];
  Future<List<Service>> readJson() async {
    final String response = await rootBundle.loadString('assets/services.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((json) => Service.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    serviceDisplay = await readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        floatingActionButton: selectedService >= 0
            ? Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Workers(),
                      ),
                    );
                  },
                  backgroundColor: const Color(0xFF34478C),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              )
            : null,
        body: FutureBuilder(
          future: readJson(),
          builder: (context, data) {
            if (data.hasError) {
              return const Center(
                child: Text("error"),
              );
            } else if (data.hasData) {
              var items = data.data as List<Service>;
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 60.0.h,
                              right: 20.0.w,
                              left: 20.0.w,
                              bottom: 25.h),
                          decoration: BoxDecoration(
                              color: const Color(0xFF34478C),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30.w),
                                  bottomRight: Radius.circular(30.w))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hello ,\nGood morning',
                                    style: TextStyle(
                                      fontSize: 21.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  CircleButton(
                                      icon: Icons.favorite,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const MyFav()),
                                        );
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CupertinoSearchTextField(
                                onChanged: (searchText) {
                                  searchText = searchText.toLowerCase();
                                  setState(() {
                                    serviceDisplay = items.where((u) {
                                      var name = u.name.toLowerCase();
                                      return name.contains(searchText);
                                    }).toList();
                                  });
                                },
                                itemSize: 24,
                                placeholderStyle: TextStyle(
                                    fontSize: 19.sp,
                                    color: const Color.fromARGB(
                                        255, 151, 150, 150)),
                                backgroundColor: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(30),
                                padding: const EdgeInsets.only(
                                    top: 12, bottom: 12, left: 10),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Icon(
                                    Icons.search,
                                    size: 32.sp,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                  ];
                },
                body: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Explore Categories",
                          style: TextStyle(
                              fontSize: 19.sp, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15.0,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: serviceDisplay.length,
                              itemBuilder: (BuildContext context, int index) {
                                return serviceContainer(index, serviceDisplay);
                              }),
                        ),
                      ]),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  serviceContainer(int index, List<dynamic> items) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index) {
            selectedService = -1;
          } else {
            selectedService = index;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 8.w, left: 8.w),
        decoration: BoxDecoration(
            color: selectedService == index
                ? const Color.fromARGB(255, 225, 235, 255)
                : Colors.white,
            border: Border.all(
              color: selectedService == index
                  ? const Color(0xFF34478C)
                  : Colors.blue.withOpacity(0),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0.w),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 4.0,
                  spreadRadius: .1)
            ]),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.maxFinite,
                height: 103.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(items[index].image),
                        fit: BoxFit.cover)),
              ),
              SizedBox(height: 5.h),
              Text(
                items[index].name,
                style: TextStyle(fontSize: 18.sp),
              )
            ]),
      ),
    );
  }
}
