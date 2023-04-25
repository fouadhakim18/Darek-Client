import 'package:flutter/material.dart';
import 'package:onboading/pages/employee_details/employee_details_appbar.dart';
import 'package:onboading/utils/colors.dart';
import 'package:onboading/widgets/big_text.dart';
import 'package:onboading/widgets/button.dart';
import 'package:onboading/widgets/expandable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({super.key});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const EmployeeDetailsAppbar(),
            SliverFillRemaining(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              text: "Hakim Maroc",
                              size: 23.sp,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isFav = !isFav;
                                });
                              },
                              child: Icon(
                                isFav
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border,
                                color: AppColors.mainBlue,
                                size: 33,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        BigText(
                          text: "House Cleaning",
                          color: AppColors.mainBlue,
                          size: 20.sp,
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.mainBlue,
                                  size: 21,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Sidi Bel Abbés",
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 45,
                                  height: 45,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      // ignore: deprecated_member_use
                                      launch('tel:+0659495111');
                                    },
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    shape: const StadiumBorder(
                                        side: BorderSide(
                                            color: AppColors.mainBlue)),
                                    child: const Icon(
                                      Icons.phone,
                                      color: AppColors.mainBlue,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 45,
                                  height: 45,
                                  child: FloatingActionButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    shape: const StadiumBorder(
                                        side: BorderSide(
                                            color: AppColors.mainBlue)),
                                    child: const Icon(
                                      Icons.email,
                                      color: AppColors.mainBlue,
                                      size: 22,
                                    ),
                                  ),
                                )
                              ],
                            )

                            // RawMaterialButton(
                            //   onPressed: () {},
                            //   elevation: 2.0,
                            //   fillColor: Colors.white,
                            //   child: Icon(
                            //     Icons.email,
                            //     color: AppColors.mainBlue,
                            //     size: 20,
                            //   ),
                            //   padding: EdgeInsets.all(12.0),
                            //   shape: CircleBorder(
                            //       side: BorderSide(color: AppColors.mainBlue)),
                            // )
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              const TabBar(
                                dividerColor: AppColors.mainBlue,
                                indicatorColor: AppColors.mainBlue,
                                labelColor: AppColors.mainBlue,
                                tabs: [
                                  Tab(
                                    text: "About",
                                  ),
                                  Tab(
                                    text: "Ratings",
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: TabBarView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 10),
                                      child: ExpandableText(
                                          text:
                                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt em ipsum dolor sit amet, consectetur aem ipsum dolor sit amet, consectetur adipisc em ipsum dolor sit amet, consectetur adipiscdipisc ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.",
                                          textHeight: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5.63),
                                    ),
                                    Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Expanded(
                //   child: Button(
                //     text: "Message",
                //     color: AppColors.secBlue,
                //   ),
                // ),
                // const SizedBox(
                //   width: 20,
                // ),
                Expanded(
                  child: Button(
                    text: "Book Now",
                    clicked: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
