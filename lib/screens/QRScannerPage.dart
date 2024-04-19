import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:contacts_service/contacts_service.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      String? qrData = scanData.code;
      handleQRData(qrData);
      controller.dispose();
    });
  }

  Future<void> handleQRData(String? qrData) async {
    if (qrData != null) {
      final contactData = parseQRData(qrData);
      await saveContactFromQRCode(contactData);
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
}
