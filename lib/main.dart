import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hilinky/screens/home_screen.dart';
import 'package:hilinky/screens/login_screen.dart';
import 'package:hilinky/screens/my_card/myCard.dart';
import 'package:hilinky/screens/signup_screen.dart';
import 'package:hilinky/translations/codegen_loader.g.dart';
import 'auth.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options/firebase_options.dart';
import 'onBoarding/hilinky.dart';

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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Satoshi'),
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        title: 'Flutter Demo',
        routes: {
          '/': (context) =>  const Auth(),
          'homeScreen': (context) =>  HomeScreen(),
          'signupScreen': (context) =>  SignupScreen(),
          'loginScreen':  (context) =>  LoginScreen(),
          'myCard': (context) =>  MyCard(),
        },
      ),
    );
  }
}
