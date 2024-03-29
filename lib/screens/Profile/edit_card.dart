import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwetaan/components/context.dart';
import 'package:hiwetaan/screens/Profile/profile.dart';

import 'image_picker.dart';

class EditCard extends StatefulWidget {
  const EditCard({super.key});

  @override
  EditState createState() {
    return EditState();
  }
}

class EditState extends State<EditCard> {
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
  var Prefix ='';
  var FirstName = '';
  var MiddleName ='';
  var LastName = '';
  var Position = '';
  var uniqueUserName = '';
  var sUserName = '';
  var Email = '';
  var PhoneNumber = '';
  var CompanyName ='';
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
        sUserName = value['sUserName'];
        nationality = value['sNationality'];
        city = value['sCity'];
        lodaing = false;
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
          MiddleName = value.data()!['MiddleName'];
          LastName = value.data()!['LastName'];
          image = value.data()!['ImageURL'];
          Prefix= value.data()!['Prefix'];
          Position= value.data()!['Position'];
          Email = value.data()!['Email'];
          PhoneNumber = value.data()!['PhoneNumber'];
          CompanyName = value.data()!['CompanyName'];
        });
      },
    );
  }

  @override
  void initState() {
    getCardInfo();
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
                      onChanged: (value) => Prefix = value,
                      controller: TextEditingController(text: Prefix),
                      decoration: InputDecoration(
                        labelText: 'Prefix',
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
                      onChanged: (value) => MiddleName = value,
                      controller: TextEditingController(text: MiddleName),
                      decoration: InputDecoration(
                        labelText: 'Middle Name',
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
                      onChanged: (value) => Position = value,
                      controller: TextEditingController(text: Position),
                      decoration: const InputDecoration(
                        labelText: 'Position',
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
                      onChanged: (value) => CompanyName = value,
                      controller: TextEditingController(text: CompanyName),
                      decoration: const InputDecoration(
                        label: Text("CompanyName"),
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
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) => Email = value,
                      controller: TextEditingController(text: Email),
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
                      onChanged: (value) => PhoneNumber = value,
                      controller: TextEditingController(text: PhoneNumber),
                      decoration: const InputDecoration(
                        label: Text("Phone Number"),
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
                  ],
                ),
              ),
              // const location(),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () async {
                  //    Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    await FirebaseFirestore.instance
                        .collection('Cards')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'Prefix': Prefix,
                      'FirstName': FirstName,
                      'MiddleName': MiddleName,
                      'LastName': LastName,
                      'Position': Position,
                      'CompanyName': CompanyName,
                      'Email': Email,
                      'PhoneNumber': PhoneNumber,
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
/// update links
/// check for image 