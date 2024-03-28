import 'package:flutter/material.dart';
import 'package:hiwetaan/screens/Profile/profile.dart';
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
    HomeScreen(),
    MyCard(),
    profiletest(),
    //SearchPagePremiumScreen(),
    //Notifications(),
    // QRScannerPage(),
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "My Card"),
            BottomNavigationBarItem(
                icon: Icon(Icons.edit_note), label: "Profile"),
          ],
        ),
        body: myScreenList[currentIndex]
        );
  }
}
