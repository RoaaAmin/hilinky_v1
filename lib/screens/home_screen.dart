import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiwetaan/components/context.dart';
import 'package:line_icons/line_icons.dart';
import '../auth.dart';
import 'Profile/profile.dart';
import 'Scanner/QRScannerPage.dart';
import 'create_card/create_card.dart';
import 'login_screen.dart';
import 'my_card/myCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var UserProfileImage;
  Widget currentScreen = const HomeScreen();
  late DocumentSnapshot<Map<String, dynamic>> userData;
  late QuerySnapshot<Map<String, dynamic>> postsDocs;

  var userId = FirebaseAuth.instance.currentUser!.uid;

  var name = '';
  Map<String, dynamic> Links = {};

  void getuser() async {
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    setState(() {
      name = user.data()!['sUserName'];
    });
  }

  @override
  void initState() {
    super.initState();
    getLinks();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('Cards')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data to load, display a loading indicator or
          // any other UI element you prefer.
          return CircularProgressIndicator(); // Example loading indicator
        } else if (snapshot.hasError) {
          // If an error occurs while fetching data, display an error message.
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          // If no card data exists for the user, display the default home screen.
          return _buildDefaultHomeScreen();
        } else {
          // If card data exists, display the MyCard screen.
          return MyCard();
        }
      },
    );
  }

  Widget _buildDefaultHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Start your journey by creating your card",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.pushPage(CreateCard());
              },
              child: Text('Create Card'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushPage(QRScannerPage());
        },
        child: Icon(Icons.qr_code_scanner),
      ),
    );
  }


  void getLinks() async {
    await FirebaseFirestore.instance
        .collection('Cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        UserProfileImage = value.data()!['ImageURL'];

        Links.clear();
        Links = value.data()!['Links'];
        Links.removeWhere((key, value) => value == '');
      },
    );
  }
}
