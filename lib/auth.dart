import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hiwetaan/screens/home_screen.dart';
import 'package:hiwetaan/screens/login_screen.dart';

import 'nav_bar.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              // if user already logged in
              return const Home();
              //Home()
              // no data else
            } else {
              return LoginScreen();
            }
          })),
    );
  }
}
