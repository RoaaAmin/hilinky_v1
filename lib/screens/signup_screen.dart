import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilinky/screens/login_screen.dart';
import 'package:line_icons/line_icons.dart';

import '../auth.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import '../main.dart';
import '../models/SnackBar.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';
import '../widgets/custom_image_view.dart';
import '../widgets/custom_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  /// user info
  String Error = '';
  bool obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordConroller = TextEditingController();
  TextEditingController _confirmPasswordConroller = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  void openLoginScreen() {
    Navigator.of(context).pushReplacementNamed('loginScreen');
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordConroller.text.trim(),
      );
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  bool passwordConfirmed() {
    if (_passwordConroller.text.trim() ==
        _confirmPasswordConroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordConroller.dispose();
    _confirmPasswordConroller.dispose();
    usernameController.dispose();
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? notificationToken;

  @override
  void initState() {
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      setState(() {
        notificationToken = token;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return GestureDetector(
        onTap: () {
          // Dismiss the keyboard when tapped outside of any text field
          FocusScope.of(context).unfocus();
        },
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                backgroundColor: appTheme.whiteA700,
                resizeToAvoidBottomInset:
                    true, // Enable resizing to avoid the keyboard

                body: SingleChildScrollView(
                    // Enable scrolling
                    child: Container(
                        width: double.maxFinite,
                        padding: getPadding(
                          left: 24,
                          top: 21,
                          right: 24,
                          bottom: 21,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 1,
                                ),
                                child: Text(
                                  context.tr("Sign Up"),
                                  style: theme.textTheme.displaySmall,
                                ),
                              ),
                              Container(
                                width: getHorizontalSize(302),
                                margin: getMargin(
                                  left: 1,
                                  top: 13,
                                  right: 41,
                                ),
                                child: Text(
                                  context.tr("Create your account."),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    height: 1.56,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 1,
                                  top: 25,
                                ),
                                child: Container(
                                  width: double
                                      .maxFinite, // Set the width to occupy the entire available space
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // First Name field
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  context.tr("First Name"),
                                                  style: theme
                                                      .textTheme.titleMedium,
                                                ),
                                                CustomTextFormField(
                                                  controller: nameController,
                                                  hintText: context
                                                      .tr("Your First Name"),
                                                  hintStyle: theme
                                                      .textTheme.titleSmall!,
                                                  textInputType:
                                                      TextInputType.text,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              25), // Adjust spacing as needed

                                      // Last Name field
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  context.tr("Last Name"),
                                                  style: theme
                                                      .textTheme.titleMedium,
                                                ),
                                                CustomTextFormField(
                                                  controller:
                                                      lastNameameController,
                                                  hintText: context
                                                      .tr("Your Last Name"),
                                                  hintStyle: theme
                                                      .textTheme.titleSmall!,
                                                  textInputType:
                                                      TextInputType.text,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              25), // Adjust spacing as needed
                                      //SizedBox(height: 10),
                                      // Username
                                      Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        context.tr("Username"),
                                                        style: theme.textTheme
                                                            .titleMedium,
                                                      ),
                                                      CustomTextFormField(
                                                        controller:
                                                            usernameController,
                                                        hintText: context.tr(
                                                            "Your Username"),
                                                        hintStyle: theme
                                                            .textTheme
                                                            .titleSmall!,
                                                        textInputType:
                                                            TextInputType.text,
                                                      )
                                                    ])),
                                          ]),
                                      SizedBox(height: 25),

                                      //pass
                                      Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        context.tr("Email"),
                                                        style: theme.textTheme
                                                            .titleMedium,
                                                      ),
                                                      CustomTextFormField(
                                                        controller:
                                                            _emailController,
                                                        hintText: context.tr(
                                                            "Example@Example.com"),
                                                        hintStyle: theme
                                                            .textTheme
                                                            .titleSmall!,
                                                        textInputType:
                                                            TextInputType
                                                                .emailAddress,
                                                      )
                                                    ])),
                                          ]),
                                      SizedBox(height: 25),
                                      // phone num
                                      Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        context
                                                            .tr("Phone Number"),
                                                        style: theme.textTheme
                                                            .titleMedium,
                                                      ),
                                                      CustomTextFormField(
                                                        controller:
                                                            phoneNumberController,
                                                        hintText: context
                                                            .tr("05********"),
                                                        hintStyle: theme
                                                            .textTheme
                                                            .titleSmall!,
                                                        textInputType:
                                                            TextInputType.phone,
                                                      )
                                                    ])),
                                          ]),
                                      SizedBox(height: 10),

                                      //pass
                                      Padding(
                                        padding: EdgeInsets.only(left: 1, top: 25),
                                        child: PasswordField(
                                          controller: _passwordConroller,
                                          hintText: 'Your Password',
                                          hintStyle: theme.textTheme.titleSmall!,
                                          labelStyle: theme.textTheme.titleMedium!,
                                          label: 'Password',
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 1, top: 25),
                                        child: PasswordField(
                                          controller: _confirmPasswordConroller,
                                          hintText: 'Confirm Your Password',
                                          hintStyle: theme.textTheme.titleSmall!,
                                          labelStyle: theme.textTheme.titleMedium!,
                                          label: 'Confirm Password',
                                        ),
                                      ),

                                      //SizedBox(height: 15),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 20),
