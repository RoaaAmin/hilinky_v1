import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiwetaan/components/context.dart';
import 'package:line_icons/line_icons.dart';
import '../auth.dart';
import 'Profile/profile.dart';
import 'create_card/create_card.dart';
import 'login_screen.dart';
import 'my_card/myCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var UserProfileImage;
  Widget currentScreen = const HomeScreen();
  late DocumentSnapshot<Map<String, dynamic>> userData;
  late QuerySnapshot<Map<String, dynamic>> postsDocs;

  var userId = FirebaseAuth.instance.currentUser!.uid;

  var name = '';
  Map<String, dynamic> Links = {};

  void getuser() async {
    var user =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    setState(() {
      name = user.data()!['sUserName'];
    });
  }

  @override
  void initState() {
    super.initState();
    getLinks();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: Center(
          child: Container(
            height: 130.0,
            width: 130.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(UserProfileImage ?? ''),
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
        title: Image.asset(
          "assets/images/HilinkyLogo.png",
          scale: 20,
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(
          //     LineIcons.bell,
          //     size: 30.0,
          //     color: Colors.black,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).pushReplacement(CupertinoPageRoute(
          //       builder: (BuildContext context) => NotificationsPage(),
          //     ));
          //   },
          // ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Start your journey by creating your card",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.pushPage(CreateCard());
              },
              style: ElevatedButton.styleFrom(
                // shape: const (),
                padding: const EdgeInsets.all(5),
                backgroundColor: const Color.fromARGB(255, 2, 84, 86),
                fixedSize: const Size(178, 59),
                elevation: 0,
              ),
              //  style: const ButtonStyle( B elevation: 0.2, ),
              child: const Text(
                'Create Card',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        onPressed: () {
        //  context.pushPage(CreatePost());
        },
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 50.0),
              child: Text(
                " Hi $name\n${FirebaseAuth.instance.currentUser!.email!}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(
                LineIcons.home,
                color: Colors.amber,
              ),
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (BuildContext context) => const Auth()));
              },
            ),
            ListTile(
              leading: const Icon(
                LineIcons.edit,
                color: Colors.amber,
              ),
              title: const Text(
                "Posts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => Feeds()));
                Navigator.pushNamed(context, 'feeds');
              },
            ),
            ListTile(
                leading: const Icon(
                  Icons.credit_card_sharp,
                  color: Colors.amber,
                ),
                title: const Text(
                  'My card',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (BuildContext context) => MyCard()));
                }),
            ListTile(
                leading: const Icon(
                  LineIcons.cogs,
                  color: Colors.amber,
                ),
                title: const Text(
                  'My profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) => profiletest(),
                    ),
                  );
                }),
            ListTile(
                leading: const Icon(
                  Icons.subscriptions_sharp,
                  color: Colors.amber,
                ),
                title: const Text(
                  'My Subscription',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Navigator.of(context).push(
                  //   CupertinoPageRoute(
                  //       builder: (BuildContext context) => my_subscription()),
                  // );
                }),
            ListTile(
                leading: const Icon(LineIcons.user, color: Colors.amber),
                title: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  print('Signing Out User.....');
                  try {
                    await FirebaseAuth.instance.signOut().then((metaData) {
                      print('SignOut Completed...');
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                    });
                  } catch (e) {
                    print('An error occur during signing user out.');
                  }
                }),
          ],
        ),
      ),
    );
  }

  void getLinks() async {
    await FirebaseFirestore.instance
        .collection('Cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        UserProfileImage = value.data()!['ImageURL'];

        Links.clear();
        Links = value.data()!['Links'];
        Links.removeWhere((key, value) => value == '');
      },
    );
  }
}
