import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servili_client/utils/colors.dart';
import 'dart:convert';

import '../../model/service.dart';
import '../../utils/load_services.dart';
import '../../widgets/circle_button.dart';
import '../favourite/my_fav.dart';
import '../filters/body.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../workers/workers.dart';

class SelectService extends StatefulWidget {
  const SelectService({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SelectServiceState createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  int selectedService = -1;
  var serviceDisplay = [];
  Future<List<Service>> readJson() async {
    final String response = await rootBundle.loadString('assets/services.json');
    final data = await json.decode(response) as List<dynamic>;
    final data2 = await json.decode(response);
    List<String> temp = [];
    for (var i = 0; i < data.length; i++) {
      temp.add(data2[i]["name"]);
    }
    setState(() {
      LoadServices.serviceDisplay = temp;
    });
    return data.map((json) => Service.fromJson(json)).toList();
  }

  late Future<List<Service>> _readJson;

  final fbm = FirebaseMessaging.instance;

  Future<void> updateToken(String? token) async {
    try {
      final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('clients')
          .doc(currentUserUid)
          .update({"UserToken": token});
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    fbm.getToken().then((token) {
      updateToken(token);

      FirebaseMessaging.onMessage.listen((event) {});
    });
    initialize();
    _readJson = readJson();
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
                    Get.to(
                        () => WorkersScreen(
                            service:
                                LoadServices.serviceDisplay[selectedService]),
                        transition: Transition.fadeIn);
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
          future: _readJson,
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
                                        Get.to(
                                          () => const MyFav(),
                                          transition: Transition.fade,
                                        );
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: TextField(
                                    onChanged: (searchText) {
                                      searchText = searchText.toLowerCase();
                                      setState(() {
                                        serviceDisplay = items.where((u) {
                                          var name = u.name.toLowerCase();
                                          return name.contains(searchText);
                                        }).toList();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15),
                                      prefixIconColor: AppColors.mainBlue,
                                      suffixIconColor: AppColors.mainBlue,
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                          fontSize: 16.sp,
                                          color: const Color.fromARGB(
                                              255, 151, 150, 150)),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: const BorderSide(
                                              color: AppColors.mainBlue)),
                                      hintText: "Search",
                                      prefixIcon: Icon(
                                        Icons.search,
                                        size: 29.sp,
                                      ),
                                      suffixIcon: InkWell(
                                          onTap: () => showModalBottomSheet(
                                              isScrollControlled: true,
                                              barrierColor:
                                                  const Color.fromARGB(
                                                          255, 0, 0, 0)
                                                      .withOpacity(0.8),
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (context) {
                                                return const FractionallySizedBox(
                                                  heightFactor: 0.65,
                                                  child: Body(),
                                                );
                                              }),
                                          child: const Icon(Icons.filter_list)),
                                    ),
                                  ),
                                ),
                              )
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
                            child: AnimationLimiter(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: serviceDisplay.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: FadeInAnimation(
                                            child: serviceContainer(
                                                index, serviceDisplay))));
                              }),
                        )),
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
        padding: EdgeInsets.only(top: 11.h, bottom: 4.h, right: 8.w, left: 8.w),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: SizedBox(
                    width: 110,
                    height: 105.h,
                    child: Image(
                      image: AssetImage(items[index].image),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(height: 10.h),
              Text(
                items[index].name,
                style: TextStyle(fontSize: 16.sp),
              )
            ]),
      ),
    );
  }
}
