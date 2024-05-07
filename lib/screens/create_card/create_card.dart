import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilinky/components/context.dart';
import 'package:hilinky/screens/create_card/widgets/socialMedia.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:random_string/random_string.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/size_utils.dart';
import '../../models/SnackBar.dart';
import '../my_card/myCard.dart';

////////////////////////////////

var uuid = Uuid();

class CreateCard extends StatefulWidget {
  CreateCard({Key? key}) : super(key: key);

  @override
  State<CreateCard> createState() => _CreateCardState();
  late DocumentSnapshot<Map<String, dynamic>> card;
}

class _CreateCardState extends State<CreateCard> {
  Map<String, String> links = {};

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int selectedCardIndex = -1; //no selection item
  int customItemIndex1 = 1;
  int customItemIndex2 = 2;

  String? prefix;
  String? firstName;
  String? middleName;
  String? lastName;
  String? position;
  String? companyName;
  String? email;
  String? phoneNumber;

  TextEditingController prefixController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool editMode = false;
  String editModeImageURL = '';
  String editModeImageURLLogo = '';
  String editModeImageURLPortfilio = '';
  File? selectedImage;
  File? selectedLogo;
  File? selectedPortfolio;

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

  Future<String> getuser() async {
    String userCity = '';

    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // Check
      if (userSnapshot.exists && userSnapshot.data() != null) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        userCity = userData['sCity'] ?? '';
      }
    } catch (e) {
      print('Error retrieving user city: $e');
    }

    return userCity; // Return the user's city
  }
  uploadCard() async {
    // Check if the widget is mounted before showing the snackbar
    if (mounted) {
      showInSnackBar(
          context.tr('Please wait while the card is being created...'),
        Colors.green,
        Colors.white,
        4,
        context,
        _scaffoldKey,
      );
    }

    // Check if required fields are filled
    if (firstName != null &&
        lastName != null &&
        position != null &&
        email != null &&
        phoneNumber != null) {
      String imageURL = editMode ? editModeImageURL : '';
      String logoURL = editMode ? editModeImageURLLogo : '';
      String portfolioURL = editMode ? editModeImageURLPortfilio : '';

      try {
        // Upload selected image
        if (selectedImage != null && selectedLogo != null && selectedPortfolio != null) {
          // Upload selected image
          var imageUploadTask = FirebaseStorage.instance
              .ref('Cards/')
              .child(randomAlphaNumeric(9) + '.jpg')
              .putFile(selectedImage!);
          imageURL = await (await imageUploadTask).ref.getDownloadURL();

          // Upload selected logo
          var logoUploadTask = FirebaseStorage.instance
              .ref('Cards/')
              .child(randomAlphaNumeric(9) + '_logo.jpg')
              .putFile(selectedLogo!);
          logoURL = await (await logoUploadTask).ref.getDownloadURL();

          // Upload selected portfolio
          var portfolioUploadTask = FirebaseStorage.instance
              .ref('Cards/')
              .child(randomAlphaNumeric(9) + '_portfolio.jpg')
              .putFile(selectedPortfolio!);
          portfolioURL = await (await portfolioUploadTask).ref.getDownloadURL();
        } else {
          // Handle the case when one of the variables is null
          print('One of the selected files is null');
        }

        if (editMode) {
          // Update card if in edit mode
          await widget.card.reference.update({
            "ImageURL": imageURL,
            "LogoURL": logoURL,
            "PortfolioURL": portfolioURL,
          });
        } else {
          // Fetch the selected city from getuser function
          String selectedCity = await getuser();
          // Upload card details
          await FirebaseFirestore.instance
              .collection('Cards')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({
            "ImageURL": imageURL,
            "LogoURL": logoURL,
            "PortfolioURL": portfolioURL,
            "Prefix": prefix ?? '',
            "FirstName": firstName ?? '',
            "MiddleName": middleName ?? '',
            "LastName": lastName ?? '',
            "Position": position ?? '',
            "CompanyName": companyName ?? '',
            "Email": email ?? '',
            "PhoneNumber": phoneNumber ?? '',
            "Links": links ?? {},
            "cardId": uuid.v4(),
            "PostedByUID": FirebaseAuth.instance.currentUser!.uid,
            "City": selectedCity,
            "TimeStamp": DateTime.now(),
          });

          print('Card saved');
          // Navigate to the 'myCard' screen
          Navigator.pushNamed(context, 'myCard');
        }
      } catch (e) {
        // Handle errors
        print('Error uploading card: $e');
        if (mounted) {
          // Show error message if widget is still mounted
          showInSnackBar(
            'Error uploading card. Please try again later.',
            Colors.red,
            Colors.white,
            3,
            context,
            _scaffoldKey,
          );
        }
      }
    } else {
      // Show error message if required fields or images are not filled
      if (mounted) {
        showInSnackBar(
            context.tr('Please fill all the required fields and select images'),
          Colors.red,
          Colors.white,
          3,
          context,
          _scaffoldKey,
        );
      }
    }
  }

  /*uploadCard() async {
    showInSnackBar(
      'Please wait while the card is being created...',
      Colors.green,
      Colors.white,
      10,
      context,
      _scaffoldKey,
    );
    if (selectedImage != null) {
      String imageURL = editMode ? editModeImageURL : '';
      String logoURL = editMode ? editModeImageURLLogo : '';
      String portfolioURL = editMode ? editModeImageURLPortfilio : '';

      if (!editMode) {
        await FirebaseStorage.instance
            .ref('Cards/')
            .child(randomAlphaNumeric(9).toString() + '.jpg')
            .putFile(selectedImage!)
            .then((value) async {
          imageURL = await value.ref.getDownloadURL();
        });
      }

      if (selectedLogo != null) {
        await FirebaseStorage.instance
            .ref('Cards/')
            .child(randomAlphaNumeric(9).toString() + '_logo.jpg')
            .putFile(selectedLogo!)
            .then((value) async {
          logoURL = await value.ref.getDownloadURL();
        });
      }

      if (selectedPortfolio != null) {
        await FirebaseStorage.instance
            .ref('Cards/')
            .child(randomAlphaNumeric(9).toString() + '_portfolio.jpg')
            .putFile(selectedPortfolio!)
            .then((value) async {
          portfolioURL = await value.ref.getDownloadURL();
        });
      }

      if (editMode) {
        await widget.card.reference.update({
          "ImageURL": imageURL,
          "LogoURL": logoURL,
          "PortfolioURL": portfolioURL,
        });
      } else {
        // Fetch the selected city from getuser function
        String selectedCity = await getuser();
        await FirebaseFirestore.instance
            .collection('Cards')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "ImageURL": imageURL,
          "LogoURL": logoURL,
          "PortfolioURL": portfolioURL,
          "Prefix": prefix,
          "FirstName": firstName,
          "MiddleName": middleName,
          "LastName": lastName,
          "Position": position,
          "CompanyName": companyName,
          "Email": email,
          "PhoneNumber": phoneNumber,
          "Links": links,
          "cardId": uuid.v4(),
          "PostedByUID": FirebaseAuth.instance.currentUser!.uid,
          "City": selectedCity,
          "TimeStamp": DateTime.now(),
        }).then((value) async {
          print('Card saved');
          Navigator.of(context).pop();
        });
        Navigator.pushNamed(context, 'myCard');
      }
    } else {
      showInSnackBar('You have to fill all the fields ', Colors.red,
          Colors.white, 3, context, _scaffoldKey);
    }
  }*/

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
              label: Text(context.tr("Camera")),
            ),
            TextButton.icon(
              icon: Icon(Icons.image, color: Colors.amber[800]),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              label: Text(context.tr("Gallery")),
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
                getLogo(ImageSource.camera);
              },
              label: Text(context.tr("Camera")),
            ),
            TextButton.icon(
              icon: Icon(Icons.image, color: Colors.amber[800]),
              onPressed: () {
                getLogo(ImageSource.gallery);
              },
              label: Text(context.tr("Gallery")),
            ),
          ])
        ],
      ),
    );
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
                getPortfolio(ImageSource.camera);
              },
              label: Text(context.tr("Camera")),
            ),
            TextButton.icon(
              icon: Icon(Icons.image, color: Colors.amber[800]),
              onPressed: () {
                getPortfolio(ImageSource.gallery);
              },
              label: Text(context.tr("Gallery")),
            ),
          ])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  LineIcons.arrowLeft,
                  size: 30.0,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  //   builder: (BuildContext context) => HomeScreen(),
                  // ));
                  context.pop();
                },
              )),
          body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align content to start
                  children: [
                    Text(
              context.tr('Create Card'),
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   'Lorem Ipsum is simply dummy text of the printing',
                    //   style: GoogleFonts.robotoCondensed(fontSize: 18),
                    // ),
                    SizedBox(height: 30),
                    Text(
                        context.tr('Personal Details'),
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: prefixController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: context.tr('Prefix (optional)'),
                            ),
                            onChanged: (val) {
                              prefix = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: context.tr('First Name'),
                            ),

                            onChanged: (val) {
                              firstName = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: middleNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: context.tr('Middle Name (optional)'),
                            ),
                            onChanged: (val) {
                              middleName = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: context.tr('Last Name'),
                            ),
                            onChanged: (val) {
                              lastName = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: positionController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: context.tr('Position'),
                            ),
                            onChanged: (val) {
                              position = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: companyNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: context.tr('Company Name (optional)'),
                            ),
                            onChanged: (val) {
                              companyName = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                        context.tr('Contact'),
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: context.tr('Email'),
                            ),
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: context.tr('Phone Number'),
                            ),
                            onChanged: (val) {
                              phoneNumber = val;
                            },
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                          ),
                        ),

                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                        context.tr('Choose links to add'),
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SocialMedia(
                      saved: links,
                      paddin: EdgeInsets.only(
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
                                image: NetworkImage(editModeImageURL))),
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
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    selectedImage as File,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                // margin: EdgeInsets.symmetric(horizontal: 50),
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    SizedBox(height: 30),
                                    Icon(Icons.account_box, size: 50.0),
                                    Text(
                                      context.tr('Upload your photo'),
                                    ),
                                  ],
                                )),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: editMode,
                          child: Container(
                            //margin: EdgeInsets.symmetric(horizontal: 0),
                            //height: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                    image: NetworkImage(editModeImageURLLogo))),
                            // width: MediaQuery.of(context).size.width,
                          ),
                          replacement: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheetLogo()),
                              );
                            },
                            child: selectedLogo != null
                                ? Container(
                                    //margin: EdgeInsets.symmetric(horizontal: 0),
                                    height: 150,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.file(
                                        selectedLogo as File,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(

                                    // margin: EdgeInsets.symmetric(horizontal: 50),
                                    height: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(6)),
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        30,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 30),
                                        Icon(Icons.upload, size: 50.0),
                                        Text(
                                          context.tr('Upload logo'),
                                        ),
                                      ],
                                    )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: editMode,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            height: 170,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        editModeImageURLPortfilio))),
                            // width: MediaQuery.of(context).size.width,
                          ),
                          replacement: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheetPortfolio()),
                              );
                            },
                            child: selectedPortfolio != null
                                ? Container(
                                    margin: EdgeInsets.symmetric(horizontal: 6),
                                    height: 150,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.file(
                                        selectedPortfolio as File,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    height: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(6)),
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        30,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 30),
                                        Icon(Icons.upload, size: 50.0),
                                        Text(
                                          context.tr('Upload portfolio'),
                                        ),
                                      ],
                                    )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: GestureDetector(
                        onTap: uploadCard,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: Text(
                                  context.tr('Continue'),
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ])),
    );
  }
}
