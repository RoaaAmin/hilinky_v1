import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCode extends StatefulWidget {
  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  late Map<String, dynamic> cardData = {};

  @override
  void initState() {
    super.initState();
    getCardData();
  }

  void getCardData() async {
    final userUID = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('Cards').doc(userUID).get();
    setState(() {
      cardData = snapshot.data()!;
    });
  }


  Future<void> openContactInPhone() async {
    if (cardData == null) {
      // Handle the case where cardData is not initialized yet
      return;
    }

    final String vCardData = constructVCard();
    final String contactUrl =
        'data:text/vcard;charset=utf-8;base64,' + base64Encode(utf8.encode(vCardData));

    // Make sure to specify a valid scheme (http/https) for the contactUrl
    final String validContactUrl = 'http://' + contactUrl;

    if (await canLaunch(validContactUrl)) {
      await launch(validContactUrl);
    } else {
      throw 'Could not launch $validContactUrl';
    }
  }



  String constructVCard()  {
    if (cardData == null) {
      // Handle the case where cardData is not initialized yet
      return '';
    }

    Future<String> _getImageBase64(String imageUrl) async {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        final String base64Image = base64Encode(bytes);
        return base64Image;
      } else {
        throw Exception('Failed to load image');
      }
    }

    // Construct vCard data using the card information
    final String vCardData = 'BEGIN:VCARD\n' +
        'VERSION:3.0\n' +
        'FN:${cardData['FirstName']} ${cardData['LastName']}\n' +
        'N:${cardData['LastName']};${cardData['FirstName']}\n' +
        '${cardData['CompanyName'] != null && cardData['CompanyName'].isNotEmpty ? 'ORG:${cardData['CompanyName']}\n' : ''}' +
        'TEL:${cardData['PhoneNumber']}\n' +
        'EMAIL:${cardData['Email']}\n' +
        'TITLE:${cardData['Position']}\n' +
        '${cardData['Links'] != null && cardData['Links']['facebook'] != null ? 'X-SOCIALPROFILE;type=facebook:${cardData['Links']['facebook']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['twitter'] != null ? 'X-SOCIALPROFILE;type=twitter:${cardData['Links']['twitter']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['linkedin'] != null ? 'X-SOCIALPROFILE;type=linkedin:${cardData['Links']['linkedin']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['figma'] != null ? 'X-SOCIALPROFILE;type=figma:${cardData['Links']['figma']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['youtube'] != null ? 'X-SOCIALPROFILE;type=youtube:${cardData['Links']['youtube']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['behance'] != null ? 'X-SOCIALPROFILE;type=behance:${cardData['Links']['behance']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['discord'] != null ? 'X-SOCIALPROFILE;type=discord:${cardData['Links']['discord']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['github'] != null ? 'X-SOCIALPROFILE;type=github:${cardData['Links']['github']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['instagram'] != null ? 'X-SOCIALPROFILE;type=instagram:${cardData['Links']['instagram']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['location'] != null ? 'X-SOCIALPROFILE;type=location:${cardData['Links']['location']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['telegram'] != null ? 'X-SOCIALPROFILE;type=telegram:${cardData['Links']['telegram']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['whatsapp'] != null ? 'X-SOCIALPROFILE;type=whatsapp:${cardData['Links']['whatsapp']}\n' : ''}' +
        '${cardData['Links'] != null && cardData['Links']['tiktok'] != null ? 'X-SOCIALPROFILE;type=tiktok:${cardData['Links']['tiktok']}\n' : ''}' +
        'END:VCARD';

    return vCardData;
  }




  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,

      child: GestureDetector(
        onTap: openContactInPhone,
        child: cardData != null
            ? QrImageView(
          // backgroundColor: Colors.white, // Set the background color here
          foregroundColor: Colors.white, // Set the foreground color here
          data: constructVCard(),
          version: QrVersions.auto,
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

}
