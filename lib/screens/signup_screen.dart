import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../main.dart';
import '../models/SnackBar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  /// user info
  String Error = '';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordConroller = TextEditingController();
  TextEditingController _confirmPasswordConroller = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  void openLoginScreen() {
    Navigator.of(context).pushReplacementNamed('loginScreen');
  }

  String selectedNationality = 'Select Nationality';
  String selectedCity = 'Select City';

  List<String> nationalityOptions = [
    'Select Nationality',
    'Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Antigua and Barbuda', 'Argentina',
    'Armenia', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados',
    'Belarus', 'Belgium', 'Belize', 'Benin', 'Bhutan', 'Bolivia', 'Bosnia and Herzegovina', 'Botswana',
    'Brazil', 'Brunei', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Cambodia', 'Cameroon',
    'Canada', 'Central African Republic', 'Chad', 'Chile', 'China', 'Colombia', 'Comoros', 'Congo (Congo-Brazzaville)',
    'Costa Rica', 'Croatia', 'Cuba', 'Cyprus', 'Czechia (Czech Republic)', 'Democratic Republic of the Congo',
    'Denmark', 'Djibouti', 'Dominica', 'Dominican Republic', 'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea',
    'Eritrea', 'Estonia', 'Eswatini (fmr. "Swaziland")', 'Ethiopia', 'Fiji', 'Finland', 'France', 'Gabon', 'Gambia',
    'Georgia', 'Germany', 'Ghana', 'Greece', 'Grenada', 'Guatemala', 'Guinea', 'Guinea-Bissau', 'Guyana', 'Haiti',
    'Holy See', 'Honduras', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Israel', 'Italy',
    'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati', 'Kuwait', 'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon',
    'Lesotho', 'Liberia', 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives',
    'Mali', 'Malta', 'Marshall Islands', 'Mauritania', 'Mauritius', 'Mexico', 'Micronesia', 'Moldova', 'Monaco', 'Mongolia',
    'Montenegro', 'Morocco', 'Mozambique', 'Myanmar (formerly Burma)', 'Namibia', 'Nauru', 'Nepal', 'Netherlands', 'New Zealand',
    'Nicaragua', 'Niger', 'Nigeria', 'North Korea', 'North Macedonia (formerly Macedonia)', 'Norway', 'Oman', 'Pakistan', 'Palau',
    'Palestine', 'Panama', 'Papua New Guinea', 'Paraguay', 'Peru', 'Philippines', 'Poland', 'Portugal', 'Qatar', 'Romania',
    'Russia', 'Rwanda', 'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Vincent and the Grenadines', 'Samoa', 'San Marino', 'Sao Tome and Principe',
    'Saudi Arabia', 'Senegal', 'Serbia', 'Seychelles', 'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia', 'Solomon Islands', 'Somalia',
    'South Africa', 'South Korea', 'South Sudan', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 'Sweden', 'Switzerland', 'Syria',
    'Tajikistan', 'Tanzania', 'Thailand', 'Timor-Leste', 'Togo', 'Tonga', 'Trinidad and Tobago', 'Tunisia', 'Turkey', 'Turkmenistan',
    'Tuvalu', 'Uganda', 'Ukraine', 'United Arab Emirates', 'United Kingdom', 'United States of America', 'Uruguay', 'Uzbekistan',
    'Vanuatu', 'Venezuela', 'Vietnam', 'Yemen', 'Zambia', 'Zimbabwe'

  ];

  List<String> cityOptions = [
    'Select City',
    'Riyadh',
    'Jeddah',
    'Mecca',
    'Medina',
    'Dammam',
    'Ta\'if',
    'Buraidah',
    'Tabuk',
    'Abha',
    'Al-Khobar',
    'Hail',
    'Al-Qatif',
    'Khamis Mushait',
    'Al-Ahsa',
    'Najran',
    'Yanbu',
    'Al Jubail',
    'Dhahran',
    'Al Hofuf',
    'Jubail Industrial City',
  ];

  void selectNationality() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: nationalityOptions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(nationalityOptions[index]),
              onTap: () {
                setState(() {
                  selectedNationality = nationalityOptions[index];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void selectCity() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: cityOptions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(cityOptions[index]),
              onTap: () {
                setState(() {
                  selectedCity = cityOptions[index];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordConroller.text.trim(),
      );
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  bool passwordConfirmed() {
    if (_passwordConroller.text.trim() ==
        _confirmPasswordConroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordConroller.dispose();
    _confirmPasswordConroller.dispose();
    usernameController.dispose();
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? notificationToken;

  @override
  void initState() {
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      setState(() {
        notificationToken = token;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///Title
                Text(
                  'SIGN UP',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Welcome! Here you can sign up',
                  style: GoogleFonts.robotoCondensed(fontSize: 18),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
//name
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name',
                          prefixIcon: Icon(
                            LineIcons.user,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Username
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                          prefixIcon: Icon(
                            LineIcons.user,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //pass
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
// email text
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email Adress',
                          prefixIcon: Icon(
                            LineIcons.envelope,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // phone num
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                          prefixIcon: Icon(
                            LineIcons.mobilePhone,
                            color: Colors.black38,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),

                          DropdownButton<String>(
                            value: selectedNationality,
                            onChanged: (newValue) {
                              setState(() {
                             selectedNationality = newValue!;
                              });
                            },
                            items: nationalityOptions.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          DropdownButton<String>(
                            value: selectedCity,
                            onChanged: (newValue) {
                              setState(() {
                                selectedCity = newValue!;
                              });
                            },
                            items: cityOptions.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                //pass
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _passwordConroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          prefixIcon: Icon(
                            LineIcons.lock,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //confirm pass
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _confirmPasswordConroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(
                            LineIcons.lock,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 15),
// sign up button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signUpValidation,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.amber[900],
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(
                        'Sign up',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                    ),
                  ),
                ),
                //space between button and text
                SizedBox(height: 25),
                // make text to sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member? ',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: openLoginScreen,
                      child: Text(
                        'sign in Here',
                        style: GoogleFonts.roboto(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//////////////////////////////////////////////

  void signUpValidation() {
    if (nameController.text == null || nameController.text.length < 3) {
      showInSnackBar('Please Enter valid you name.', Colors.red, Colors.white,
          2, context, _scaffoldKey);
    } else if (_emailController.text == null ||
        _emailController.text.contains('@') == false ||
        _emailController.text.contains('.com') == false) {
      showInSnackBar(
          'Invalid Email', Colors.red, Colors.white, 2, context, _scaffoldKey);
    } else if (phoneNumberController.text == null ||
        phoneNumberController.text.contains('05') == false ||
        phoneNumberController.text.length < 10) {
      showInSnackBar('Please enter your phone number, ex: 05xxxxxxxxx',
          Colors.red, Colors.white, 2, context, _scaffoldKey);
    } else if (_passwordConroller.text == null ||
        _passwordConroller.text.length < 6) {
      showInSnackBar('Password is too weak.', Colors.red, Colors.white, 2,
          context, _scaffoldKey);
    } else if (_passwordConroller.text != _confirmPasswordConroller.text) {
      showInSnackBar('Passwords do not match.', Colors.red, Colors.white, 2,
          context, _scaffoldKey);
    } else if (usernameController.text == null ||
        usernameController.text.isEmpty) {
      showInSnackBar('Please enter a valid username.', Colors.red, Colors.white,
          2, context, _scaffoldKey);
    } else {
      checkUsernameAvailability();
      print('Validation Completed');
      //signup();
    }
  }

  Future checkUsernameAvailability() async {
    try {
      QuerySnapshot usernameSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('uniqueUserName', isEqualTo: usernameController.text)
          .get();

      if (usernameSnapshot.docs.isNotEmpty) {
        showInSnackBar('Username is already taken.', Colors.red, Colors.white,
            2, context, _scaffoldKey);
      } else {
        print('Validation Completed');
        signup(); // Proceed with signup if username is available
      }
    } catch (e) {
      // Handle error if the query fails
      print('Error checking username availability: $e');
    }
  }

  Future signup() async {
    DocumentSnapshot<Map<String, dynamic>> userData;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordConroller.text,
      )
          .then((userCredentials) async {
        if (userCredentials.user != null) {
          await userCredentials.user!
              .sendEmailVerification()
              .then((metaData) async {
            try {
              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userCredentials.user!.uid)
                  .set({
                'sUserID': userCredentials.user!.uid,
                'sUserEmail': userCredentials.user!.email,
                'sUserName': nameController.text,
                'sUserPhoneNumber': phoneNumberController.text,
                'sUserNotificationToken': notificationToken,
                'uniqueUserName': usernameController.text,
                'sNationality': selectedNationality,
                'sCity': selectedCity,
                'AccountCreatedDateTime': DateTime.now(),
                'UserProfileImage':'https://www.sketchappsources.com/resources/source-image/profile-illustration-gunaldi-yunus.png',
                'following' : {}
              }).then((value) async {
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userCredentials.user!.uid)
                    .get()
                    .then((userDBData) async {
                  setState(() {
                    userData = userDBData;
                    sUserID = userCredentials.user!.uid;
                    sUserEmail = userDBData.data()!['sUserEmail'];
                    sUserName = userDBData.data()!['sUserName'];
                    uniqueUserName = userDBData.data()!['uniqueUserName'];
                    sUserPhoneNumber = userDBData.data()!['sUserPhoneNumber'];
                    sNationality = userDBData.data()!['sNationality'];
                    sCity = userDBData.data()!['sCity'];
                    sUserNotificationToken =
                        userDBData.data()!['sUserNotificationToken'];
                  });
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  clearControllers();
                  await FirebaseAuth.instance.signOut();
                  showInSnackBar('Registration completed successfully',
                      Colors.green, Colors.white, 3, context, _scaffoldKey);
                  // Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => Auth()));
                });
              });
            } catch (e) {
              await FirebaseAuth.instance.currentUser!
                  .delete()
                  .then((value) async {
                await FirebaseAuth.instance.signOut().then((value) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  showInSnackBar('An error occur!', Colors.red, Colors.white, 3,
                      context, _scaffoldKey);
                  print('$e');
                });
              });
            }
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showInSnackBar(e.message!.trim(), Colors.red, Colors.white, 3, context,
          _scaffoldKey);
    }
  }

  clearControllers() {
    usernameController.clear();
    _emailController.clear();
    _passwordConroller.clear();
    _confirmPasswordConroller.clear();
    nameController.clear();
    phoneNumberController.clear();
    _emailController.clear();
  }
}
