import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboading/pages/home/home.dart';

import 'workers_list.dart';

class Workers extends StatelessWidget {
  const Workers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Workers',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 21.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CupertinoSearchTextField(
                onChanged: (text) {},
                itemSize: 24,
                placeholderStyle: TextStyle(
                    fontSize: 19.sp,
                    color: const Color.fromARGB(255, 151, 150, 150)),
                backgroundColor: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(30),
                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Icon(
                    Icons.search,
                    size: 32.sp,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: WorkersList(),
            ),
          ],
        ),
      ),
    );
  }
}
