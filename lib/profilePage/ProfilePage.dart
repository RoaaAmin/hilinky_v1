import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfilePage extends StatefulWidget {
  final String? postedByUID;

  ProfilePage({Key? key, this.postedByUID}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<DocumentSnapshot<Map<String, dynamic>>> postsDocs = [];
  bool postsFetched = false;
  DocumentSnapshot<Map<String, dynamic>>? userData;
  String? specifiedUserID;
  Map<String, dynamic> Links = {};

  var UserProfileImage;

  void getLinks() async {
    await FirebaseFirestore.instance
        .collection('Cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        UserProfileImage = value.data()!['UserProfileImage'];
        Links.clear();
        setState(() {
          Links = value.data()!['Links'];
        });
        Links.removeWhere((key, value) => value == '');
      },
    );
  }

  @override
  void initState() {
    getLinks();
    getFollowers();
    print('print widget postedByUID 11 : ${widget.postedByUID}'); // empty
    super.initState();
    if (widget.postedByUID == '' || widget.postedByUID == null) {
      specifiedUserID = FirebaseAuth.instance.currentUser!.uid;
    } else {
      specifiedUserID = widget.postedByUID;
    }
    getUserData();
    getCardInfo();
    getUserInfo();
    // print('print widget postedByUID 22 : ${widget.postedByUID}'); // not empty
  }

  var following = [];

  void getFollowers() async {
    final id = await FirebaseAuth.instance.currentUser!.uid;
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();

    following = user.data()!['following'];
  }

  void makeFollow() async {
    final id = await FirebaseAuth.instance.currentUser!.uid;
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();
    following = user.data()!['following'];
    following.add(specifiedUserID);

    var fire = await FirebaseFirestore.instance.collection('Users').doc(id);

    setState(() {
      fire.update({'following': following});
    });
  }

  void unFollow() async {
    final id = await FirebaseAuth.instance.currentUser!.uid;
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();
    following = user.data()!['following'];
    following.remove(specifiedUserID);

    var fire = await FirebaseFirestore.instance.collection('Users').doc(id);

    setState(() {
      fire.update({'following': following});
    });
  }

  getPosts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUID = user.uid;

      await FirebaseFirestore.instance
          .collection('Posts')
          .where('PostedByUID', isEqualTo: specifiedUserID)
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

  var FirstName = '';
  var LastName = '';
  var Position = '';
  var CompanyName = '';
  var uniqueUserName = '';

  void getCardInfo() async {
    var user = await FirebaseFirestore.instance
        .collection('Cards')
        .doc(specifiedUserID)
        .get();
    if (user.exists) {
      print("Card Data: ${user.data()}");
      setState(() {
        FirstName = user.data()!['FirstName'];
        LastName = user.data()!['LastName'];
        Position = user.data()!['Position'];
        CompanyName = user.data()!['CompanyName'];
        Links = user.data()!['Links'];
      });
    } else {
      print("Card data not found");
    }
  }

  void getUserInfo() async {
    var user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(specifiedUserID)
        .get();
    if (user.exists) {
      print("User Data: ${user.data()}");
      setState(() {
        uniqueUserName = user.data()!['uniqueUserName'];
      });
    } else {
      print("User data not found");
    }
  }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(specifiedUserID)
        .get()
        .then((value) {
      setState(() {
        userData = value;
        getPosts();
      });
    });
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF8F8F8),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 300.0,
                  ),
                  Container(
                    height: 150.0,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 130.0,
                            width: 130.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(UserProfileImage),
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '$FirstName ' + '$LastName',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$Position - ' + '$CompanyName',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
// ElevatedButton(
//   onPressed: () {
//   },
//   child: Text('Follow'),
// ),
// Follow(
//   postedByUID: widget.postedByUID,
// )
                          ],
                        ),
// Add social media icons here
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: Links.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.orange,
                                                Colors.deepOrange
                                              ],
                                              end: Alignment.topLeft,
                                              begin: Alignment.bottomRight),
                                        ),
                                        width: 35,
                                        height: 35,
                                        child: Center(
                                          child: IconButton(
                                            isSelected: true,
                                            iconSize: 20,
                                            onPressed: () {
                                              final Uri url =
                                                  Uri.parse(values[index]);
                                              _launchUrl(url);
                                            },
                                            icon: Icon(l[keys[index]]!.icon),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        following.contains(specifiedUserID)
                            ? ElevatedButton(
                                onPressed: unFollow,
                                child: const Text('you already follow him'))
                            : ElevatedButton(
                                onPressed: makeFollow,
                                child: const Text('follow'),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              flowList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget flowList(BuildContext context) {
    if (postsDocs != null) {
      if (postsDocs.length != 0) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 75),
          itemCount: postsDocs.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FirstName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '@$uniqueUserName',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 110,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF495592),
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: NetworkImage(
                                    postsDocs[i].data()!['ImageURL']),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      ],
                    ),
                    Divider(
                      color: Color(0xFF495592).withOpacity(0.9),
                    ),
                    Row(
                      children: [
                        Text(
                          '${postsDocs[i].data()!['Description']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => CommentPage(
                                //             PostId:
                                //                 postsDocs[i].data()!['PostId'],
                                //           )),
                                // );
                              },
                              child: Icon(Icons.comment),
                            ),
                            IconButton(
                              icon: Icon(Icons.thumb_up),
                              onPressed: () {
// Handle like action
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {
// Handle share action
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return Center(
            child:
                CircularProgressIndicator(backgroundColor: Colors.transparent));
      }
    } else {
      return Center(
          child:
              CircularProgressIndicator(backgroundColor: Colors.transparent));
    }
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
