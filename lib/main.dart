
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hiwetaan/screens/home_screen.dart';
import 'package:hiwetaan/screens/login_screen.dart';
import 'package:hiwetaan/screens/my_card/myCard.dart';
import 'package:hiwetaan/screens/signup_screen.dart';
import 'package:hiwetaan/translations/codegen_loader.g.dart';
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
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );

  runApp(
    EasyLocalization(
      path: 'assets/languages',
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
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
