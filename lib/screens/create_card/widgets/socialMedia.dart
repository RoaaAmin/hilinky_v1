import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/size_utils.dart';

class SocialMedia extends StatefulWidget {
  SocialMedia({Key? key, required this.padding, required this.saved}) : super(key: key);

  final EdgeInsets padding;
  final Map<String, String> saved;

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  final List<IconData> socialMediaIcons = [
    FontAwesomeIcons.facebook,
    FontAwesomeIcons.twitter,
    FontAwesomeIcons.linkedin,
    FontAwesomeIcons.youtube,
    FontAwesomeIcons.instagram,
    FontAwesomeIcons.telegram,
    FontAwesomeIcons.whatsapp,
    FontAwesomeIcons.github,
    FontAwesomeIcons.discord,
    FontAwesomeIcons.figma,
    FontAwesomeIcons.dribbble,
    FontAwesomeIcons.behance,
    FontAwesomeIcons.mapMarkerAlt,
  ];

  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(socialMediaIcons.length, (index) => TextEditingController());
    getCardInfo();
  }

  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void getCardInfo() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('Cards')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (snapshot.exists) {
        final Map<String, dynamic> data = snapshot.data()!;
        final Map<String, dynamic> links = data['Links'] ?? {};
        setState(() {
          for (int i = 0; i < socialMediaIcons.length; i++) {
            final String name = _getName(i);
            controllers[i].text = links[name] ?? '';
          }
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: getVerticalSize(51),
        crossAxisCount: 5,
        mainAxisSpacing: getHorizontalSize(24),
        crossAxisSpacing: getHorizontalSize(24),
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: socialMediaIcons.length,
      itemBuilder: (context, index) {
        final name = _getName(index);
        return IconButton(
          onPressed: () => _showBottomSheet(index, name),
          icon: FaIcon(socialMediaIcons[index], color: Color(0xFF7EA9BA)),
        );
      },
    );
  }

  String _getName(int index) {
    switch (index) {
      case 0:
        return 'facebook';
      case 1:
        return 'twitter';
      case 2:
        return 'linkedin';
      case 3:
        return 'youtube';
      case 4:
        return 'instagram';
      case 5:
        return 'telegram';
      case 6:
        return 'whatsapp';
      case 7:
        return 'github';
      case 8:
        return 'discord';
      case 9:
        return 'figma';
      case 10:
        return 'dribbble';
      case 11:
        return 'behance';
      case 12:
        return 'location';
      default:
        return '';
    }
  }

  void _showBottomSheet(int index, String name) {
    showModalBottomSheet(
      context: context,
      builder: (builder) => Padding(
        padding: widget.padding,
        child: _bottomSheetLinks(index, name),
      ),
    );
  }

  Widget _bottomSheetLinks(int index, String name) {
    return SingleChildScrollView(
      child: Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 95, vertical: 20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: tr("Enter a link")),
              maxLines: 1,
              controller: controllers[index],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(tr("Cancel"), style: TextStyle(color: Color(0xFF7EA9BA))),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    widget.saved[name] = controllers[index].text;
                    Navigator.of(context).pop();
                  },
                  child: Text(tr("Save"), style: TextStyle(color: Color(0xFF7EA9BA))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
