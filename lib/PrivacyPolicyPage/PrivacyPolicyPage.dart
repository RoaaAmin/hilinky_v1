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
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr('Our Privacy Principles'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 20,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'Hilinky values your privacy and is committed to protecting your personal information. We prioritize your ability to control who accesses your data.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Your Data is Yours'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'We do not sell or provide your data to third parties without your consent. Your data is yours to share as you wish.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Secure Storage'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'Your data is protected with enterprise-grade encryption and security.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Safe Sharing'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'Every Hilinky user has a unique identifier. Only those you share your information with can access your details.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Introduction'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'This privacy policy ("Policy") describes how personal information ("Personal Information") collected through the Hilinky mobile application ("Mobile Application" or "Service") is handled. It outlines the types of information collected, how it is used, and your rights regarding this data.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Automatic Collection of Information'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'We prioritize customer data security and follow a no-logs policy. We collect minimal data necessary for maintaining the Mobile Application and Services. Automatically collected data is used only for identifying potential abuse and gathering statistical information.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Collection of Personal Information'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'You can use Hilinky without revealing any personally identifiable information. However, for certain features, you may need to provide Personal Information such as your name and email address. We collect:'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr('Personal details: Name'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              context.tr('Contact information: Email address, Phone number'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              context.tr('Account details: Username, password'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              context.tr('Geolocation data: Latitude and longitude'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              context.tr(
                  'Social media data: Information from your social media profiles if you choose to link them, including your username, profile picture, and public activity'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Use and Processing of Collected Information'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'We use your information to:\n\nCreate and manage user accounts\nImprove our services\nSend administrative information\nRespond to inquiries and offer support\nEnhance user experience\nEnforce terms and conditions\nProtect against abuse\n\nWe process your data based on consent, legal obligations, or legitimate interests.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Managing Information'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'You can delete certain Personal Information by contacting us. We may retain a copy for compliance and operational purposes'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Disclosure of Information'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'We share your data only with trusted third parties necessary to provide our services. We do not share Personal Information with unaffiliated third parties.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Retention of Information'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'We retain your Personal Information as long as necessary to fulfill legal obligations and operational needs. Once the retention period expires, Personal Information is deleted.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Transfer of Information'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'Your data may be transferred and stored outside your country. We ensure these transfers comply with relevant legal requirements.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Your Rights'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'You have the right to:\n\nWithdraw consent\nAccess and update your information\nRestrict processing\nRequest deletion of your data\nObject to data processing\nReceive your data in a structured format\n\nTo exercise these rights, please get in touch with us at Hi.linky@wetaan.com.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Information Security'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'We secure your data with reasonable administrative, technical, and physical safeguards. However, no Internet or wireless transmission is entirely secure.'),
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
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'We may update this Privacy Policy from time to time. If we make changes, we will notify you by revising the date at the top of this policy and, in some cases, we may provide additional notice (such as adding a statement to our homepage or sending you a notification). We\'d like to encourage you to review this Privacy Policy periodically to stay informed about our practices.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Acceptance of This Policy'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr(
                  'By using Hilinky, you agree to this Policy. If you do not agree, please do not use our services.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Contact Us'),
              style: TextStyle(
                color: Color.fromARGB(255, 2, 84, 86),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr('If you have any questions or concerns about this Privacy Policy, please contact us at:'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              context.tr('Email: Hi.linky@wetaan.com'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              context.tr('Phone number: +966 53 259 5204'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Last updated: 06 June 2024'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr(
                  'This policy ensures transparency and compliance with data protection regulations, reflecting Hilinky\'s commitment to user privacy.'),
              style: TextStyle(
                color: Color(0xFF7EA9BA),
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              context.tr('Copyright © 2024 Wetaan\nAll rights reserved'),
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