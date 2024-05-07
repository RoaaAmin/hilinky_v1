import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Navigator.of(context).pushReplacementNamed('PrivacyPolicyPage');
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool obscureText = true;
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

    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA700,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              leadingWidth: double.maxFinite,
              leading: AppbarImage(
                // svgPath: ImageConstant.hilinkyBg_logo,
                margin: getMargin(
                  left: 11,
                  top: 12,
                  right: 351,
                  bottom: 12,
                ),
              ),
            ),
            body: Form(
              //key: _scaffoldKey,
                child: Container(
                    width: double.maxFinite,
                    padding: getPadding(
                      left: 24,
                      top: 21,
                      right: 24,
                      bottom: 21,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
                                context.tr("Happy to see you again, enter your account details"),
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
                                    margin: getMargin(
                                      top: 4,
                                    ),
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
                                          context.tr( "Password"),
                                          style: theme.textTheme.titleMedium,
                                        ),
                                        CustomTextFormField(
                                          controller: _passwordController,
                                          obscureText: obscureText,
                                          margin: getMargin(
                                            top: 3,
                                          ),
                                          hintText: context.tr("Your Password"),
                                          hintStyle: CustomTextStyles.titleMediumGray90002,
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
                                                      ? ImageConstant.imgAkariconseyeClose// Closed eye SVG
                                                      : ImageConstant.imgAkariconseyeopen  // Open eye SVG
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
                            GestureDetector(
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
                                  child: Text(
                                    context.tr('Forgot Password?'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFFEF9453),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xFFEF9453), // Change the underline color here
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CustomElevatedButton(
                              onTap: loginValidation,
                              text: context.tr("Login"),
                              margin: getMargin(
                                top: 22,
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: Padding(
                            //     padding: getPadding(
                            //       top: 25,
                            //       bottom: 5,
                            //     ),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         RichText(
                            //           text: TextSpan(
                            //             children: [
                            //               TextSpan(
                            //                 text: context.tr("Don’t have an account"),
                            //                 style: CustomTextStyles.labelLargeInterBluegray300,
                            //               ),
                            //               TextSpan(
                            //                 text: context.tr("?"),
                            //                 style: CustomTextStyles.bodyMediumInterBluegray300,
                            //               ),
                            //               TextSpan(
                            //                 text: " ",
                            //                 style: CustomTextStyles.bodyMediumInterBluegray300,
                            //               ),
                            //             ],
                            //           ),
                            //           textAlign: TextAlign.left,
                            //         ),
                            //         GestureDetector(
                            //           onTap: openSignupScreen,
                            //           child: Text(
                            //             context.tr("Sign up Now"),
                            //             style: CustomTextStyles.labelLargeInterDeeporange30013.copyWith(
                            //               decoration: TextDecoration.underline,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),)
                          ]),
                    ))))
    );
  }

  // void loginValidation(){
  //   if(_emailController.text==null||_emailController.text.contains('@')==false||_emailController.text.contains('.com')==false){
  //     showInSnackBar('Invalid Email/Username', Colors.red, Colors.white, 2, context, _scaffoldKey);
  //   }else if(_passwordController.text==null||_passwordController.text.length<6){
  //     showInSnackBar('Invalid Password', Colors.red, Colors.white, 2, context, _scaffoldKey);
  //   }else{
  //     print('Validation Completed');
  //     signIn();
  //   }
  // }

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
      showInSnackBar(context.tr('Login failed, incorrect account information.'), Colors.red,
          Colors.white, 2, context, _scaffoldKey);
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
        showInSnackBar(context.tr('No user found with the provided email/username.'),
            Colors.red, Colors.white, 2, context, _scaffoldKey);
      }
    } catch (e) {
      showInSnackBar(context.tr('An error occurred while logging in.'), Colors.red,
          Colors.white, 2, context, _scaffoldKey);
    }
  }

  Future signIn(String userEmail) async {
    print('Authentication Started.......');
    try {
      String input = _emailController.text.trim();
      if (input.contains('@') && input.contains('.com')) {
        String input=_emailController.text.trim();
      } else {
        input=userEmail;
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
                  context.tr('Oops, Your email is not verified, Please verify your email'),
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
                    context.tr('Oops, Your email is not verified, Please verify your email'),
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
      showInSnackBar(context.tr('Login failed, incorrect account information.'), Colors.red,
          Colors.white, 3, context, _scaffoldKey);
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
      showInSnackBar(context.tr('Invalid Email or Username'), Colors.red, Colors.white, 2,
          context, _scaffoldKey);
    } else {
      await FirebaseFirestore.instance
          .collection('Users')
          .where('sUserEmail', isEqualTo: _emailController.text)
          .get()
          .then((whereResult) async {
        if (whereResult == null && whereResult.docs.isEmpty) {
          showInSnackBar(context.tr('There is no record for this email'), Colors.red,
              Colors.white, 3, context, _scaffoldKey);
          _passwordController.clear();
        } else {
          try {
            await FirebaseAuth.instance
                .sendPasswordResetEmail(email: _emailController.text)
                .then((metaData) {
              showInSnackBar(context.tr('Reset password email has been sent'), Colors.green,
                  Colors.white, 2, context, _scaffoldKey);
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
