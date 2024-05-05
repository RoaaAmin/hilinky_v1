import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hilinky/screens/Profile/profile.dart';
import 'package:hilinky/screens/Scanner/QRScannerPage.dart';
import 'package:hilinky/screens/home_screen.dart';
import 'package:hilinky/screens/my_card/myCard.dart';
import 'package:easy_localization/easy_localization.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  List myScreenList = [
    //AboutUs(),
    Container(),
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.orange,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme:  IconThemeData(size: 20),
          items:  [

            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: context.tr("About Us") ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: context.tr("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: context.tr("Settings")),
          ],
        ),
        body: myScreenList[currentIndex]
    );
  }
}
