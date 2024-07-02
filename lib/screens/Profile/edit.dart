import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hilinky/components/context.dart';
import 'package:hilinky/screens/Profile/profile.dart';
import 'package:hilinky/widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

import '../../core/utils/size_utils.dart';
import '../../models/SnackBar.dart';
import '../../nav_bar.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import 'image_picker.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  EditState createState() {
    return EditState();
  }
}

class EditState extends State<Edit> {
  imagePicker controller = Get.put(imagePicker());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();
  List<DocumentSnapshot<Map<String, dynamic>>> postsDocs = [];
  bool postsFetched = false;
  // File? selectedImage;
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

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.platform
        .getImageFromSource(source: source); //pickImage
    print('printing source of image $source');
    setState(() {
      selectedImage = File(image!.path);
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 80,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera, color: Colors.blue[800]),
              onPressed: () {
                getImage(ImageSource.camera);
              },
              label: Text(
                context.tr("Camera"),
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 84, 86),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            TextButton.icon(
              icon: Icon(Icons.image, color: Colors.blue[800]),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              label: Text(
                context.tr("Gallery"),
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 84, 86),
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }

  var lodaing = true;
  var FirstName;
  var LastName;
  var uniqueUserName;
  var sUserName;
  var email;
  var phoneNumber;
  var image;
  File? selectedImage;

  // add them to sign up
  var nationality;
  var city;

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
        sUserName = value.data()!['sUserName'];
        LastName = value.data()!['LastName'];
        sUserName = value['sUserName'];
        email = value['sUserEmail'];
        phoneNumber = value['sUserPhoneNumber'];
        // nationality = value['sNationality'];
        // city = value['sCity'];
        lodaing = false;
        image = value.data()!['UserProfileImage'];
        getPosts();
      });
    });
  }

  // void getCardInfo() async {
  //   await FirebaseFirestore.instance
  //       .collection('Cards')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then(
  //     (value) {
  //       setState(() {
  //
  //         image = value.data()!['ImageURL'];
  //       });
  //     },
  //   );
  // }

  @override
  void initState() {
    //getCardInfo();
    getUserData();
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // dynamic myImage = const AssetImage("assets/images/avatary.png");
    // Build a Form widget using the _formKey created above.
    return lodaing
        ? Center(
            child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ))
        : Scaffold(
            backgroundColor: appTheme.whiteA700,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: appTheme.whiteA700,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_outlined),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(children: [
                if (!lodaing)
                  Center(
                    child: Container(
                      width: 150, // Adjust width as needed
                      height: 150, // Adjust height as needed
                      child: ClipOval(
                        child: selectedImage != null
                            ? Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                                width:
                                    150, // Ensure the width matches the container
                                height:
                                    150, // Ensure the height matches the container
                              )
                            : Image.network(
                                image ?? '',
                                fit: BoxFit.cover,
                                width:
                                    150, // Ensure the width matches the container
                                height:
                                    150, // Ensure the height matches the container
                              ),
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet()),
                    );
                  },
                  child: Text(context.tr("Pick Image")),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.orange, // Text color
                    // backgroundColor: Colors.white, // Button background color
                    // padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // Padding
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    // ),
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr("First Name"),
                                  style: CustomTextStyles.titleMediumTeal300,
                                ),
                                SizedBox(
                                  width: 169,
                                  height: 54,
                                  child: TextFormField(
                                    onChanged: (value) => sUserName = value,
                                    controller:
                                        TextEditingController(text: sUserName),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: appTheme.teal300, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: appTheme.teal300, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: appTheme.white, width: 2),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText:
                                          context.tr("Enter your first name"),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                    ),
                                    cursorColor: Colors.black,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return context.tr("Please enter some text");
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr("Last Name"),
                                  style: CustomTextStyles.titleMediumTeal300,
                                ),
                                SizedBox(
                                  width: 169,
                                  height: 54,
                                  child: TextFormField(
                                    onChanged: (value) => LastName = value,
                                    controller:
                                        TextEditingController(text: LastName),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: appTheme.teal300, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: appTheme.teal300, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: appTheme.white, width: 2),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText:
                                          context.tr("Enter your last name"),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                    ),
                                    cursorColor: Colors.black,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return context.tr("Please enter some text");
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr("User Name"),
                            style: CustomTextStyles.titleMediumTeal300,
                          ),
                          SizedBox(
                            width: 354,
                            height: 54,
                            child: TextFormField(
                              enabled:
                                  false, // Set this to false to make it not writable
                              onChanged: (value) => uniqueUserName = value,
                              controller:
                                  TextEditingController(text: uniqueUserName),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                hintStyle: TextStyle(
                                    color: Colors
                                        .black), // Set the text color to black
                              ),
                              cursorColor: Colors.black,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.tr("Please enter some text");
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),



                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr("Phone Number"),
                            style: CustomTextStyles.titleMediumTeal300,
                          ),
                          SizedBox(
                            width: 354,
                            height: 54,
                            child: TextFormField(
                              onChanged: (value) => phoneNumber = value,
                              controller:
                                  TextEditingController(text: phoneNumber),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: appTheme.teal300, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: appTheme.teal300, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: appTheme.white, width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: context.tr("Enter your phone number"),
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                              ),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.tr("Please enter some text");
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr("Email"),
                            style: CustomTextStyles.titleMediumTeal300,
                          ),
                          SizedBox(
                            width: 354,
                            height: 54,
                            child: TextFormField(
                              enabled:
                              false, // Set this to false to make it not writable
                              onChanged: (value) => email = value,
                              controller: TextEditingController(text: email),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                hintStyle: TextStyle(
                                    color: Colors
                                        .black), // Set the text color to black
                              ),
                              cursorColor: Colors.black,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.tr("Please enter some text");
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       context.tr("Nationality"),
                      //       style: CustomTextStyles.titleMediumTeal300,
                      //     ),
                      //     SizedBox(
                      //       width: 354,
                      //       height: 54,
                      //       child: TextFormField(
                      //         onChanged: (value) => nationality = value,
                      //         controller: TextEditingController(text: nationality),
                      //         decoration: InputDecoration(
                      //           border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.all(Radius.circular(10)),
                      //             borderSide: BorderSide(color: appTheme.teal300, width: 2),
                      //           ),
                      //           focusedBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.all(Radius.circular(10)),
                      //             borderSide: BorderSide(color: appTheme.teal300, width: 2),
                      //           ),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.all(Radius.circular(10)),
                      //             borderSide: BorderSide(color: appTheme.white, width: 2),
                      //           ),
                      //           filled: true,
                      //           fillColor: Colors.white,
                      //           hintText: context.tr("Enter your nationality"),
                      //           hintStyle: TextStyle(color: Colors.grey),
                      //           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      //         ),
                      //         cursorColor: Colors.black,
                      //         // validator: (value) {
                      //         //   if (value == null || value.isEmpty) {
                      //         //     return context.tr("Please enter some text");
                      //         //   }
                      //         //   return null;
                      //         // },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8.00),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.grey.withOpacity(0.02),
                      //         spreadRadius: 0,
                      //         blurRadius: 5,
                      //         offset: Offset(0, 15), // Changes position of shadow
                      //       ),
                      //     ],
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         context.tr("City"),
                      //         style: CustomTextStyles.titleMediumTeal300,
                      //       ),
                      //       SizedBox(
                      //         width: 354,
                      //         height: 54,
                      //         child: TextFormField(
                      //           onChanged: (value) => city = value,
                      //           controller: TextEditingController(text: city),
                      //           decoration: InputDecoration(
                      //             fillColor: Colors.white, // Set background color
                      //             filled: true,
                      //             hintText: context.tr("Enter your city"),
                      //             hintStyle: TextStyle(color: Colors.grey),
                      //             border: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(8.00),
                      //               borderSide: BorderSide(
                      //                 color: appTheme.white,
                      //                 width: 2,
                      //               ),
                      //             ),
                      //             enabledBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(8.00),
                      //               borderSide: BorderSide(
                      //                 color: appTheme.white,
                      //                 width: 2,
                      //               ),
                      //             ),
                      //             focusedBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(8.00),
                      //               borderSide: BorderSide(
                      //                 color: appTheme.teal300,
                      //                 width: 2,
                      //               ),
                      //             ),
                      //           ),
                      //           cursorColor: Colors.black,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // const location(),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: email, // Provide the user's email here
                      );
                      showInSnackBar(
                          context.tr(
                              'Password reset email sent. Please check your email.'),
                          Colors.green,
                          Colors.white,
                          3,
                          context,
                          _scaffoldKey);
                    } catch (e) {
                      print('Error sending password reset email: $e');
                      showInSnackBar(
                          context.tr('Failed to send password reset email.'),
                          Colors.red,
                          Colors.white,
                          3,
                          context,
                          _scaffoldKey);
                    }
                  },

                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 17, right: 4),
                      child: Text(
                        context.tr('Change Password?'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFEF9453),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFEF9453),
                          // Change the underline color here
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    _showLogoutConfirmationDialog(context);
                  },
                  // Button styling and text
                  style: ButtonStyle(
                    // padding: const EdgeInsets.all(5),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF234E5C)),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      context.tr('Save'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ),

              ]
              ),
            ));
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
                context.tr("Save Confirmation"),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          content: Text(
            context.tr("Are you sure you want to save your information to display it in your card?"),
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.black87,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey, textStyle: TextStyle(
                fontFamily: 'Inter',
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
                foregroundColor: Color(0xFF286F8C), textStyle: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
              ),
              child: Text(context.tr("Yes")),
              onPressed: () async {
                // showInSnackBar(context.tr('Your information has been saved successfully'),
                //     Colors.green,Colors.white, 3, context, _scaffoldKey);
                //
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => Home(currentIndex: 2),
                //   ),
                // );
                if (_formKey.currentState!.validate()) {
                  // Upload image to Firebase Storage
                  if (selectedImage != null) {
                    // Upload the image to Firebase Storage
                    Reference ref = FirebaseStorage.instance
                        .ref()
                        .child('user_images')
                        .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');

                    UploadTask uploadTask = ref.putFile(selectedImage!);

                    await uploadTask.whenComplete(() async {
                      // Get the URL of the uploaded image
                      String selectedImage = await ref.getDownloadURL();

                      // Update user's information in Firestore with the image URL
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        'sUserName': sUserName,
                        'LastName': LastName,
                        'uniqueUserName': uniqueUserName,
                        'sUserEmail': email,
                        'sUserPhoneNumber': phoneNumber,
                        // 'sNationality': nationality,
                        // 'sCity': city,
                        'UserProfileImage': selectedImage,
                      });
                      // Show success message
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(context.tr('Your information has been saved successfully')),
                      //     backgroundColor: Color.fromARGB(255, 149, 181, 236),
                      //   ),
                      // );

                      // Navigate back to profile page
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => Home(currentIndex: 2),
                      //   ),
                      // );

                      //  Navigator.of(context).pop();
                      showInSnackBar(context.tr('Your information has been saved successfully'),
                          Colors.green,Colors.white, 3, context, _scaffoldKey);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Home(currentIndex: 2),
                        ),
                      );

                    });
                  } else {
                    // If no image selected, update user's information without changing the image
                    await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'sUserName': sUserName,
                      'LastName': LastName,
                      'uniqueUserName': uniqueUserName,
                      'sUserEmail': email,
                      'sUserPhoneNumber': phoneNumber,
                      // 'sNationality': nationality,
                      // 'sCity': city,
                    });
                    showInSnackBar(context.tr('Your information has been saved successfully'),
                        Colors.green,Colors.white, 3, context, _scaffoldKey);
                    // Navigate back to profile page
                    //context.pushPage(Home());
                    //Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Home(currentIndex: 2),
                      ),
                    );


                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}