import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../PrivacyPolicyPage/PrivacyPolicyPage.dart';
import '../auth.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import '../main.dart';
import '../models/SnackBar.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';
import '../widgets/app_bar/appbar_image.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_image_view.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void openSignupScreen() {
    //Navigator.of(context).pushReplacementNamed('PrivacyPolicyPage');
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool obscureText = true;
  bool privacyChecked = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
          resizeToAvoidBottomInset: true, // Enable resizing to avoid the keyboard

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
                  SizedBox(height: 80,),
                  Padding(
                    padding: getPadding(
                      left: 1,
                    ),

                    child: Text(
                      context.tr("Welcome Back!"),
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
                      context.tr(
                          "Happy to see you again, enter your account details"),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          context.tr("Email or Username"),
                          style: theme.textTheme.titleMedium,
                        ),
                        CustomTextFormField(
                          controller: _emailController,
                          // margin: getMargin(
                          //   top: 4,
                          // ),
                          hintText: context.tr("Example@Example.com"),
                          hintStyle: theme.textTheme.titleSmall!,
                          textInputType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: getVerticalSize(99),
                    width: getHorizontalSize(349),
                    margin: getMargin(
                      top: 23,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                context.tr("Password"),
                                style: theme.textTheme.titleMedium,
                              ),
                              CustomTextFormField(
                                controller: _passwordController,
                                obscureText: obscureText,
                                // margin: getMargin(
                                //   top: 3,
                                // ),
                                hintText: context.tr("Your Password"),
                                hintStyle: theme.textTheme.titleSmall!,
                                textInputType: TextInputType.visiblePassword,
                                suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: Container(
                                    margin: getMargin(
                                      left: 30,
                                      top: 15,
                                      right: 16,
                                      bottom: 15,
                                    ),
                                    child: CustomImageView(
                                        svgPath: obscureText
                                            ? ImageConstant
                                                .imgAkariconseyeClose // Closed eye SVG
                                            : ImageConstant
                                                .imgAkariconseyeopen // Open eye SVG
                                        ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            sendRecoveryPass();
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: getPadding(
                                top: 17,
                                right: 4,
                              ),
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [
                                      Color(0xFFEF9453),
                                      Colors.deepOrange,
                                    ],
                                  ).createShader(bounds);
                                },
                                child: Text(
                                  context.tr('Forgot Password?'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    // decoration: TextDecoration.underline,
                                    color: Colors
                                        .white, // Set text color to white for gradient to be visible
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Checkbox(
                          value: privacyChecked,
                          onChanged: (value) {
                            setState(() {
                              privacyChecked = value!;
                            });
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the privacy and policy page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacyPolicyPage(),
                            ),
                          );
                        },
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text.rich(
                            TextSpan(
                              text:  context.tr('By ticking this box I agree that I have read the '),
                              style: CustomTextStyles.labelLargeInterBluegray300,
                              children: [
                                TextSpan(
                                  text:  context.tr('\nPrivacy & Policy'),
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFFEF9453),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PrivacyPolicyPage(),
                                        ),
                                      );
                                    },
                                ),
                                TextSpan(
                                  text: '.',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      width: 370,
                      height: 55, // Adjust the width as per your requirement
                      child: ElevatedButton(
                        onPressed: () {
                          // Check if privacy policy is accepted before login
                          if (privacyChecked) {
                            loginValidation(); // Call loginValidation function
                          } else {
                            showInSnackBar(
                              context.tr('Please accept the privacy policy.'),
                              Colors.red,
                              Colors.white,
                              3,
                              context,
                              _scaffoldKey,
                            );
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF234E5C)),
                        ),
                        child: Text(
                          context.tr("Login"),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don’t have an account",
                                  style: CustomTextStyles.labelLargeInterBluegray300,
                                ),
                                TextSpan(
                                  text: "?",
                                  style: CustomTextStyles.bodyMediumInterBluegray300,
                                ),
                                TextSpan(
                                  text: " ",
                                  style: CustomTextStyles.bodyMediumInterBluegray300,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                          GestureDetector(
                            onTap: openSignupScreen,
                            child: Text(
                              "Sign up Now",
                              style: CustomTextStyles.labelLargeInterDeeporange30013.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      )
                    )
                  )
                ]
              ))
          ))));
    //               Align(
    //                 alignment: Alignment.center,
    //                 child: Padding(
    //                   padding: getPadding(
    //                     top: 25,
    //                     bottom: 5,
    //                   ),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       RichText(
    //                         text: TextSpan(
    //                           children: [
    //                             TextSpan(
    //                               text: context.tr("Don’t have an account"),
    //                               style: CustomTextStyles
    //                                   .labelLargeInterBluegray300,
    //                             ),
    //                             TextSpan(
    //                               text: context.tr("?"),
    //                               style: CustomTextStyles
    //                                   .bodyMediumInterBluegray300,
    //                             ),
    //                           ],
    //                         ),
    //                         textAlign: TextAlign.left,
    //                       ),
    //                       SizedBox(width: 5), // Add space here
    //                       GestureDetector(
    //                         onTap: () async {
    //                           String url =
    //                              "https://api.whatsapp.com/send/?phone=966532595204&text=%D8%A3%D9%87%D9%84%D9%8B%D8%A7%20%D9%81%D8%B1%D9%8A%D9%82%20%D9%87%D8%A7%D9%8A%20%D9%84%D9%8A%D9%86%D9%83%D9%8A%0A%D8%A3%D8%B1%D9%8A%D8%AF%20%D8%A3%D9%86%20%D8%A3%D9%82%D8%AA%D9%86%D9%8A%20%D8%A8%D8%B7%D8%A7%D9%82%D8%A9%20%D8%B1%D9%82%D9%85%D9%8A%D8%A9";
    //                           if (await canLaunch(url)) {
    //                             await launch(url);
    //                           } else {
    //                             throw 'Could not launch $url';
    //                           }
    //                         },
    //                         child: Text(
    //                           context.tr("Contact Us"),
    //                           style: CustomTextStyles
    //                               .labelLargeInterDeeporange30013
    //                               .copyWith(
    //                             decoration: TextDecoration.underline,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }



  void loginValidation() {
    String input = _emailController.text.trim();
    if (input.contains('@') && input.contains('.com')) {
      signIn(input);
    } else {
      signInWithUserName(input);
    }
  }

  Future<void> signInWithEmail(String email) async {
    try {
      UserCredential userCredentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: _passwordController.text,
      );

      if (userCredentials.user?.uid != null) {
        //await updateNotificationToken(userCredentials.user!.uid);
        if (!userCredentials.user!.emailVerified) {
          clearControllers();
          //await sendEmailVerification(userCredentials.user!);
        } else {
          // await navigateToAuthPage(userCredentials.user!.uid);
        }
      }
    } on FirebaseAuthException catch (e) {
      showInSnackBar(context.tr('Login failed, incorrect account information.'),
          Colors.red, Colors.white, 2, context, _scaffoldKey);
    }
  }

  Future<void> signInWithUserName(String username) async {
    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('uniqueUserName', isEqualTo: username)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        String userEmail = userSnapshot.docs[0].get('sUserEmail');
        await signIn(userEmail);
      } else {
        showInSnackBar(
            context.tr('No user found with the provided email/username.'),
            Colors.red,
            Colors.white,
            2,
            context,
            _scaffoldKey);
      }
    } catch (e) {
      showInSnackBar(context.tr('An error occurred while logging in.'),
          Colors.red, Colors.white, 2, context, _scaffoldKey);
    }
  }

  Future signIn(String userEmail) async {
    print('Authentication Started.......');
    try {
      String input = _emailController.text.trim();
      if (input.contains('@') && input.contains('.com')) {
        String input = _emailController.text.trim();
      } else {
        input = userEmail;
      }

      // Check if input is an email
      if (input.contains('@') && input.contains('.com')) {
        UserCredential userCredentials =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: input,
          password: _passwordController.text,
        );

        if (userCredentials.user?.uid != null) {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userCredentials.user!.uid)
              .update({
            'FBNotificationToken': notificationToken,
          });

          if (userCredentials.user?.emailVerified == false) {
            clearControllers();
            await userCredentials.user?.sendEmailVerification();
            await FirebaseAuth.instance.signOut().then((value) {
              showInSnackBar(
                  context.tr(
                      'Oops, Your email is not verified, Please verify your email'),
                  Colors.amber[800]!,
                  Colors.white,
                  3,
                  context,
                  _scaffoldKey);
            }).then((metaData) async {
              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userCredentials.user!.uid)
                  .get()
                  .then((userDataInfo) {
                setState(() {
                  sUserID = userCredentials.user!.uid;
                  sUserEmail = userDataInfo.data()!['sUserEmail'];
                  uniqueUserName = userDataInfo.data()!['uniqueUserName'];
                  sUserPhoneNumber = userDataInfo.data()!['sUserPhoneNumber'];
                  sUserNotificationToken =
                      userDataInfo.data()!['sUserNotificationToken'];
                });
              });
            });
          } else {
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(userCredentials.user?.uid)
                .get()
                .then((userDoc) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  builder: (BuildContext context) => Auth()));
            });
          }
        }
      } else {
        // Check if input is a username
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .where('uniqueUserName', isEqualTo: input)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          String userEmail = userSnapshot.docs[0].get('sUserEmail');
          UserCredential userCredentials =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userEmail,
            password: _passwordController.text,
          );

          if (userCredentials.user?.uid != null) {
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(userCredentials.user!.uid)
                .update({
              'FBNotificationToken': notificationToken,
            });

            if (userCredentials.user?.emailVerified == false) {
              clearControllers();
              await userCredentials.user?.sendEmailVerification();
              await FirebaseAuth.instance.signOut().then((value) {
                showInSnackBar(
                    context.tr(
                        'Oops, Your email is not verified, Please verify your email'),
                    Colors.amber[800]!,
                    Colors.white,
                    3,
                    context,
                    _scaffoldKey);
              }).then((metaData) async {
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userCredentials.user!.uid)
                    .get()
                    .then((userDataInfo) {
                  setState(() {
                    sUserID = userCredentials.user!.uid;
                    sUserEmail = userDataInfo.data()!['sUserEmail'];
                    uniqueUserName = userDataInfo.data()!['uniqueUserName'];
                    sUserPhoneNumber = userDataInfo.data()!['sUserPhoneNumber'];
                    sUserNotificationToken =
                        userDataInfo.data()!['sUserNotificationToken'];
                  });
                });
              });
            } else {
              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userCredentials.user?.uid)
                  .get()
                  .then((userDoc) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (BuildContext context) => Auth()));
              });
            }
          }
        } else {
          // No user found with the provided email/username
          // Handle this case (e.g., show an error message)
          return;
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showInSnackBar(context.tr('Login failed, incorrect account information.'),
          Colors.red, Colors.white, 3, context, _scaffoldKey);
    }
  }

  clearControllers() {
    _emailController.clear();
    _passwordController.clear();
  }

  sendRecoveryPass() async {
    if (_emailController.text == null ||
        _emailController.text.contains('@') == false ||
        _emailController.text.contains('.com') == false) {
      showInSnackBar(context.tr('Invalid Email or Username'), Colors.red,
          Colors.white, 2, context, _scaffoldKey);
    } else {
      await FirebaseFirestore.instance
          .collection('Users')
          .where('sUserEmail', isEqualTo: _emailController.text)
          .get()
          .then((whereResult) async {
        if (whereResult == null && whereResult.docs.isEmpty) {
          showInSnackBar(context.tr('There is no record for this email'),
              Colors.red, Colors.white, 3, context, _scaffoldKey);
          _passwordController.clear();
        } else {
          try {
            await FirebaseAuth.instance
                .sendPasswordResetEmail(email: _emailController.text)
                .then((metaData) {
              showInSnackBar(context.tr('Reset password email has been sent'),
                  Colors.green, Colors.white, 2, context, _scaffoldKey);
              _passwordController.clear();
            });
          } catch (e) {
            showInSnackBar('There is no record for this email', Colors.red,
                Colors.white, 3, context, _scaffoldKey);
          }
        }
      });
    }
  }
}
