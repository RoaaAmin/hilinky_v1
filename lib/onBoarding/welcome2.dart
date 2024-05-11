
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hilinky/onBoarding/welcome3.dart';
import 'package:hilinky/screens/login_screen.dart';

import 'package:sizer/sizer.dart';
import 'package:animate_do/animate_do.dart';

class Welcome2 extends StatelessWidget {
  const Welcome2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                FadeInDown(
                  delay: const Duration(milliseconds: 1100),
                  duration: const Duration(milliseconds: 1200),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child:  Text(
                        context.tr('Skip All'),
                        style: TextStyle(
                          color: Color(0xFF133039),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                FadeInDown(
                  delay: const Duration(milliseconds: 800),
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/shakeHand.png',
                        width: 100.w,
                        height: 45.h,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 1.6.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInUp(
                              delay: const Duration(milliseconds: 700),
                              duration: const Duration(milliseconds: 800),
                              child: Text(
                                context.tr('Discover Professionals'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 23.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            FadeInUp(
                              delay: const Duration(milliseconds: 900),
                              duration: const Duration(milliseconds: 1000),
                              child: Text(
                                context.tr( 'Expand your network and connect with professionals from various fields.'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 1000),
                        duration: const Duration(milliseconds: 1100),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Welcome3(),
                                    ),
                                  );
                                },
                                child: FadeInUp(
                                  delay: const Duration(milliseconds: 1100),
                                  duration: const Duration(milliseconds: 1200),
                                  child: Text(
                                    context.tr('Next'),
                                    style: TextStyle(
                                      color: Colors.white, // Set the text color to white
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Satoshi',
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Satoshi',
                                  ),
                                  backgroundColor: Color(0xFF234E5C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
