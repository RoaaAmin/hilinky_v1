
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwetaan/components/context.dart';
import 'package:hiwetaan/screens/Profile/profile.dart';
import 'package:image_picker/image_picker.dart';

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
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image, color: Colors.amber[800]),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              label: Text("Gallery"),
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
                            'sUserName': sUserName,
                            'sUserEmail': email,
                            'sUserPhoneNumber': phoneNumber,
                            'sNationality': nationality,
                            'sCity': city,
                            'UserProfileImage': selectedImage,
                          });


                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Your information has been saved successfully'),
                              backgroundColor: Color.fromARGB(255, 149, 181, 236),
                            ),
                          );

                          // Navigate back to profile page
                          context.pushPage(profiletest());
                        });
                      } else {
                        // If no image selected, update user's information without changing the image
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

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Your information has been saved successfully'),
                            backgroundColor: Color.fromARGB(255, 149, 181, 236),
                          ),
                        );

                        // Navigate back to profile page
                        context.pushPage(profiletest());
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
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              ]
          ),
        ));
  }
}
