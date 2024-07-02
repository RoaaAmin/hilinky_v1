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

class profiletestState extends State<profiletest> {
  Map<String, dynamic> Links = {};
  var UserProfileImage;
  int selectedOption = 1;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.platform.getImageFromSource(source: source); //pickImage
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
        .then((value) {
      setState(() {
        UserProfileImage = value.data()!['ImageURL'];
        print('-----------------------------------------------');
        print(UserProfileImage);
        Links.clear();
        Links = value.data()!['Links'];
        Links.removeWhere((key, value) => value == '');
      });
    });
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
          postsDocs.sort((a, b) => b.data()!['TimeStamp'].compareTo(a.data()!['TimeStamp']));
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
        .then((value) {
      setState(() {
        FirstName = value.data()!['FirstName'];
        LastName = value.data()!['LastName'];
        Position = value.data()!['Position'];
        CompanyName = value.data()!['CompanyName'];
      });
    });
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
    'tiktok': const FaIcon(FontAwesomeIcons.tiktok),
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('../Progile/screens/assets/images/hilinkybg.svg'), // Replace with your image path
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Column(
            children: [
              SizedBox(height: 60),
              Expanded(
                child: Padding(
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
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            context.tr("$FirstName $LastName"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF286F8C),
                              fontSize: 24,
                              fontFamily: 'Cairo',
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
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Links.isEmpty
                                    ? Text(
                                  context.tr('No links'),
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                  ),
                                )
                                    : Wrap(
                                  spacing: 10.0, // Horizontal spacing between the links
                                  runSpacing: 8.0, // Vertical spacing between the rows
                                  children: List.generate(Links.length, (index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(8),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.deepOrange.shade600,
                                            Colors.orange.shade400,
                                          ],
                                          end: Alignment.topLeft,
                                          begin: Alignment.bottomRight,
                                        ),
                                      ),
                                      width: 30,
                                      height: 30,
                                      child: IconButton(
                                        iconSize: 15,
                                        onPressed: () {
                                          final Uri url = Uri.parse(values[index]);
                                          _launchUrl(url);
                                        },
                                        icon: Icon(l[keys[index]]!.icon),
                                        color: Colors.white,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25), // Adjusted to a smaller height
                          Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 8),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: Offset(0, 7),
                                ),
                              ],
                              border: Border.all(
                                style: BorderStyle.solid,
                                color: Color(0xFF286F8C),
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 361,
                            child: Column(
                              children: [
                                _buildProfileOption(
                                  context,
                                  icon: Icons.person_outline_rounded,
                                  iconColor: Color(0xFF286F8C),
                                  text: "Edit Profile Information",
                                  onPressed: () => context.pushPage(Edit()),
                                ),
                                _buildProfileOption(
                                  context,
                                  icon: Icons.credit_card_outlined,
                                  iconColor: Color(0xFF286F8C),
                                  text: "Edit My Card",
                                  onPressed: () => context.pushPage(EditCard()),
                                ),
                                _buildProfileOption(
                                  context,
                                  icon: Icons.language,
                                  iconColor: Color(0xFF286F8C),
                                  text: "Language",
                                  onPressed: () => context.pushPage(Language()),
                                ),
                                _buildProfileOption(
                                  context,
                                  icon: Icons.logout,
                                  iconColor: Color(0xFF286F8C),
                                  text: "Log Out",
                                  onPressed: () => _showLogoutConfirmationDialog(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(
      BuildContext context, {
        required IconData icon,
        required Color iconColor,
        required String text,
        required VoidCallback onPressed,
      }) {
    return Row(
      children: [
        Container(
          width: 39,
          height: 39,
          padding: const EdgeInsets.only(left: 10, top: 0),
          child: Icon(
            icon,
            size: 25,
            color: iconColor,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            context.tr(text),
            style: TextStyle(
              color: Color(0xFF141619),
              fontSize: 18,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
              height: 0,
              letterSpacing: -0.10,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: appTheme.whiteA700,
          title: Row(
            children: [
              //Icon(Icons.logout, color: Colors.orange),
              SizedBox(width: 10),
              Text(
                context.tr("Logout Confirmation"),
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          content: Text(
            context.tr("Are you sure you want to log out?"),
            style: TextStyle(
              fontFamily: 'Cairo',
              color: Colors.black87,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
                textStyle: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text(context.tr("No")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF286F8C),
                textStyle: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text(context.tr("Yes")),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Auth(),
                ));
              },
            ),
          ],
        );
      },
    );
  }
}
