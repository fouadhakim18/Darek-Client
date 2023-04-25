import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboading/widgets/button.dart';

import '../../widgets/email_input.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 21.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/Forgot password-cuate 1.png'),
              Padding(
                padding: const EdgeInsets.only(top: 45, bottom: 35),
                child: Text(
                  'Enter your email and we will send you a verification link',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              const EmailInput(),
              const SizedBox(
                height: 60,
              ),
              Button(text: "Continue", clicked: (){},)
            ],
          ),
        ),
      ),
    );
  }
}
