import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cardSearchDetails/CardDetailsData.dart';
import '../cardSearchDetails/cardDetails.dart';
import '../profilePage/ProfilePage.dart';


class QRScannerPage extends StatefulWidget {
  String? postedByUID;

  QRScannerPage({super.key, this.postedByUID});

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  late final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  late DocumentSnapshot<Map<String, dynamic>> userData;
  List<DocumentSnapshot<Map<String, dynamic>>> cardsDocs = [];
  List<CardDetailsData> savedCards = [];
  bool myCardFetched = false;

  var following = [];

  var FirstName = '';
  var LastName = '';
  var Position = '';
  var CompanyName = '';
  var uniqueUserName = '';

  void getFollowing() async {
    final id = await FirebaseAuth.instance.currentUser!.uid;
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();
    setState(() {
      following = user.data()!['followedCards'];
    });
  }

  getMyCards(data) async {
    print('card is commmmmming');
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Cards')
          .where('cardId', isEqualTo: data)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          setState(() {
            cardsDocs = value.docs.toList();
            myCardFetched = true;
          });
          cardsDocs.sort((a, b) =>
              b.data()!['TimeStamp'].compareTo(a.data()!['TimeStamp']));
        }
      });
    }
  }

  Map<String, dynamic> Links = {};

  void getLinks() async {
    await FirebaseFirestore.instance
        .collection('Cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        Links.clear();
        Links = value.data()!['Links'];
        Links.removeWhere((key, value) => value == '');
      },
    );
  }

  String cardId = '';

  void getId() async {
    FirebaseFirestore.instance
        .collection('Cards')
        .doc(widget.postedByUID)
        .get()
        .then((value) {
      setState(() {
        cardId = value.data()!['cardId'];
        widget.postedByUID = cardId;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getLinks();
    getFollowing();
    super.initState();
  }



  Map<String, FaIcon> l = {
    'facebook': const FaIcon(FontAwesomeIcons.facebook),
    'twitter': const FaIcon(FontAwesomeIcons.twitter),
    'linkedin': const FaIcon(FontAwesomeIcons.linkedin),
    'youtube': const FaIcon(FontAwesomeIcons.youtube),
    'instagram': const FaIcon(FontAwesomeIcons.instagram),
    'telegram': const FaIcon(FontAwesomeIcons.telegram),
    'whatsapp': const FaIcon(FontAwesomeIcons.whatsapp),
    'github': const FaIcon(FontAwesomeIcons.github),
    'discord': const FaIcon(FontAwesomeIcons.discord),
    'figma': const FaIcon(FontAwesomeIcons.figma),
    'dribbble': const FaIcon(FontAwesomeIcons.dribbble),
    'behance': const FaIcon(FontAwesomeIcons.behance),
    'location': const FaIcon(FontAwesomeIcons.location),
  };

  @override
  Widget build(BuildContext context) {
    List<String> keys = Links.keys.toList();
    List<dynamic> values = Links.values.toList();

    Widget curent = Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(context.tr('Scan a QR code')),
          ),
        ),
      ],
    );
    if (cardsDocs != null) {
      if (cardsDocs.length != 0) {
        curent = ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 75),
          itemCount: cardsDocs.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () async {
                print('FLOWLIST ID -> ${cardsDocs[i].data()!['PostedByUID']}');
                print('FLOWLIST CardID -> ${cardsDocs[i].id}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardDetails(
                      postedByUID: cardsDocs[i].data()!['PostedByUID'],
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 3,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        elevation: 3,
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Image(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/bigbig.png"),
                              //    height: 190,
                              // width: context.width,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    maxRadius: 30,
                                    backgroundImage: NetworkImage(
                                        cardsDocs[i].data()!['LogoURL']),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(cardsDocs[i]
                                              .data()!['FirstName']),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              cardsDocs[i].data()!['LastName']),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              cardsDocs[i].data()!['Position']),
                                          Text('  -  '),
                                          Text(cardsDocs[i]
                                                  .data()!['CompanyName'] ??
                                              ''),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width: 150,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: Links.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              Colors.orange,
                                                              Colors.deepOrange
                                                            ],
                                                            end: Alignment
                                                                .topLeft,
                                                            begin: Alignment
                                                                .bottomRight),
                                                      ),
                                                      width: 35,
                                                      height: 35,
                                                      child: Center(
                                                        child: IconButton(
                                                          isSelected: true,
                                                          iconSize: 20,
                                                          onPressed: () {
                                                            final Uri url =
                                                                Uri.parse(
                                                                    values[
                                                                        index]);
                                                            _launchUrl(url);
                                                          },
                                                          icon: Icon(
                                                              l[keys[index]]!
                                                                  .icon),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: QrImageView(
                          data: cardId,
                          version: QrVersions.auto,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          following
                                  .contains(cardsDocs[i].data()!['PostedByUID'])
                              ? ElevatedButton(
                                  onPressed: () => unSave(i),
                                  child: const Text('already saved'),
                                )
                              : ElevatedButton(
                                  onPressed: () => save(i),
                                  child: Text('Save'),
                                ),
                          SizedBox(width: 10),
                          // Add some spacing between the buttons
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                      postedByUID:
                                          cardsDocs[i].data()!['PostedByUID'],
                                    ),
                                  ));
                            },
                            child: Text('View Profile'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(context.tr('QR Code Scanner')),
        ),
        body: curent);
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null && scanData.code != null) {
        /// Handle the scanned data here.
        getMyCards(scanData.code);
        print(scanData.code);
      }
    });
  }

  void save(i) async {
    following.add(cardsDocs[i].data()!['PostedByUID']);
    print('add to local');
    var fire = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      fire.update({'followedCards': following});
    });
  }

  void unSave(i) async {
    following.remove(cardsDocs[i].data()!['PostedByUID']);

    var fire = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      fire.update({'followedCards': following});
    });
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
