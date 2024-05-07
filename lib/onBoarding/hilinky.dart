import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hilinky/onBoarding/welcome.dart';
import 'package:sizer/sizer.dart';

class Hilinky extends StatefulWidget {
  const Hilinky({Key? key}) : super(key: key);

  @override
  _HilinkyState createState() => _HilinkyState();
}

class _HilinkyState extends State<Hilinky> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next page after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 133),
                FadeInDown(
                  delay: const Duration(milliseconds: 800),
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/hilinky.png',
                        width: 100.w,
                        height: 50.h,
                        //fit: BoxFit.cover,
                      ),
                    ),
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
