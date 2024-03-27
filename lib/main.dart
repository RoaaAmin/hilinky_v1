
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hiwetaan/screens/home_screen.dart';
import 'package:hiwetaan/screens/login_screen.dart';
import 'package:hiwetaan/screens/my_card/myCard.dart';
import 'package:hiwetaan/screens/signup_screen.dart';
import 'auth.dart';

import 'firebase_options/firebase_options.dart';

final user = FirebaseAuth.instance.currentUser;
final userId = user!.uid;

String sUserID = ' ';
String sUserName = ' ';
String sUserEmail = ' ';
String sUserPhoneNumber = ' ';
String sUserNotificationToken = ' ';
String userProfileImage = ' ';
String uniqueUserName =' ';
String sNationality= ' ';
String sCity= ' ';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const Auth(),
        'homeScreen': (context) =>   HomeScreen(),
        'signupScreen': (context) =>  SignupScreen(),
        'loginScreen':  (context) =>  LoginScreen(),
        'myCard': (context) =>  MyCard(),
      },

    );

  }
}
