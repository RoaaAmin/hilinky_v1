import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hilinky/profilePage/ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/theme_helper.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  int selectedOption = 1; // Default to English (US)
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = prefs.getInt('selectedOption') ?? 1; // Default to English (US)
    });
  }

  Future<void> _saveSelectedLanguage(int value) async {
    await prefs.setInt('selectedOption', value);
    setState(() {
      selectedOption = value;
    });

    // Change language here
    if (value == 1) {
      context.setLocale(Locale('en'));
    } else if (value == 2) {
      context.setLocale(Locale('ar'));
    }
    // Navigate back with replacement to reflect language change
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteA700,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appTheme.whiteA700,
        title:  Center(
          child: Text(
            context.tr("Language"),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined,),
            onPressed: () => Navigator.of(context).pop(),
          ),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title:  Text(context.tr('English (US)')),
            leading: Radio(
              value: 1,
              groupValue: selectedOption,
              onChanged: (value) {
                _saveSelectedLanguage(value!);
              },
              activeColor: Colors.orange, // Toggle color
            ),
          ),
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title:  Text(context.tr('Arabic')),
            leading: Radio(
              value: 2,
              groupValue: selectedOption,
              onChanged: (value) {
                _saveSelectedLanguage(value!);
              },
              activeColor: Colors.orange, // Toggle color
            ),
          ),
        ],
      ),
    );
  }
}
