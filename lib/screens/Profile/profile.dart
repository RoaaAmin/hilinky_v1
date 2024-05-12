import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hilinky/components/context.dart';
import 'package:hilinky/screens/Profile/edit_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../auth.dart';
import '../../nav_bar.dart';
import '../../theme/theme_helper.dart';
import 'edit.dart';
import 'language.dart';
import 'notifications.dart';
class profiletest extends StatefulWidget {
  profiletest({
    super.key,
  });

  @override
  profiletestState createState() {
    return profiletestState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class profiletestState extends State<profiletest> {
  Map<String, dynamic> Links = {};
  var UserProfileImage;
  int selectedOption = 1;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.platform
        .getImageFromSource(source: source); //pickImage
    print('printing source of image $source');
    setState(() {
      selectedImage = File(image!.path);
    });
  }


  void getLinks() async {
    await FirebaseFirestore.instance
        .collection('Cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
          (value) {
        setState(() {
          UserProfileImage = value.data()!['ImageURL'];
          print('-----------------------------------------------');
          print(UserProfileImage);
          Links.clear();
          Links = value.data()!['Links'];
          Links.removeWhere((key, value) => value == '');
        });
      },
    );
    print('end');
    print(Links.length);
  }

  List<DocumentSnapshot<Map<String, dynamic>>> postsDocs = [];
  bool postsFetched = false;
  DocumentSnapshot<Map<String, dynamic>>? userData;

  getPosts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUID = user.uid;

      await FirebaseFirestore.instance
          .collection('Posts')
          .where('PostedByUID', isEqualTo: userUID)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          setState(() {
            postsDocs = value.docs.toList();
            postsFetched = true;
          });
          postsDocs.sort((a, b) =>
              b.data()!['TimeStamp'].compareTo(a.data()!['TimeStamp']));
        }
      });
    }
  }

  var FirstName = '';
  var LastName = '';
  var Position = '';
  var CompanyName = '';
  var uniqueUserName = '';
  var image;
  File? selectedImage;

  void getUserInfo() async {
    var user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      uniqueUserName = user.data()!['uniqueUserName'];
    });
  }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        userData = value;
        image = value.data()!['UserProfileImage'];
        getPosts();
      });
    });
  }



  void getCardInfo() async {
    await FirebaseFirestore.instance
        .collection('Cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
          (value) {
        setState(() {
          FirstName = value.data()!['FirstName'];
          LastName = value.data()!['LastName'];
          Position = value.data()!['Position'];
          CompanyName = value.data()!['CompanyName'];
        });
      },
    );
  }

  @override
  void initState() {
    getLinks();
    getCardInfo();
    getUserData();
    getUserInfo();
    super.initState();
  }

