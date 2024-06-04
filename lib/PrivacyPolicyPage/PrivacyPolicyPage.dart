import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme_helper.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteA700,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // title: Text(
        //   context.tr('Privacy Policy'),
        // ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              context.tr('Privacy Policy'),
              style: GoogleFonts.robotoCondensed(
                  color: const Color.fromARGB(255, 2, 84, 86),
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'This Privacy Policy explains how your personal information is collected, used, and disclosed by the Hilinky application.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Information Collection and Use'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'We may collect some personal information when you use our application. This information is used to provide and improve our services.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Log Data'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'We may also collect information that your device sends whenever you use our Service.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Cookies'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Changes to This Privacy Policy'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
