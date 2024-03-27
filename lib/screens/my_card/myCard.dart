import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiwetaan/screens/my_card/widget/qr_code.dart';

import 'package:line_icons/line_icons.dart';

import 'package:loading_indicator/loading_indicator.dart';

import '../../main.dart';

class MyCard extends StatefulWidget {
  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool myCardFetched = false;

  late DocumentSnapshot<Map<String, dynamic>> userData;
  List<DocumentSnapshot<Map<String, dynamic>>> cardsDocs= [];

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getMyCards() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUID = user.uid;

      await FirebaseFirestore.instance.collection('Cards')
          .where('PostedByUID', isEqualTo: userUID)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          setState(() {
            cardsDocs = value.docs.toList();
            myCardFetched = true;
          });
          cardsDocs.sort((a, b) => b.data()!['TimeStamp'].compareTo(a.data()!['TimeStamp']));
        }
      });
    }
  }

  getUserData() async {
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      setState(() {
        userData = value;
        getMyCards();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: ListView(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(LineIcons.bell, size:30.0),
                    onPressed: () {
                      // Navigator.pushNamed(context, notificationsViewRoute);
                    }
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0, bottom: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 1.0, bottom: 20.0),
                          child: Text(
                            "my Card",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            flowList(context),
          ],
        ),
    );
  }

  Widget flowList(BuildContext context) {
    if (cardsDocs != null) {
      if (cardsDocs.length != 0) {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left:10.0,right: 10,top: 10,bottom: 75),
            itemCount: cardsDocs.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: ()async{
                  //  showUserBottomSheet(postsDocs[i]);
                },
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 110,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFF495592),
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(image: NetworkImage(cardsDocs[i].data()!['ImageURL']), fit: BoxFit.fill),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                            ),
                          ],
                        ),
                        Divider(
                          color: Color(0xFF495592).withOpacity(0.9),
                        ),
                        Text(
                          'name:',
                          style: TextStyle(color: Color(0xFF495592), fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        Text(
                          cardsDocs[i].data()!['FirstName'],
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                        Divider(
                          color: Color(0xFF495592).withOpacity(0.9),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Position: ',
                                  style: TextStyle(color: Color(0xFF495592), fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                Text(
                                  cardsDocs[i].data()!['Position'],
                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 14),
                                ),
                                // postsDocs[i].data()!['TimeStamp'],
                              ],

                            ),
                          ],
                        ),
                        QrCode(),
                      ],
                    ),
                  ),
                ),
              );
            });
      } else {
        // print('No post');
        return Center(child: CircularProgressIndicator());

      }
    } else {

      //print('Noo post');
      return Center(child: CircularProgressIndicator());

    }
  }




}