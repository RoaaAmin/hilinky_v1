import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hilinky/screens/AboutUs.dart';
import 'package:hilinky/screens/Profile/profile.dart';
import 'package:hilinky/screens/Scanner/QRScannerPage.dart';
import 'package:hilinky/screens/home_screen.dart';
// import "package:hiwetaan/screens/AboutUs.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  List myScreenList = [
    AboutUs(),
    HomeScreen(),
    profiletest(),

    //SearchPagePremiumScreen(),
    //Notifications(),
    //QRScannerPage(),
    //Edit(),
    // FollowedScreen(),
    //terms(),
    // const nfc()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF234E5C),
              width: 0.9,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          unselectedItemColor: Color(0xFF234E5C),
          selectedItemColor: Color(0xFFEE6363),
          type: BottomNavigationBarType.fixed,
          selectedIconTheme:  IconThemeData(size: 20),
          items:  [

            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: context.tr("About Us") ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: context.tr("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: context.tr("Settings")),
          ],
        ),
      ),
      body: myScreenList[currentIndex],
    );
  }
}
