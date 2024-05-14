import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hilinky/components/context.dart';
import 'package:hilinky/screens/home_screen.dart';
import 'package:hilinky/screens/my_card/widget/qr_code.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../nav_bar.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/custom_image_view.dart';
import '../Profile/edit_card.dart';
import '../Scanner/QRScannerPage.dart';
// import 'package:page_indicator/page_indicator.dart';

class MyCard extends StatefulWidget {
  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool myCardFetched = false;
  var UserProfileImage;

  Color iconColor = Color(0xFF286F8C); // Foreground color
  Color backgroundColor = Colors.white; // Background color

  late DocumentSnapshot<Map<String, dynamic>> userData;
  List<DocumentSnapshot<Map<String, dynamic>>> cardsDocs= [];
  Map<String, dynamic> Links = {};

  @override
  void initState() {
    super.initState();
    getUserData();
    getLinks();

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
  getMyCards() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUID = user.uid;

      await FirebaseFirestore.instance.collection('Cards')
          .where('PostedByUID', isEqualTo: userUID)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          setState(() {
            cardsDocs = value.docs.toList();
            myCardFetched = true;
          });
          cardsDocs.sort((a, b) => b.data()!['TimeStamp'].compareTo(a.data()!['TimeStamp']));
        }
      });
    }
  }

  getUserData() async {
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      setState(() {
        userData = value;
        getMyCards();
      });
    });
  }

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
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async => false,
      child:  Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: double.maxFinite,
          leading: AppbarImage(
            imagePath: ImageConstant.hilinkylogopng,
            margin: getMargin(
              // left: 11,
              right: 6,
            ),
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
            side: BorderSide(
              color: Color(0xFF234E5C),
            ),
          ),
          title: Text(context.tr('Home Screen')),
        ),
        body: ListView(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    // padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0, bottom: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      ],
                    ),
                  )
                ],
              ),
            ),
            flowList(context),
          ],
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.orange.shade300,
                  Colors.deepOrange.shade400
                ],
                end: Alignment.topLeft,
                begin: Alignment.bottomRight
            ),
            shape: BoxShape.circle,
          ),
          child: FloatingActionButton(
            onPressed: () {
              context.pushPage(QRScannerPage());
            },
            child: Icon(Icons.qr_code_scanner),
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent, // Set background color to transparent
            elevation: 0, // Remove the shadow effect
          ),
        ),
      ),
    );
  }

  Widget flowList(BuildContext context) {
    List<String> keys = Links.keys.toList();
    List<dynamic> values = Links.values.toList();
    if (cardsDocs != null) {
      if (cardsDocs.length != 0) {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left:10.0,right: 10,top: 10,bottom: 75),
            itemCount: cardsDocs.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: ()async{
                  //  showUserBottomSheet(postsDocs[i]);
                },

                child: Column(
                    children: [
                      Container(
                    child: Container(
                      child: Stack(
                        children: [
                          Container(
                            // width: 300, // Replace 200 with your desired width
                            height: 338, // Replace 200 with your desired height
                            child: CustomImageView(
                              imagePath: ImageConstant.HilinkyCard,
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(40.0),
                            margin: const EdgeInsets.only(top: 45, right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Spacer(),
                                    Container(
                                      height: 25,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.pushPage(EditCard());
                                        },
                                        style: ElevatedButton.styleFrom(
                                          // primary: Colors.transparent, // Setting the button's background color to transparent
                                          shadowColor: Colors.transparent, // Removing the button's shadow
                                        ),
                                        child: Container(
                                          child: Text(
                                            context.tr('Edit'),
                                            style: TextStyle(
                                               color: Colors.deepOrangeAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // SizedBox(height: 80, width: 90,),
                          Padding( padding: const EdgeInsets.all(60.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(120),
                                        image: DecorationImage(
                                          image: cardsDocs[i].data()!['LogoURL'] != null
                                              ? NetworkImage(cardsDocs[i].data()!['defaultLogo']!)
                                              : NetworkImage(cardsDocs[i].data()!['LogoURL']!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              cardsDocs[i].data()!['FirstName'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text("  "),
                                            Text(
                                              cardsDocs[i].data()!['LastName'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              cardsDocs[i].data()!['Position'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                height: 0.21,
                                              ),
                                            ),
                                            Text(
                                              " - ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                height: 0.21,
                                              ),
                                            ),
                                            Text(
                                              cardsDocs[i].data()!['CompanyName'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: 'Inter',
                                                height: 0.21,
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20),

//////////////
                                Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 40, // Adjust the height according to your requirement
                                        child: Links.isEmpty
                                            ? Text(context.tr('No links'))
                                            : Wrap(
                                          spacing: 15.0, // Horizontal spacing between the links
                                          runSpacing: 8.0, // Vertical spacing between the rows
                                          children: List.generate(Links.length, (index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.circular(8),
                                                color: Colors.white,
                                              ),
                                              width: 35,
                                              height: 35,
                                              child: IconButton(
                                                iconSize: 20,
                                                onPressed: () {
                                                  final Uri url = Uri.parse(values[index]);
                                                  _launchUrl(url);
                                                },
                                                icon: Icon(l[keys[index]]!.icon),
                                                color: iconColor,
                                              ),
                                            );
                                          }),

                                        ),

                                      ),
                                    ],
                                  ),
                                        ),

                                    ],
                                  ),
                                ),




                              ],
                            ),
                          ),

                      ),

                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CustomImageView(
                                  // width: 500,
                               height: 338,
                                  imagePath: ImageConstant.HilinkyCard,
                                  fit: BoxFit.cover, // Ensure the image covers the entire container
                                ),
                                QrCode(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              );
            }
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