//icons
  Map<String, FaIcon> l = {
    'facebook': const FaIcon(FontAwesomeIcons.facebook),
    'twitter': const FaIcon(FontAwesomeIcons.twitter),
    'linkedin': const FaIcon(FontAwesomeIcons.linkedin),
    'youtube': const FaIcon(FontAwesomeIcons.youtube),
    'instagram': const FaIcon(FontAwesomeIcons.instagram),
    'telegram': const FaIcon(FontAwesomeIcons.telegram),
    'whatsapp': const FaIcon(FontAwesomeIcons.whatsapp),
    'github': const FaIcon(FontAwesomeIcons.github),
    'discord': const FaIcon(FontAwesomeIcons.discord),
    'figma': const FaIcon(FontAwesomeIcons.figma),
    'dribbble': const FaIcon(FontAwesomeIcons.dribbble),
    'behance': const FaIcon(FontAwesomeIcons.behance),
    'location': const FaIcon(FontAwesomeIcons.location),
  };

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<profiletestState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<String> keys = Links.keys.toList();
    List<dynamic> values = Links.values.toList();
    // Build a Form widget using the _formKey created above.
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  '../Progile/screens/assets/images/hilinkybg.svg'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            shape: OvalBorder(
                              side: BorderSide(width: 1.50, color: Color(0xFF2E8DAC)),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(image ?? ''),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                            // shape: BoxShape.circle,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.blueGrey.withOpacity(0.5),
                            //     spreadRadius: 5,
                            //     blurRadius: 7,
                            //     offset: Offset(0, 3),
                            //   ),
                            // ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          context.tr("$FirstName" + " $LastName"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF286F8C),
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Text(
                          context.tr("$Position - $CompanyName"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF133039),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40,
                              child: Links.isEmpty
                                  ? Text(context.tr('No links'))
                                  : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: Links.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(8),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.orange,
                                                Colors.deepOrange
                                              ],
                                              end: Alignment.topLeft,
                                              begin: Alignment.bottomRight),
                                        ),
                                        width: 35,
                                        height: 35,
                                        child: Center(
                                          child: IconButton(
                                            isSelected: true,
                                            iconSize: 20,
                                            onPressed: () {
                                              final Uri url =
                                              Uri.parse(values[index]);
                                              _launchUrl(url);
                                            },
                                            icon: Icon(l[keys[index]]!.icon),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 8),
                          decoration: BoxDecoration(
                              border: Border.all(style: BorderStyle.solid,color: Color(0xFF286F8C)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          height: 215,
                          width: 361,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 39,
                                        height: 39,
                                        // decoration: ShapeDecoration(
                                        //   shape: OvalBorder(
                                        //     side: BorderSide(width: 2, color: Color(0xFF286F8C)),
                                        //   ),
                                        // ),
                                      ),
                                      Container(
                                        padding:
                                        const EdgeInsets.only(left: 10, top: 11),
                                        child: const Icon(
                                          Icons.person_outline_rounded,
                                          size: 20,
                                          color: Color(0xFFEF9D52),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.pushPage(Edit());
                                    },
                                    child: Text(
                                      context.tr("Edit Profile Information"),
                                      style: TextStyle(
                                        color: Color(0xFF141619),
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: -0.10,),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 39,
                                        height: 39,
                                        // decoration: ShapeDecoration(
                                        //   shape: OvalBorder(
                                        //     side: BorderSide(width: 2, color: Color(0xFF286F8C)),
                                        //   ),
                                        // ),
                                      ),
                                      Container(
                                        padding:
                                        const EdgeInsets.only(left: 10, top: 11),
                                        child: const Icon(
                                          Icons.credit_card_outlined,
                                          size: 20,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.pushPage(EditCard());
                                    },
                                    child: Text(
                                      context.tr("Edit My Card"),
                                      style: TextStyle(
                                        color: Color(0xFF141619),
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: -0.10,),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 39,
                                        height: 39,
                                        // decoration: ShapeDecoration(
                                        //   shape: OvalBorder(
                                        //     side: BorderSide(width: 2, color: Color(0xFF286F8C)),
                                        //   ),
                                        // ),
                                      ),
                                      Container(
                                        padding:
                                        const EdgeInsets.only(left: 10, top: 11),
                                        child: const Icon(
                                          Icons.language,
                                          size: 20,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigate to the Language page and pass the callback function
                                      context.pushPage(Language(
                                      ));
                                    },
                                    child: Text(
                                      context.tr( "Language"),
                                      style: TextStyle(
                                        color: Color(0xFF141619),
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: -0.10,),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 39,
                                        height: 39,
                                        // decoration: ShapeDecoration(
                                        //   shape: OvalBorder(
                                        //     side: BorderSide(width: 2, color: Color(0xFF286F8C)),
                                        //   ),
                                        // ),
                                      ),
                                      Container(
                                        padding:
                                        const EdgeInsets.only(left: 11, top: 11),
                                        child: const Icon(
                                          Icons.logout,
                                          size: 20,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => Auth(),
                                      ));
                                    },
                                    child: Text(
                                      context.tr("Log Out"),
                                      style: TextStyle(
                                        color: Color(0xFF141619),
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: -0.10,),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // SizedBox(
                    //   height: 40,
                    // ),
                    //tabs(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}