// sign up button
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        child: GestureDetector(
                                          onTap: signUpValidation,
                                          child: Container(
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                color: Color(0xFF234E5C),
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            child: Center(
                                                child: Text(
                                                    context.tr('Sign up'),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                top: 25,
                                                bottom: 5,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                        context.tr("Already have an account"),
                                                          style: CustomTextStyles
                                                              .labelLargeInterBluegray300,
                                                        ),
                                                        TextSpan(
                                                          text: context.tr("?"),
                                                          style: CustomTextStyles
                                                              .bodyMediumInterBluegray300,
                                                        ),
                                                        TextSpan(
                                                          text: " ",
                                                          style: CustomTextStyles
                                                              .bodyMediumInterBluegray300,
                                                        ),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  GestureDetector(
                                                    onTap: openLoginScreen,
                                                    child: Text(
                                                      context.tr("Login Now"),
                                                      style: CustomTextStyles
                                                          .labelLargeInterDeeporange30013
                                                          .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))),
                                    ],
                                  ),
                                ),
                              )
                            ]))))));
  }

//////////////////////////////////////////////

  void signUpValidation() {
    if (nameController.text == null || nameController.text.length < 3) {
      showInSnackBar(context.tr('Please Enter a valid name.'), Colors.red, Colors.white,
          2, context, _scaffoldKey);
    } else if (_emailController.text == null ||
        _emailController.text.contains('@') == false ||
        _emailController.text.contains('.com') == false) {
      showInSnackBar(
          context.tr('Invalid Email'), Colors.red, Colors.white, 2, context, _scaffoldKey);
    } else if (phoneNumberController.text == null ||
        phoneNumberController.text.contains('05') == false ||
        phoneNumberController.text.length < 10 ||
        phoneNumberController.text.length > 10) {
      showInSnackBar(context.tr('Please enter your phone number correctly, ex: 05********'),
          Colors.red, Colors.white, 2, context, _scaffoldKey);
    } else if (_passwordConroller.text == null ||
        _passwordConroller.text.length < 6) {
      showInSnackBar(context.tr('Password is too weak.'), Colors.red, Colors.white, 2,
          context, _scaffoldKey);
    } else if (_passwordConroller.text != _confirmPasswordConroller.text) {
      showInSnackBar(context.tr('Passwords do not match.'), Colors.red, Colors.white, 2,
          context, _scaffoldKey);
    } else if (usernameController.text == null ||
        usernameController.text.isEmpty) {
      showInSnackBar(context.tr('Please enter a valid username.'), Colors.red, Colors.white,
          2, context, _scaffoldKey);
    } else {
      checkUsernameAvailability();
      print('Validation Completed');
      //signup();
    }
  }

  Future checkUsernameAvailability() async {
    try {
      QuerySnapshot usernameSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('uniqueUserName', isEqualTo: usernameController.text)
          .get();

      if (usernameSnapshot.docs.isNotEmpty) {
        showInSnackBar(context.tr('Username is already taken.'), Colors.red, Colors.white,
            2, context, _scaffoldKey);
      } else {
        print('Validation Completed');
        signup(); // Proceed with signup if username is available
      }
    } catch (e) {
      // Handle error if the query fails
      print('Error checking username availability: $e');
    }
  }

//
  Future signup() async {
    DocumentSnapshot<Map<String, dynamic>> userData;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordConroller.text,
      )
          .then((userCredentials) async {
        if (userCredentials.user != null) {
          await userCredentials.user!
              .sendEmailVerification()
              .then((metaData) async {
            try {
              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userCredentials.user!.uid)
                  .set({
                'sUserID': userCredentials.user!.uid,
                'sUserEmail': userCredentials.user!.email,
                'sUserName': nameController.text,
                'LastName': lastNameameController.text,
                'sUserPhoneNumber': phoneNumberController.text,
                'sUserNotificationToken': notificationToken,
                'uniqueUserName': usernameController.text,
               // 'password' : _passwordConroller.text,
                // 'sNationality': selectedNationality,
                // 'sCity': selectedCity,
                'AccountCreatedDateTime': DateTime.now(),
                'UserProfileImage':
                    'https://raw.githubusercontent.com/RoaaAmin/hilinky_v1/main/assets/images/HilinkyLogo.png',
                'following': {}
              }).then((value) async {
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userCredentials.user!.uid)
                    .get()
                    .then((userDBData) async {
                  setState(() {
                    userData = userDBData;
                    sUserID = userCredentials.user!.uid;
                    sUserEmail = userDBData.data()!['sUserEmail'];
                    sUserName = userDBData.data()!['sUserName'];
                    LastName = userDBData.data()!['LastName'];
                    uniqueUserName = userDBData.data()!['uniqueUserName'];
                    sUserPhoneNumber = userDBData.data()!['sUserPhoneNumber'];
                    // password = userDBData.data()!['password'];
                    // sNationality = userDBData.data()!['sNationality'];
                    // sCity = userDBData.data()!['sCity'];
                    sUserNotificationToken =
                        userDBData.data()!['sUserNotificationToken'];
                  });
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  clearControllers();
                  await FirebaseAuth.instance.signOut();
                  showInSnackBar(
                      context.tr( 'Registration completed, check your email to verify'),
                      Colors.green,
                      Colors.white,
                      5,
                      context,
                      _scaffoldKey);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              });
            } catch (e) {
              await FirebaseAuth.instance.currentUser!
                  .delete()
                  .then((value) async {
                await FirebaseAuth.instance.signOut().then((value) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  showInSnackBar('An error occur!', Colors.red, Colors.white, 3,
                      context, _scaffoldKey);
                  print('$e');
                });
              });
            }
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showInSnackBar(e.message!.trim(), Colors.red, Colors.white, 3, context,
          _scaffoldKey);
    }
  }

  clearControllers() {
    usernameController.clear();
    lastNameameController.clear();
    _emailController.clear();
    _passwordConroller.clear();
    _confirmPasswordConroller.clear();
    nameController.clear();
    phoneNumberController.clear();
    _emailController.clear();
  }
}
//
