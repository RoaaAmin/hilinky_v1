import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/size_utils.dart';


class SocialMedia extends StatefulWidget {
  SocialMedia({super.key, required this.paddin, required this.saved});

  var paddin;
  Map<String, String> saved;

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  //links save
  Map<String, String> links = {
    'facebook': '',
    'twitter': '',
    'linkedin': '',
    'youtube': '',
    'instagram': '',
    'telegram': '',
    'whatsapp': '',
    'github': '',
    'discord': '',
    'figma': '',
    'dribbble': '',
    'behance': '',
    'location': '',
  };

  // icons
  List<Widget> socialMediaIcons = [
    const FaIcon(FontAwesomeIcons.facebook),
    const FaIcon(FontAwesomeIcons.twitter),
    const FaIcon(FontAwesomeIcons.linkedin),
    const FaIcon(FontAwesomeIcons.youtube),
    const FaIcon(FontAwesomeIcons.instagram),
    const FaIcon(FontAwesomeIcons.telegram),
    const FaIcon(FontAwesomeIcons.whatsapp),
    const FaIcon(FontAwesomeIcons.github),
    const FaIcon(FontAwesomeIcons.discord),
    const FaIcon(FontAwesomeIcons.figma),
    const FaIcon(FontAwesomeIcons.dribbble),
    const FaIcon(FontAwesomeIcons.behance),
    const FaIcon(FontAwesomeIcons.location),
  ];

  var entredLink = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        var name;

        ///  'facebook': '',0
        //     'twitter': '',1
        //     'linkedin': '',2
        //     'youtube': '',3
        //     'instagram': '',4
        //     'telegram': '',5
        //     'whatsapp': '',6
        //     'github': '',7
        //     'discord': '',8
        //     'figma': '',9
        //     'dribbble': '',10
        //     'behance': '',11
        //     'location': '',12

        if (index == 0) {
          name = 'facebook';
        }
        ;
        if (index == 1) {
          name = 'twitter';
        }
        ;
        if (index == 2) {
          name = 'linkedin';
        }
        ;
        if (index == 3) {
          name = 'youtube';
        }
        ;
        if (index == 4) {
          name = 'instagram';
        }
        ;
        if (index == 5) {
          name = 'telegram';
        }
        ;
        if (index == 6) {
          name = 'whatsapp';
        }
        ;
        if (index == 7) {
          name = 'github';
        }
        ;
        if (index == 8) {
          name = 'discord';
        }
        ;
        if (index == 9) {
          name = 'figma';
        }
        ;
        if (index == 10) {
          name = 'dribbble';
        }
        ;
        if (index == 11) {
          name = 'behance';
        }
        ;
        if (index == 12) {
          name = 'location';
        }
        ;

        return IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: ((builder) => Padding(
                    padding: widget.paddin,
                    child: bottomSheetLinks(index, name),
                  )),
            );
          },
          icon: socialMediaIcons[index],
        );
      },
    );
  }

  Widget bottomSheetLinks(index, name) {
    return SingleChildScrollView(
      child: Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          horizontal: 95,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: "Enter a link",
              ),
              maxLines: 1 ,
              controller: entredLink,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    links["$name"] = entredLink.text;
                    widget.saved.addAll(links);
                    print(links);
                    Navigator.of(context).pop();
                    entredLink.clear();
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
