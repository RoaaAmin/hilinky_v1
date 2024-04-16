import 'package:flutter/material.dart';
import 'package:hiwetaan/screens/Profile/profile.dart';
import 'package:hiwetaan/screens/QRScannerPage.dart';
import 'package:hiwetaan/screens/home_screen.dart';
import 'package:hiwetaan/screens/my_card/myCard.dart';

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
          selectedIconTheme: const IconThemeData(size: 20),
          items: const [

            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "About Us"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
        body: myScreenList[currentIndex]
        );
  }
}
