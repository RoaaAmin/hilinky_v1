import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatefulWidget {

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  String cardId = '';


  void getId() async {
    FirebaseFirestore.instance.collection('Cards').doc(
        FirebaseAuth.instance.currentUser!.uid).get().then((value) {
          setState(() {
            cardId = value.data()!['cardId'];
          });
    }
    );
  }
  @override
  void initState() {
    super.initState();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: QrImageView(
        data: cardId,
        version: QrVersions.auto,
      ),
    );
  }
}