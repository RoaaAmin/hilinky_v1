import 'dart:async';
import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:path_provider/path_provider.dart';
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
              child: Text('Scan result: $result'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData.code!;
        isScanned = true;
      });
      await handleQRData(result);
      controller.pauseCamera();
      if (isScanned) {
        Navigator.of(context).pop();
      }
    });
  }

  Future<void> handleQRData(String qrData) async {
    if (qrData.isNotEmpty) {
      final contactData = parseQRData(qrData);
      await saveContactFromQRCode(contactData);
      await openContactInPhone(contactData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Contact information saved to contacts!'),
      ));
    }
  }

  Future<void> saveContactFromQRCode(Map<String, String> contactData) async {
    final newContact = Contact(
      givenName: contactData['givenName'],
      familyName: contactData['familyName'],
      phones: [Item(label: 'mobile', value: contactData['phone'])],
      emails: [Item(label: 'work', value: contactData['email'])],
    );
    await ContactsService.addContact(newContact);
  }

  Future<void> openContactInPhone(Map<String, String> contactData) async {
    final String vCardData = constructVCard(contactData);
    final String vCardFileName = 'contact.vcf';
    final vCardFilePath = await _localPath;
    final File vCardFile = File('$vCardFilePath/$vCardFileName');
    await vCardFile.writeAsString(vCardData);

    final vCardUri = vCardFile.path;
    if (await canLaunch(vCardUri)) {
      await launch(vCardUri);
    } else {
      throw 'Could not launch $vCardUri';
    }
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  Map<String, String> parseQRData(String qrData) {
    final parts = qrData.split(',');
    final givenName = parts[0];
    final familyName = parts[1];
    final phone = parts[2];
    final email = parts[3];
    return {
      'givenName': givenName,
      'familyName': familyName,
      'phone': phone,
      'email': email,
    };
  }

  String constructVCard(Map<String, String> contactData) {
    return 'BEGIN:VCARD\n' +
        'VERSION:3.0\n' +
        'FN:${contactData['givenName']} ${contactData['familyName']}\n' +
        'TEL:${contactData['phone']}\n' +
        'EMAIL:${contactData['email']}\n' +
        'END:VCARD';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
