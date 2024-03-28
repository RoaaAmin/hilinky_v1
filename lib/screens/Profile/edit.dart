import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwetaan/components/context.dart';
import 'package:hiwetaan/screens/Profile/profile.dart';

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

  final _formKey = GlobalKey<FormState>();
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

  var lodaing = true;
  var FirstName = '';
  var LastName = '';
  var uniqueUserName = '';
  var sUserName = '';
  var email = '';
  var phoneNumber = '';
  var image;

  // add them to sign up
  var nationality = '';
  var city = '';

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
    dynamic myImage = const AssetImage("assets/images/avatary.png");
    // Build a Form widget using the _formKey created above.
    return lodaing
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey,
              leading: IconButton(
                  onPressed: () {
                    context.pushPage(profiletest());
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  CircleAvatar(
                    radius: 100,
                    foregroundImage: NetworkImage(image),
                  ),

                  TextButton(
                      onPressed: () async {
                        await controller.getImage();
                        setState(() {});
                      },
                      child: const Text("Pick Image")),

                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          onChanged: (value) => FirstName = value,
                          controller: TextEditingController(text: FirstName),
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          //   autofillHints:,
                          cursorColor: Colors.black,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (value) => LastName = value,
                          controller: TextEditingController(text: LastName),
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            // hintText: 'name',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          //   autofillHints:,
                          cursorColor: Colors.black,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (value) => sUserName = value,
                          controller: TextEditingController(text: sUserName),
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            //  hintText: 'name',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          //   autofillHints:,
                          cursorColor: Colors.black,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (value) => email = value,
                          controller: TextEditingController(text: email),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            // hintText: 'name',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          //   autofillHints:,
                          cursorColor: Colors.black,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (value) => phoneNumber = value,
                          controller: TextEditingController(text: phoneNumber),
                          decoration: const InputDecoration(
                            label: Text("Phone Number"),

                            // hintText: 'name',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          //   autofillHints:,
                          cursorColor: Colors.black,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (value) => nationality = value,
                          controller: TextEditingController(text: nationality),
                          decoration: const InputDecoration(
                            label: Text("Nationality"),

                            // hintText: 'name',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          //   autofillHints:,
                          cursorColor: Colors.black,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (value) => city = value,
                          controller: TextEditingController(text: city),
                          decoration: const InputDecoration(
                            label: Text("City"),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          cursorColor: Colors.black,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  // const location(),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //    Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'FirstName': FirstName,
                          'LastName': LastName,
                          'sUserName': sUserName,
                          'sUserEmail': email,
                          'sUserPhoneNumber': phoneNumber,
                          'sNationality': nationality,
                          'sCity': city,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Your Information Has Been Saved Successfully'),
                            backgroundColor: Color.fromARGB(255, 149, 181, 236),
                          ),
                        );
                        context.pushPage(profiletest());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      // shape: const (),
                      padding: const EdgeInsets.all(5),
                      backgroundColor: const Color.fromARGB(255, 2, 84, 86),
                      fixedSize: const Size(150, 40),
                      elevation: 0,
                    ),

                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ));
  }
}
