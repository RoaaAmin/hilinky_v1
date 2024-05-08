import 'package:easy_localization/easy_localization.dart';
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
    const FaIcon(FontAwesomeIcons.facebook,  color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.twitter , color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.linkedin , color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.youtube,  color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.instagram,  color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.telegram,  color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.whatsapp,  color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.github,  color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.discord,  color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.figma,  color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.dribbble,  color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.behance, color: Color(0xFF7EA9BA),),
    const FaIcon(FontAwesomeIcons.location,  color: Color(0xFF7EA9BA),),
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
              decoration:  InputDecoration(
                labelText: context.tr("Enter a link"),
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
                  child:Text( context.tr("Cancel"), style: TextStyle(color: Color.fromARGB(255, 2, 84, 86),),),
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
                  child:  Text( context.tr("Save") , style: TextStyle(color: Color.fromARGB(255, 2, 84, 86)))
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
