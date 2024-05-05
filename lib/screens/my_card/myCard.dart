import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hilinky/components/context.dart';
import 'package:hilinky/screens/home_screen.dart';
import 'package:hilinky/screens/my_card/widget/qr_code.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'package:line_icons/line_icons.dart';
import '../../core/utils/image_constant.dart';
import '../../nav_bar.dart';
import '../../widgets/custom_image_view.dart';
import '../Scanner/QRScannerPage.dart';
//import 'package:page_indicator/page_indicator.dart';

class MyCard extends StatefulWidget {
  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool myCardFetched = false;

  late DocumentSnapshot<Map<String, dynamic>> userData;
  List<DocumentSnapshot<Map<String, dynamic>>> cardsDocs= [];

  @override
  void initState() {
    getUserData();
    super.initState();
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
    return  Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     IconButton(
          //         icon: Icon(LineIcons.arrowLeft, size:30.0),
          //         onPressed: () {
          //           Navigator.of(context).pushReplacement(CupertinoPageRoute(
          //               builder: (BuildContext context) => Home()));
          //         }
          //     ),
          //   ],
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0, bottom: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 1.0, bottom: 20.0),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          flowList(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushPage(QRScannerPage());
        },
        child: Icon(Icons.qr_code_scanner),
        foregroundColor: Colors.white,
        backgroundColor: Color(0XFFEE6363),
        shape: CircleBorder(),
      ),
    );
  }

  Widget flowList(BuildContext context) {
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

                child: Container(
                  child: Stack(
                    children: [
                      CustomImageView(
                       // imagePath: ImageConstant.HilinkyCard,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF495592),
                                    borderRadius: BorderRadius.circular(120),
                                    image: DecorationImage(image: NetworkImage(cardsDocs[i].data()!['ImageURL']), fit: BoxFit.fill),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),

                              child: Row(
                                  children: [
                                    Text(
                                      cardsDocs[i].data()!['FirstName'],
                                      style: TextStyle(color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        height: 0.08,),
                                    ).tr(),
                                    Text("  "),
                                    Text(
                                      cardsDocs[i].data()!['LastName'],
                                      style: TextStyle(color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        height: 0.08,),
                                    ).tr(),
                                  ]
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      cardsDocs[i].data()!['Position'],
                                      style: TextStyle(color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0.21,),
                                    ),
                                    // postsDocs[i].data()!['TimeStamp'],
                                    Text(" - ",
                                      style: TextStyle(color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0.21,),
                                    ),
                                    Text(
                                      cardsDocs[i].data()!['CompanyName'],
                                      style: TextStyle(color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0.21,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //   Container(
                            //     height: 40,
                            //     width: 40,
                            //     decoration: BoxDecoration(
                            //       color: Colors.blue,
                            //       shape: BoxShape.rectangle,
                            //     ),
                            //     child: FaIcon(
                            //       FontAwesomeIcons.facebook,
                            //       color: Colors.white,
                            //       size: 20,
                            //     ),
                            //   ),
                            //   ]
                            // )
                            QrCode(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}