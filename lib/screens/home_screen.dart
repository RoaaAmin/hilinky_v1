import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilinky/components/context.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:line_icons/line_icons.dart';
import '../auth.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import '../theme/theme_helper.dart';
import '../widgets/app_bar/appbar_image.dart';
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
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    print('Checking for Update');
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        print('Update available');
        showUpdateDialog();
      }
    }).catchError((e) {
      print('Error checking for update: $e');
    });
  }

  void showUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.tr('Update Available'),style: TextStyle(color: Color(0XFFEE6363),)),
          content: Text(
        context.tr( 'A new version of the app is available. Please update to the latest version to continue using the app.'),style: TextStyle(color: Color.fromARGB(255, 2, 84, 86)),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.tr('Not Now'),style: TextStyle(color: Color.fromARGB(255, 2, 84, 86)),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                update();
              },
              child: Text(context.tr('Update'),style: TextStyle(color: Color.fromARGB(255, 2, 84, 86))),
            ),
          ],
        );
      },
    );
  }

  void update() async {
    print('Updating');
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      print('Error completing update: $e');
    });
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
          return Center(child: CircularProgressIndicator()); // Example loading indicator
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
      backgroundColor: appTheme.whiteA700,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: double.maxFinite,
        leading: AppbarImage(
          imagePath: ImageConstant.hilinkylogopng,
          margin: getMargin(
            // left: 11,
            right: 6,
          ),
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
          side: BorderSide(
            color: Color(0xFF234E5C),
          ),
        ),
        title: Text(context.tr('Home Screen')),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.tr('Start your journey by creating your card'),
              style: TextStyle(
                color: Color(0xFF234E5C),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0.21,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  context.pushPage(CreateCard());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF234E5C),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  context.tr('Create Card'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0.07,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.orange.shade300,
                Colors.deepOrange.shade400
              ],
              end: Alignment.topLeft,
              begin: Alignment.bottomRight
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            context.pushPage(QRScannerPage());
          },
          child: Icon(Icons.qr_code_scanner),
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent, // Set background color to transparent
          elevation: 0, // Remove the shadow effect
        ),
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
