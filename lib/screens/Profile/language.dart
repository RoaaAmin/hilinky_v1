import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hilinky/profilePage/ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        title: const Center(
          child: Text(
            "Language",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            // Navigate back with replacement to reflect language change
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: const Text('English (US)'),
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
            title: const Text('Arabic').tr(),
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
