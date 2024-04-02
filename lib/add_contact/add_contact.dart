import 'dart:async';
import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MyCardState extends StatefulWidget {
  @override
  State<MyCardState> createState() => _MyCardState();
}

class _MyCardState extends State<MyCardState> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
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
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      String? qrData = scanData.code;
      handleQRData(qrData);
      controller.dispose();
    });
  }

  Future<void> handleQRData(String? qrData) async {
    if (qrData != null) {
      final contactData = parseQRData(qrData);
      await saveContactFromQRCode(contactData);
      await addVCardToWallet(contactData);
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Contact information saved to contacts!'),
    ));
  }

  Future<void> addVCardToWallet(Map<String, String> contactData) async {
    final String vCardData = constructVCard(contactData);
    final String vCardFilePath = '/path/to/your/vCard.vcf';
    final File vCardFile = File(vCardFilePath);
    await vCardFile.writeAsString(vCardData);
    // Instruct the user to download the vCard file
    // You can use a package like url_launcher to open a download link
    // Alternatively, provide instructions within your app interface
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
}
