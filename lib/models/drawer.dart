import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../auth.dart';
import '../main.dart';
import '../screens/login_screen.dart';


class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 50.0),
              child: Text(
                userProfileImage + "\n" "Hi " + sUserName + "\n"+  sUserEmail,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

            ),
            ListTile(
              leading: Icon(
                LineIcons.home,
                color: Colors.amber,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => Auth()));
              },
            ),
            ListTile(
              leading: Icon(
                LineIcons.edit,
                color: Colors.amber,
              ),
              title: Text(
                "Edit Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                //Navigator.pushNamed(context, editProfileViewRoute);
              },
            ),
            ListTile(
              leading: Icon(
                LineIcons.locationArrow,
                color: Colors.amber,
              ),
              title: Text(
                "My Location",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                try {
                  //Navigator.pushNamed(context, locationViewRoute);
                } catch (e, s) {
                  print(s);
                }
              },
            ),
            ListTile(
                leading: Icon(
                  LineIcons.cogs,
                  color: Colors.amber,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                 // Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => settingPage()));
                }),
            ListTile(

                leading: Icon(LineIcons.user, color: Colors.amber),
                title: Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  print('Signing Out User.....');
                  try {
                    await FirebaseAuth.instance.signOut().then((metaData) {
                      print('SignOut Completed...');
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => LoginScreen()));
                    });
                  } catch (e) {
                    print('An error occur during signing user out.');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
