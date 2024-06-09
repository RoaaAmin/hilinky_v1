import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hilinky/core/utils/image_constant.dart';
import 'package:hilinky/widgets/custom_image_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/theme_helper.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  CustomImageView(
                    imagePath: context.locale == Locale('en')
                        ? ImageConstant.enhilinky
                        : ImageConstant.arabicLogo,
                  //  height: 30.0,
                    width: 250.0,
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: 361,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: context.tr(
                                'To create and design YOUR Elegant  business card,'),
                            style: TextStyle(
                              color: Color(0xFF286F8C),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: context.tr(
                                ' We offer the best solutions to transform your traditional business card into a simple and innovative digital experience. \n'),
                            style: TextStyle(
                              color: Color(0xFF495057),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 8),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: Offset(0, 7),
                          ),
                        ],
                        border: Border.all(
                            style: BorderStyle.solid, color: Color(0xFF286F8C)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    height: 215,
                    width: 361,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr('Individual'),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF286F8C),
                                fontSize: 16,
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              context.tr(
                                  'Dive into creativity without any strings attached!'),
                              style: TextStyle(
                                color: Color(0xFF133039),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  context.tr('One design.'),
                                  style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  context.tr('Create card.'),
                                  style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  context.tr('Edit card.'),
                                  style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  context.tr('Barcode Scanning.'),
                                  style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // StreamBuilder to fetch data from Firestore
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Subscribe')
                        .doc('DewloIaVbyyZTcQoAtNq') // Replace with your document ID
                        .snapshots(),
                    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Show loading indicator while waiting for data
                      }
                      if (!snapshot.hasData || snapshot.data?.data() == null) {
                        return SizedBox(); // Return an empty SizedBox if data is not available
                      }

                      // Check the value of the Premium field
                      bool premium = (snapshot.data! as DocumentSnapshot<Map<String, dynamic>>).data()!['Premium'] ?? false;

                      // Conditionally render the Enterprise container based on the Premium value
                      if (!premium) {
                        return SizedBox(); // Return an empty SizedBox if Premium is false
                      }

                      // Return the Enterprise container if Premium is true
                      return Container(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 8),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: Offset(0, 7),
                            ),
                          ],
                          border: Border.all(style: BorderStyle.solid, color: Color(0xFF286F8C)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 235,
                        width: 361,
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr('Enterprise'),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF286F8C),
                                    fontSize: 16,
                                    fontFamily: 'Space Grotesk',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  context.tr(
                                      'Empower your enterprise with unparalleled creative control!'),
                                  style: TextStyle(
                                    color: Color(0xFF133039),
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.orange,
                                      size: 16,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      context.tr('Design with company theme.'),
                                      style: TextStyle(
                                        color: Color(0xFF707070),
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.orange,
                                      size: 16,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      context.tr('Create, Edit, Share, Save Card'),
                                      style: TextStyle(
                                        color: Color(0xFF707070),
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.orange,
                                      size: 16,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      context.tr('Providing premium features.'),
                                      style: TextStyle(
                                        color: Color(0xFF707070),
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.orange, Colors.deepOrange.shade400],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      String url =
                                          "https://api.whatsapp.com/send/?phone=966532595204&text=%D8%A3%D9%87%D9%84%D9%8B%D8%A7%20%D9%81%D8%B1%D9%8A%D9%82%20%D9%87%D8%A7%D9%8A%20%D9%84%D9%8A%D9%86%D9%83%D9%8A%0A%D8%A3%D8%B1%D9%8A%D8%AF%20%D8%A3%D9%86%20%D8%A3%D9%82%D8%AA%D9%86%D9%8A%20%D8%A8%D8%B7%D8%A7%D9%82%D8%A9%20%D8%B1%D9%82%D9%85%D9%8A%D8%A9";
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 21, vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors
                                          .transparent, // Set background color to transparent
                                      elevation: 0, // Remove button elevation
                                    ),
                                    child: Text(
                                      context.tr('Subscribe Now'),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                        Colors.white, // Set text color to white
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        letterSpacing: 1.20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
