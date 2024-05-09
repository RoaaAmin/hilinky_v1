
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
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

import '../../core/utils/size_utils.dart';
import '../../models/SnackBar.dart';
import '../../nav_bar.dart';
import '../../theme/custom_text_style.dart';
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
              icon: Icon(Icons.camera, color: Colors.amber[800]),
              onPressed: () {
                getImage(ImageSource.camera);
              },
              label: Text(context.tr("Camera"),style: TextStyle( color: Color.fromARGB(255, 2, 84, 86),),),
            ),
            SizedBox(width: 10,),
            TextButton.icon(
              icon: Icon(Icons.image, color: Colors.amber[800]),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              label: Text(context.tr("Gallery"),style: TextStyle( color: Color.fromARGB(255, 2, 84, 86),),),
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
  var sUserName ;
  var email ;
  var phoneNumber;
  var image;
  File? selectedImage;

  // add them to sign up
  var nationality ;
  var city ;

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
        FirstName = value.data()!['FirstName'];
        LastName = value.data()!['LastName'];
        sUserName = value['sUserName'];
        email = value['sUserEmail'];
        phoneNumber = value['sUserPhoneNumber'];
        nationality = value['sNationality'];
        city = value['sCity'];
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
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
              children: [
                if (!lodaing)
                  Container(
                    child: ClipOval(
                      child: selectedImage != null
                          ? Image.file(
                        selectedImage!,
                        height: 325,
                        width: 325,
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        image ?? '',
                        height: 325,
                        width: 325,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                TextButton(
                    onPressed: ()  {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                    child:  Text(context.tr("Pick Image"))),

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
                                    onChanged: (value) => FirstName = value,
                                    controller: TextEditingController(text: FirstName),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(color: Color(0xFF4AAAC6)),
                                      ),
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
                                    controller: TextEditingController(text: LastName),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(color: Color(0xFF4AAAC6)),
                                      ),
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
                              enabled: false, // Set this to false to make it not writable
                              onChanged: (value) => uniqueUserName = value,
                              controller: TextEditingController(text: uniqueUserName),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                hintStyle: TextStyle(color: Colors.black), // Set the text color to black
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
                            context.tr("Email"),
                            style: CustomTextStyles.titleMediumTeal300,
                          ),
                          SizedBox(
                            width: 354,
                            height: 54,
                            child: TextFormField(
                              enabled: false, // Set this to false to make it not writable
                              onChanged: (value) => email = value,
                              controller: TextEditingController(text: email),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                hintStyle: TextStyle(color: Colors.black), // Set the text color to black
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
                              controller: TextEditingController(text: phoneNumber),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                            context.tr("Nationality"),
                            style: CustomTextStyles.titleMediumTeal300,
                          ),
                          SizedBox(
                            width: 354,
                            height: 54,
                            child: TextFormField(
                              onChanged: (value) => nationality = value,
                              controller: TextEditingController(text: nationality),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
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
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr("City"),
                            style: CustomTextStyles.titleMediumTeal300,
                          ),
                          SizedBox(
                            width: 354,
                            height: 54,
                            child: TextFormField(
                              onChanged: (value) => city = value,
                              controller: TextEditingController(text: city),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              cursorColor: Colors.black,
                              // validator: (value) {
                              // //   if (value == null || value.isEmpty) {
                              // //     return context.tr("Please enter some text");
                              // //   }
                              // //   return null;
                              // // },
                            ),
                          ),
                        ],
                      ),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            context.tr('Password reset email sent. Please check your email.'),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      print('Error sending password reset email: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            context.tr('Failed to send password reset email.'),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
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
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    showInSnackBar('Your information has been saved successfully',
                        Color.fromARGB(255, 149, 181, 236),Colors.white, 3, context, _scaffoldKey);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Home(currentIndex: 2),
                      ),
                    );
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
                            'FirstName': FirstName,
                            'LastName': LastName,
                            'uniqueUserName': uniqueUserName,
                            'sUserEmail': email,
                            'sUserPhoneNumber': phoneNumber,
                            'sNationality': nationality,
                            'sCity': city,
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



                        });
                      } else {
                        // If no image selected, update user's information without changing the image
                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'FirstName': FirstName,
                          'LastName': LastName,
                          'uniqueUserName': uniqueUserName,
                          'sUserEmail': email,
                          'sUserPhoneNumber': phoneNumber,
                          'sNationality': nationality,
                          'sCity': city,
                        });
//
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(context.tr("Your information has been saved successfully")),
                            backgroundColor: Color.fromARGB(255, 149, 181, 236),
                          ),
                        );

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
                  // Button styling and text
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(5),
                    backgroundColor: const Color.fromARGB(255, 2, 84, 86),
                    fixedSize: const Size(150, 40),
                    elevation: 0,
                  ),
                  child:  Text(
                    context.tr('Save'),
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              ]
          ),
        ));
  }
}