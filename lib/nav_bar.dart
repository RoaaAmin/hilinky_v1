import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hilinky/screens/AboutUs.dart';
import 'package:hilinky/screens/Profile/profile.dart';
import 'package:hilinky/screens/Scanner/QRScannerPage.dart';
import 'package:hilinky/screens/home_screen.dart';
import 'package:hilinky/screens/my_card/myCard.dart';
// import "package:hiwetaan/screens/AboutUs.dart";

class Home extends StatefulWidget {
  final int currentIndex;

  const Home({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  List<Widget> myScreenList = [
    AboutUs(),
    HomeScreen(),
    profiletest(),
    MyCard(),
    profiletest(),
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
          selectedIconTheme: IconThemeData(size: 20),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: context.tr("About Us"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: context.tr("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: context.tr("My Profile"),
            ),
          ],
        ),
      ),
      body: myScreenList[currentIndex],
    );
  }
}

