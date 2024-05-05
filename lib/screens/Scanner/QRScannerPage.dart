import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String result = '';
  bool isScanned = false;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      print("Contacts Permission Granted!");
    } else {
      print("Contacts Permission Denied!");
    }
    if (await Permission.camera.request().isGranted) {
      print("Camera Permission Granted!");
    } else {
      print("Camera Permission Denied!");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
            //  child: Text('Scan result: $result'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    if (!mounted) return; // Check if the widget is still mounted

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (!mounted) return; // Check if the widget is still mounted

      setState(() {
        result = scanData.code!;
      });

      await Future.delayed(Duration(milliseconds: 500));
      openContactInContacts(result);
    });
  }
  void openContactInContacts(String qrData) async {
    final contactData = parseQRData(qrData);

    final Uri url = Uri(
      scheme: 'tel',
      path: contactData['phone'],


    );

    final String encodedUrl = Uri.encodeFull(url.toString());

    if (await canLaunch(encodedUrl)) {
      await launch(encodedUrl);
    } else {
      print('Error: Could not launch $encodedUrl');
    }
  }



  Map<String, String> parseQRData(String qrData) {
    List<String> lines = qrData.split('\n');
    String givenName = '';
    String phone = '';
    String email = '';

    for (String line in lines) {
      if (line.startsWith('FN:')) {
        givenName = line.substring(3);
      } else if (line.startsWith('TEL:')) {
        phone = line.substring(4);
      } else if (line.startsWith('EMAIL:')) {
        email = line.substring(6);
      }
    }

    return {
      'givenName': givenName,
      'phone': phone,
      'email': email
    };

  }


//
// void openContactInContacts(String qrData) async {
//   final contactData = parseQRData(qrData);
//   final Uri url = 'contacts://add?givenName=${contactData['givenName']}&familyName=${contactData['familyName']}&phone=${contactData['phone']}&email=${contactData['email']}' as Uri;
//
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     print('Error: Failed to open the contacts app.');
//   }
// }

// Map<String, dynamic> parseQRData(String qrData) {
//   // Implement your own logic to parse the QR code data
//   // and extract the contact information.
//   // Return a map containing the contact details.
//   // Example:
//   return {
//     'givenName': 'John',
//     'familyName': 'Doe',
//     'phone': '+1234567890',
//     'email': 'john.doe@example.com',
//   };

}