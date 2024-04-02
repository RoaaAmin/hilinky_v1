import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hiwetaan/components/context.dart';
import 'package:hiwetaan/screens/Profile/edit_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../auth.dart';
import '../../nav_bar.dart';
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
  int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    int selectedOption = 1;
    List<String> keys = Links.keys.toList();
    List<dynamic> values = Links.values.toList();
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          title: Center(
            child: Text(
              "My Profile",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Home(),
                  ))),
          actions: [
            // TextButton(
            //   onPressed: () {
            //     context.pushPage(HomeScreen());
            //   },
            //   child:  Icon(Icons.share),
            // ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 130.0,
                    width: 130.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(image ?? ''),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "$FirstName" + " $LastName",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$Position - $CompanyName",
                    style: TextStyle(color: Colors.grey),
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
                            ? Text('No links')
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
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
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
                        border: Border.all(style: BorderStyle.solid),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    height: 230,
                    width: 361,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: const Icon(
                                    Icons.circle_outlined,
                                    // grade: 3.3,
                                    color: Colors.blueGrey,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 11, top: 11),
                                  child: const Icon(
                                    Icons.my_library_books_rounded,
                                    size: 20,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                 context.pushPage(Edit());
                                },
                                child: const Text(
                                  "Edit Profile Information",
                                  style: TextStyle(color: Colors.black),
                                )),

                          ],
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: const Icon(
                                    Icons.circle_outlined,
                                    // grade: 3.3,
                                    color: Colors.blueGrey,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.only(left: 11, top: 11),
                                  child: const Icon(
                                    Icons.my_library_books_rounded,
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
                                child: const Text(
                                  "Edit My Card ",
                                  style: TextStyle(color: Colors.black),
                                )),

                          ],
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                //   padding: const EdgeInsets.only(right: 15),
                                //   child: const Icon(
                                //     Icons.circle_outlined,
                                //     // grade: 3.3,
                                //     color: Colors.blueGrey,
                                //     size: 40,
                                //   ),
                                // ),
                                // Container(
                                //   padding:
                                //       const EdgeInsets.only(left: 11, top: 11),
                                //   child: const Icon(
                                //     Icons.my_library_books_rounded,
                                //     size: 20,
                                //     color: Colors.orange,
                                //   ),
                                ),
                              ],
                            ),
                            // TextButton(
                            //     onPressed: () {
                            //       context.pushPage(const Notifications());
                            //     },
                            //     child: const Text(
                            //       "Notifications",
                            //       style: TextStyle(color: Colors.black),
                            //     )),
                            // const Text("ON")
                          ],
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: const Icon(
                                    Icons.circle_outlined,
                                    // grade: 3.3,
                                    color: Colors.blueGrey,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 11, top: 11),
                                  child: const Icon(
                                    Icons.my_library_books_rounded,
                                    size: 20,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  context.pushPage(language());
                                },
                                child: const Text(
                                  "Language",
                                  style: TextStyle(color: Colors.black),
                                )),
                            const Text("English(US)")
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Stack(
                        //       children: [
                        //         Container(
                        //           padding: const EdgeInsets.only(right: 15),
                        //           child: const Icon(
                        //             Icons.circle_outlined,
                        //             // grade: 3.3,
                        //             color: Colors.blueGrey,
                        //             size: 40,
                        //           ),
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.only(left: 11, top: 11),
                        //           child: Icon(
                        //             Icons.my_library_books_rounded,
                        //             size: 20,
                        //             color: Colors.orange,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     TextButton(
                        //         onPressed: () {
                        //           showBottomSheet(
                        //             shape: Border.symmetric(),
                        //             // strokeAlign:
                        //             //     BorderSide.strokeAlignOutside,
                        //
                        //             // color: Colors.black),
                        //             context: context,
                        //             builder: (context) {
                        //               return SizedBox(
                        //                 height: 250,
                        //                 width:
                        //                 MediaQuery.of(context).size.width,
                        //                 // *
                        //                 //     0.8,
                        //                 // child: Padding(
                        //                 //   padding: EdgeInsets.all(20.0),
                        //                 //   child: Column(
                        //                 //     mainAxisAlignment:
                        //                 //     MainAxisAlignment.start,
                        //                 //     children: <Widget>[
                        //                 //       Text(
                        //                 //         "Theme",
                        //                 //         style: TextStyle(fontSize: 24),
                        //                 //       ),
                        //                 //       ListTile(
                        //                 //         // onTap: () {
                        //                 //         //   context
                        //                 //         //       .pushPage(profiletest());
                        //                 //         // },
                        //                 //         titleAlignment:
                        //                 //         ListTileTitleAlignment
                        //                 //             .center,
                        //                 //         // textAlign: TextAlign.end,
                        //                 //         title: const Text(
                        //                 //           'Light Mode',
                        //                 //           style:
                        //                 //           TextStyle(fontSize: 16),
                        //                 //         ),
                        //                 //
                        //                 //         leading: Radio(
                        //                 //           value: 1,
                        //                 //           groupValue: selectedOption,
                        //                 //           onChanged: (value) {
                        //                 //             setState(() {
                        //                 //               selectedOption = value!;
                        //                 //             });
                        //                 //           },
                        //                 //         ),
                        //                 //       ),
                        //                 //       ListTile(
                        //                 //         //    onTap: () {
                        //                 //         //   context
                        //                 //         //       .pushPage(profiletest());
                        //                 //         // },
                        //                 //         titleAlignment:
                        //                 //         ListTileTitleAlignment
                        //                 //             .center,
                        //                 //         // textAlign: TextAlign.end,
                        //                 //         title: const Text(
                        //                 //           'Dark Mode',
                        //                 //           style:
                        //                 //           TextStyle(fontSize: 16),
                        //                 //         ),
                        //                 //
                        //                 //         leading: Radio(
                        //                 //           value: 2,
                        //                 //           groupValue: selectedOption,
                        //                 //           onChanged: (value) {
                        //                 //             setState(() {
                        //                 //               selectedOption = value!;
                        //                 //             });
                        //                 //           },
                        //                 //         ),
                        //                 //       ),
                        //                 //       ListTile(
                        //                 //         //    onTap: () {
                        //                 //         //   context
                        //                 //         //       .pushPage(profiletest());
                        //                 //         // },
                        //                 //         titleAlignment:
                        //                 //         ListTileTitleAlignment
                        //                 //             .center,
                        //                 //         // textAlign: TextAlign.end,
                        //                 //         title: const Text(
                        //                 //           'System Default',
                        //                 //           style:
                        //                 //           TextStyle(fontSize: 16),
                        //                 //         ),
                        //                 //
                        //                 //         leading: Radio(
                        //                 //           value: 3,
                        //                 //           groupValue: selectedOption,
                        //                 //           onChanged: (value) {
                        //                 //             setState(() {
                        //                 //               selectedOption = value!;
                        //                 //             });
                        //                 //           },
                        //                 //         ),
                        //                 //
                        //                 //         //System Default
                        //                 //       )
                        //                 //     ],
                        //                 //   ),
                        //                 // ),
                        //               );
                        //               // return SelectingSheet(keyword: text);
                        //             },
                        //           );
                        //         },
                        //         child: const Text(
                        //           "Theme",
                        //           style: TextStyle(color: Colors.black),
                        //         )),
                        //     const Text("Light Mode")
                        //   ],
                        // ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: const Icon(
                                    Icons.circle_outlined,
                                    // grade: 3.3,
                                    color: Colors.blueGrey,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.only(left: 11, top: 11),
                                  child: const Icon(
                                    Icons.my_library_books_rounded,
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
                                child: const Text(
                                  "Log Out",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.only(
                  //       left: 20, right: 20, top: 10, bottom: 8),
                  //   decoration: BoxDecoration(
                  //       border: Border.all(style: BorderStyle.solid),
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(20)),
                  //   height: 130,
                  //   width: 361,
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Stack(
                  //             children: [
                  //               Container(
                  //                 padding: const EdgeInsets.only(right: 15),
                  //                 child: const Icon(
                  //                   Icons.circle_outlined,
                  //                   // grade: 3.3,
                  //                   color: Colors.blueGrey,
                  //                   size: 40,
                  //                 ),
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.only(left: 11, top: 11),
                  //                 child: Icon(
                  //                   Icons.my_library_books_rounded,
                  //                   size: 20,
                  //                   color: Colors.orange,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           TextButton(
                  //               onPressed: () {
                  //                 showBottomSheet(
                  //                   shape: Border.symmetric(),
                  //                   // strokeAlign:
                  //                   //     BorderSide.strokeAlignOutside,
                  //
                  //                   // color: Colors.black),
                  //                   context: context,
                  //                   builder: (context) {
                  //                     return SizedBox(
                  //                       height: 250,
                  //                       width:
                  //                           MediaQuery.of(context).size.width,
                  //                       // *
                  //                       //     0.8,
                  //                       child: Padding(
                  //                         padding: EdgeInsets.all(20.0),
                  //                         child: Column(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.start,
                  //                           children: <Widget>[
                  //                             Text(
                  //                               "Theme",
                  //                               style: TextStyle(fontSize: 24),
                  //                             ),
                  //                             ListTile(
                  //                               // onTap: () {
                  //                               //   context
                  //                               //       .pushPage(profiletest());
                  //                               // },
                  //                               titleAlignment:
                  //                                   ListTileTitleAlignment
                  //                                       .center,
                  //                               // textAlign: TextAlign.end,
                  //                               title: const Text(
                  //                                 'Light Mode',
                  //                                 style:
                  //                                     TextStyle(fontSize: 16),
                  //                               ),
                  //
                  //                               leading: Radio(
                  //                                 value: 1,
                  //                                 groupValue: selectedOption,
                  //                                 onChanged: (value) {
                  //                                   setState(() {
                  //                                     selectedOption = value!;
                  //                                   });
                  //                                 },
                  //                               ),
                  //                             ),
                  //                             ListTile(
                  //                               //    onTap: () {
                  //                               //   context
                  //                               //       .pushPage(profiletest());
                  //                               // },
                  //                               titleAlignment:
                  //                                   ListTileTitleAlignment
                  //                                       .center,
                  //                               // textAlign: TextAlign.end,
                  //                               title: const Text(
                  //                                 'Dark Mode',
                  //                                 style:
                  //                                     TextStyle(fontSize: 16),
                  //                               ),
                  //
                  //                               leading: Radio(
                  //                                 value: 2,
                  //                                 groupValue: selectedOption,
                  //                                 onChanged: (value) {
                  //                                   setState(() {
                  //                                     selectedOption = value!;
                  //                                   });
                  //                                 },
                  //                               ),
                  //                             ),
                  //                             ListTile(
                  //                               //    onTap: () {
                  //                               //   context
                  //                               //       .pushPage(profiletest());
                  //                               // },
                  //                               titleAlignment:
                  //                                   ListTileTitleAlignment
                  //                                       .center,
                  //                               // textAlign: TextAlign.end,
                  //                               title: const Text(
                  //                                 'System Default',
                  //                                 style:
                  //                                     TextStyle(fontSize: 16),
                  //                               ),
                  //
                  //                               leading: Radio(
                  //                                 value: 3,
                  //                                 groupValue: selectedOption,
                  //                                 onChanged: (value) {
                  //                                   setState(() {
                  //                                     selectedOption = value!;
                  //                                   });
                  //                                 },
                  //                               ),
                  //
                  //                               //System Default
                  //                             )
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     );
                  //                     // return SelectingSheet(keyword: text);
                  //                   },
                  //                 );
                  //               },
                  //               child: const Text(
                  //                 "Theme",
                  //                 style: TextStyle(color: Colors.black),
                  //               )),
                  //           const Text("Light Mode")
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           // Stack(
                  //           //   children: [
                  //           //     Container(
                  //           //       padding: const EdgeInsets.only(right: 15),
                  //           //       child: const Icon(
                  //           //         Icons.circle_outlined,
                  //           //         // grade: 3.3,
                  //           //         color: Colors.blueGrey,
                  //           //         size: 40,
                  //           //       ),
                  //           //     ),
                  //           //     Container(
                  //           //       padding:
                  //           //           const EdgeInsets.only(left: 11, top: 11),
                  //           //       child: const Icon(
                  //           //         Icons.my_library_books_rounded,
                  //           //         size: 20,
                  //           //         color: Colors.orange,
                  //           //       ),
                  //           //     ),
                  //           //   ],
                  //           // ),
                  //           // TextButton(
                  //           //     onPressed: () {
                  //           //     //  context.pushPage(const Activity());
                  //           //     },
                  //           //     child: const Text(
                  //           //       "Activity",
                  //           //       style: TextStyle(color: Colors.black),
                  //           //     )),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           Stack(
                  //             children: [
                  //               Container(
                  //                 padding: const EdgeInsets.only(right: 15),
                  //                 child: const Icon(
                  //                   Icons.circle_outlined,
                  //                   // grade: 3.3,
                  //                   color: Colors.blueGrey,
                  //                   size: 40,
                  //                 ),
                  //               ),
                  //               Container(
                  //                 padding:
                  //                     const EdgeInsets.only(left: 11, top: 11),
                  //                 child: const Icon(
                  //                   Icons.my_library_books_rounded,
                  //                   size: 20,
                  //                   color: Colors.orange,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           TextButton(
                  //               onPressed: () {
                  //                 FirebaseAuth.instance.signOut();
                  //                 Navigator.of(context).push(MaterialPageRoute(
                  //                   builder: (context) => Auth(),
                  //                 ));
                  //               },
                  //               child: const Text(
                  //                 "Log Out",
                  //                 style: TextStyle(color: Colors.black),
                  //               )),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),

              // SizedBox(
              //   height: 40,
              // ),
              //tabs(),
            ],
          ),
        ));
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
