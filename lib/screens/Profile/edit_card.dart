import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilinky/components/context.dart';
import 'package:hilinky/screens/Profile/profile.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/size_utils.dart';
import '../../models/SnackBar.dart';
import '../../nav_bar.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../create_card/widgets/socialMedia.dart';
import 'image_picker.dart';

class EditCard extends StatefulWidget {
  const EditCard({super.key});

  @override
  EditState createState() {
    return EditState();
  }
}

class EditState extends State<EditCard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  imagePicker controller = Get.put(imagePicker());

  final _formKey = GlobalKey<FormState>();
  List<DocumentSnapshot<Map<String, dynamic>>> postsDocs = [];
  bool postsFetched = false;
  DocumentSnapshot<Map<String, dynamic>>? userData;
  Map<String, String> links = {};

  bool editMode = false;

  String editModeImageURL = '';
  String editModeImageURLLogo = '';
  String editModeImageURLPortfilio = '';


  File? selectedImage;
  File? selectedLogo;
  File? selectedPortfolio;

  var selectedImageURL;
  var selectedLogoURL;
  var selectedPortfolioURL;

  var imageURL;
  var logoURL;
  var portfolioURL;


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
            context.tr("Upload your photo"),
            style: TextStyle(
              color: Color.fromARGB(255, 2, 84, 86),
              fontWeight: FontWeight.bold,
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
            SizedBox(
              width: 10,
            ),
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

  Widget bottomSheetLogo() {
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
            context.tr("Upload logo"),
            style: TextStyle(
              color: Color.fromARGB(255, 2, 84, 86),
              fontWeight: FontWeight.bold,
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
                getLogo(ImageSource.camera);
              },
              label: Text(context.tr("Camera"),style: TextStyle(color: Color.fromARGB(255, 2, 84, 86)),),
            ),
            SizedBox(
              width: 10,
            ),
            TextButton.icon(
              icon: Icon(Icons.image, color: Colors.amber[800]),
              onPressed: () {
                getLogo(ImageSource.gallery);
              },
              label: Text(context.tr("Gallery"),style: TextStyle( color: Color.fromARGB(255, 2, 84, 86),),),
            ),
          ])
        ],
      ),
    );
  }
  void updateLinks(Map<String, String> updatedLinks) {
    setState(() {
      links = updatedLinks;
    });
    print('Updated Links: $links');
  }


  Widget bottomSheetPortfolio() {
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
            context.tr("Upload portfolio"),
            style: TextStyle(
              color: Color.fromARGB(255, 2, 84, 86),
              fontWeight: FontWeight.bold,
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
                getPortfolio(ImageSource.camera);
              },
              label: Text(context.tr("Camera"),style: TextStyle(color: Color.fromARGB(255, 2, 84, 86),),),
            ),
            SizedBox(
              width: 10,
            ),
            TextButton.icon(
              icon: Icon(Icons.image, color: Colors.amber[800]),
              onPressed: () {
                getPortfolio(ImageSource.gallery);
              },
              label: Text(context.tr("Gallery"),style: TextStyle(color: Color.fromARGB(255, 2, 84, 86),),),
            ),
          ])
        ],
      ),
    );
  }

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.platform
        .getImageFromSource(source: source); //pickImage
    print('printing source of image $source');
    setState(() {
      selectedImage = File(image!.path);
    });
  }

  Future getLogo(ImageSource source) async {
    var image = await ImagePicker.platform
        .getImageFromSource(source: source); //pickImage
    print('printing source of image $source');
    setState(() {
      selectedLogo = File(image!.path);
    });
  }

  Future getPortfolio(ImageSource source) async {
    var image = await ImagePicker.platform
        .getImageFromSource(source: source); //pickImage
    print('printing source of image $source');
    setState(() {
      selectedPortfolio = File(image!.path);
    });
  }

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
        .then((value) {
      setState(() {
        FirstName = value.data()!['FirstName'];
        MiddleName = value.data()!['MiddleName'];
        LastName = value.data()!['LastName'];
        imageURL = value.data()!['ImageURL'];
        logoURL = value.data()!['LogoURL'];
        portfolioURL = value.data()!['PortfolioURL'];
        Prefix = value.data()!['Prefix'];
        Position = value.data()!['Position'];
        Email = value.data()!['Email'];
        PhoneNumber = value.data()!['PhoneNumber'];
        CompanyName = value.data()!['CompanyName'];
        links = value.data()!['Links'];
      });
    });
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
    return GestureDetector(
        onTap: () {
      // Dismiss the keyboard when tapped outside of any text field
      FocusScope.of(context).unfocus();
    },
    child: lodaing
        ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),))
        : Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.white.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: appTheme.whiteA700,
          title: Text(
            context.tr('Edit card'),
            //textAlign: TextAlign.center,
            style: GoogleFonts.robotoCondensed(
                color: const Color.fromARGB(255, 2, 84, 86),
                fontSize: 30, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () => Navigator.of(context).pop(),
          ),),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
                children: [
                  SizedBox(height: 30),
                  Text(
                      context.tr('Fill the information to display it in your card.'),
                    style: TextStyle(
                      color: Color(0xFF7EA9BA),
                      fontSize: 18,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    context.tr('Personal Details'),
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 84, 86),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 10,),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr("Prefix"),
                              style: CustomTextStyles.titleMediumTeal300,
                            ),
                            SizedBox(
                              width: 354,
                              // height: 54,
                              child: TextFormField(
                                onChanged: (value) => Prefix = value,
                                controller: TextEditingController(text: Prefix),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.white, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: context.tr("Enter your prefix"),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                                cursorColor: Colors.black,
                                // keyboardType: TextInputType.phone,
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                // ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 354,
                          // height: 54,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr("First Name"),
                                style: CustomTextStyles.titleMediumTeal300,
                              ),
                              // SizedBox(height: 8), // Add some spacing between Text and TextFormField
                              TextFormField(
                                onChanged: (value) => FirstName = value,
                                controller: TextEditingController(text: FirstName),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.white, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: context.tr("Enter your first name"),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                                cursorColor: Colors.black,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.tr('Please enter some text');
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 354,
                          // height: 54,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr("Middle Name"),
                                style: CustomTextStyles.titleMediumTeal300,
                              ),
                              // SizedBox(height: 8), // Add some spacing between Text and TextFormField
                              TextFormField(
                                onChanged: (value) => MiddleName = value,
                                controller: TextEditingController(text: MiddleName),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.white, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: context.tr("Enter your middle name"),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                                cursorColor: Colors.red, // Change cursor color to red
                                validator: (value) {
                                  // Validation logic here if needed
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 354,
                          // height: 54,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr("Last Name"),
                                style: CustomTextStyles.titleMediumTeal300,
                              ),
                              // SizedBox(height: 8), // Add some spacing between Text and TextFormField
                              TextFormField(
                                onChanged: (value) => LastName = value,
                                controller: TextEditingController(text: LastName),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.white, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: context.tr("Enter your last name"),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                                cursorColor: Colors.black, // Set cursor color to black
                                keyboardType: TextInputType.text, // Set keyboard type
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.tr('Please enter some text');
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 354,
                          // height: 54,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr("Position"),
                                style: CustomTextStyles.titleMediumTeal300,
                              ),
                              // SizedBox(height: 8), // Add some spacing between Text and TextFormField
                              TextFormField(
                                onChanged: (value) => Position = value,
                                controller: TextEditingController(text: Position),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.white, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: context.tr("Enter your position"),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                                cursorColor: Colors.black, // Set cursor color to black
                                keyboardType: TextInputType.text, // Set keyboard type
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.tr('Please enter some text');
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 354,
                          // height: 54,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr("CompanyName"),
                                style: CustomTextStyles.titleMediumTeal300,
                              ),
                              // SizedBox(height: 8), // Add some spacing between Text and TextFormField
                              TextFormField(
                                onChanged: (value) => CompanyName = value,
                                controller: TextEditingController(text: CompanyName),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.white, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: context.tr("Enter your company name"),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                ),
                                cursorColor: Colors.black, // Set cursor color to black
                                keyboardType: TextInputType.text, // Set keyboard type
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.tr('Please enter some text');
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 354,
                          // height: 54,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr("Phone Number"),
                                style: CustomTextStyles.titleMediumTeal300,
                              ),
                              // SizedBox(height: 8), // Add some spacing between Text and TextFormField
                              TextFormField(
                                onChanged: (value) => PhoneNumber = value,
                                controller: TextEditingController(text: PhoneNumber),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.white, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: context.tr("Enter your phone number"),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  // labelText: context.tr('Phone Number'), // Set the label text
                                ),
                                cursorColor: Colors.black, // Set cursor color to black
                                keyboardType: TextInputType.number, // Set keyboard type to number
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numeric input
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.tr('Please enter some text');
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 354,
                          // height: 54,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr("Email"),
                                style: CustomTextStyles.titleMediumTeal300,
                              ),
                              // SizedBox(height: 8), // Add some spacing between Text and TextFormField
                              TextFormField(
                                onChanged: (value) => Email = value,
                                controller: TextEditingController(text: Email),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.teal300, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(color: appTheme.white, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: context.tr("Enter your email"),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  // labelText: context.tr('Email'), // Set the label text
                                ),
                                cursorColor: Colors.black, // Set cursor color to black
                                keyboardType: TextInputType.emailAddress, // Set keyboard type to email address
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.tr('Please enter some text');
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    context.tr('Choose links to edit'),
                    style: GoogleFonts.robotoCondensed(
                        color: Color.fromARGB(255, 2, 84, 86),
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  SocialMedia(
                    saved: links,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                  ),

                  Padding(
                    padding: getPadding(
                      top: 16,
                      // right: 74,
                    ),
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: editMode,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: NetworkImage(editModeImageURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    replacement: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheet()),
                        );
                      },
                      child: selectedImage != null
                          ? Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                          : Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Color(0xFF286F8C),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: selectedImage != null
                              ? Image.file(
                            selectedImage!,
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )
                              : Image.network(
                            imageURL ?? '',
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Visibility(
                  //         visible: editMode,
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(6),
                  //             image: DecorationImage(
                  //               image: NetworkImage(editModeImageURLLogo),
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //         replacement: GestureDetector(
                  //           onTap: () {
                  //             showModalBottomSheet(
                  //               context: context,
                  //               builder: ((builder) => bottomSheetLogo()),
                  //             );
                  //           },
                  //           child: selectedLogo != null
                  //               ? Container(
                  //             height: 150,
                  //             width: 150,
                  //             child: ClipRRect(
                  //               borderRadius: BorderRadius.circular(6),
                  //               child: Image.file(
                  //                 selectedLogo!,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           )
                  //               : Container(
                  //             height: 170,
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               border: Border.all(
                  //                 style: BorderStyle.solid,
                  //                 color: Color(0xFF286F8C),
                  //               ),
                  //               borderRadius: BorderRadius.circular(6),
                  //             ),
                  //             child: Center(
                  //               child: selectedLogo != null
                  //                   ? Image.file(
                  //                 selectedLogo!,
                  //                 height: 150,
                  //                 width: 150,
                  //                 fit: BoxFit.cover,
                  //               )
                  //                   : Image.network(
                  //                 logoURL ?? '',
                  //                 height: 170,
                  //                 width: 170,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 10),
                  //     Expanded(
                  //       child: Visibility(
                  //         visible: editMode,
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(6),
                  //             image: DecorationImage(
                  //               image: NetworkImage(editModeImageURLPortfilio),
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //         replacement: GestureDetector(
                  //           onTap: () {
                  //             showModalBottomSheet(
                  //               context: context,
                  //               builder: ((builder) => bottomSheetPortfolio()),
                  //             );
                  //           },
                  //           child: selectedPortfolio != null
                  //               ? Container(
                  //             height: 150,
                  //             width: 150,
                  //             child: ClipRRect(
                  //               borderRadius: BorderRadius.circular(6),
                  //               child: Image.file(
                  //                 selectedPortfolio!,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           )
                  //               : Container(
                  //             height: 170,
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               border: Border.all(
                  //                 style: BorderStyle.solid,
                  //                 color: Color(0xFF286F8C),
                  //               ),
                  //               borderRadius: BorderRadius.circular(6),
                  //             ),
                  //             child: Center(
                  //               child: selectedPortfolio != null
                  //                   ? Image.file(
                  //                 selectedPortfolio!,
                  //                 height: 150,
                  //                 width: 150,
                  //                 fit: BoxFit.cover,
                  //               )
                  //                   : Image.network(
                  //                 portfolioURL ?? '',
                  //
                  //                 height: 170,
                  //                 width: 170,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  SizedBox(
                    height: 20,
                  ),
                  //update card data
        ElevatedButton(
          onPressed: () => _showLogoutConfirmationDialog(context),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF234E5C)),
          ),
          child: Padding(
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
        )



        ]
            ))));

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
            context.tr("Are you sure you want to save your card's information?"),
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
                if (_formKey.currentState!.validate()) {

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),),
                              SizedBox(width: 20),
                              Text(context.tr('Saving...')),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                  try {
                    // Check if any image is selected
                    if (selectedImage != null || selectedLogo != null || selectedPortfolio != null) {
                      // Upload images to Firebase Storage and get their URLs
                      if (selectedImage != null) {
                        final imageRef = FirebaseStorage.instance.ref().child('images').child('user_image.jpg');
                        final uploadTask = imageRef.putFile(selectedImage!);
                        final snapshot = await uploadTask.whenComplete(() => null);
                        imageURL = await snapshot.ref.getDownloadURL();
                      }

                      // if (selectedLogo != null) {
                      //   final logoRef = FirebaseStorage.instance.ref().child('images').child('user_logo.jpg');
                      //   final uploadTask = logoRef.putFile(selectedLogo!);
                      //   final snapshot = await uploadTask.whenComplete(() => null);
                      //   logoURL = await snapshot.ref.getDownloadURL();
                      // }
                      //
                      // if (selectedPortfolio != null) {
                      //   final portfolioRef = FirebaseStorage.instance.ref().child('images').child('user_portfolio.jpg');
                      //   final uploadTask = portfolioRef.putFile(selectedPortfolio!);
                      //   final snapshot = await uploadTask.whenComplete(() => null);
                      //   portfolioURL = await snapshot.ref.getDownloadURL();
                      // }
                    }

                    // Fetch existing card data from Firestore
                    DocumentSnapshot<Map<String, dynamic>> cardSnapshot = await FirebaseFirestore.instance
                        .collection('Cards')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get();

                    // Extract existing card data
                    Map<String, dynamic> existingData = cardSnapshot.data() ?? {};

                    // Get existing links
                    Map<String, String> existingLinks = Map<String, String>.from(existingData['Links'] ?? {});

                    // Merge updated links with existing data
                    Map<String, String> updatedLinks = {
                      ...existingLinks, // Spread existing links
                      ...links, // New links
                    };

                    // Merge updated data
                    Map<String, dynamic> updatedData = {
                      ...existingData, // Spread existing data
                      'Prefix': Prefix,
                      'FirstName': FirstName,
                      'MiddleName': MiddleName,
                      'LastName': LastName,
                      'Position': Position,
                      'CompanyName': CompanyName,
                      'Email': Email,
                      'PhoneNumber': PhoneNumber,
                      'Links': updatedLinks, // Updated links in Firestore
                      'ImageURL': imageURL, // Update imageURL
                      //'LogoURL': logoURL, // Update logoURL
                      //'PortfolioURL': portfolioURL, // Update portfolioURL
                      'defaultLogo':'https://firebasestorage.googleapis.com/v0/b/hiwetaan.appspot.com/o/images%2Fuser_image.jpg?alt=media&token=f0359660-ed0d-4edd-9df3-85a8fc087d7a',
                    };

                    // Update user's card information in Firestore
                    await FirebaseFirestore.instance
                        .collection('Cards')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update(updatedData);

                    // Dismiss the loading dialog
                    Navigator.of(context).pop();

                    // Show a snackbar to indicate successful save
                    showInSnackBar(context.tr('Your card information has been saved successfully'), Colors.green, Colors.white, 3, context, _scaffoldKey);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Home(currentIndex: 1),
                      ),
                    );
                  } catch (error) {
                    // Dismiss the loading dialog
                    Navigator.of(context).pop();

                    // Show an error snackbar
                    showInSnackBar(context.tr('An error occurred while saving your card information'), Colors.red, Colors.white, 3, context, _scaffoldKey);
                  }
                } else {
                  showInSnackBar(context.tr('Please create your card first'), Colors.red, Colors.white, 3, context, _scaffoldKey);
                }
              },
            ),
          ],
        );
      },
    );
  }
}