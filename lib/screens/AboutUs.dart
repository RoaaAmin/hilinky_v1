import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hilinky/core/utils/image_constant.dart';
import 'package:hilinky/widgets/custom_image_view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

import '../core/utils/size_utils.dart';
import '../widgets/app_bar/appbar_image.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // appBar: AppBar(
        //   leadingWidth: double.maxFinite,
        //   leading: AppbarImage(
        //     imagePath: ImageConstant.hilinkylogopng,
        //     margin: getMargin(
        //       // left: 11,
        //       right: 6,
        //     ),
        //   ),
        //   shape: ContinuousRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       bottom: Radius.circular(40),
        //     ),
        //     side: BorderSide(
        //       color: Color(0xFF234E5C),
        //     ),
        //   ),
        //   title: Text(context.tr('Home Screen')),
        // ),

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
                    imagePath: context.locale == Locale('en') || context.locale == Locale('fr')
                        ? ImageConstant.hilinkyLogoText
                        : ImageConstant.arabicLogo, // Change image path based on the selected language
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
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Color(0xFF286F8C)),
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
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Color(0xFF286F8C)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
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
                            ElevatedButton(
                              onPressed: () async {
                                String url =
                                    'https://api.whatsapp.com/send/?phone=966532595204&text=%D8%A3%D9%87%D9%84%D8%A7%20%D8%A8%D9%83%D9%85%20%D8%A3%D9%86%D8%A7%20%D9%85%D9%87%D8%AA%D9%85%20%D9%84%D8%AA%D8%B7%D9%88%D9%8A%D8%B1%20%D8%A8%D8%B7%D8%A7%D9%82%D8%A9%20%D8%A3%D8%B9%D9%85%D8%A7%D9%84%D9%8A%20%D9%84%D9%86%D8%B3%D8%AE%D8%A9%20%D8%B1%D9%82%D9%85%D9%8A%D8%A9%D8%8C%20%D9%83%D9%8A%D9%81%20%D9%8A%D9%85%D9%83%D9%86%D9%86%D9%8A%20%D8%A7%D9%84%D8%AD%D8%B5%D9%88%D9%84%20%D9%86%D8%B3%D8%AE%D8%AA%D9%8A%20%D8%A7%D9%84%D8%AE%D8%A7%D8%B5%D8%A9';
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
                                backgroundColor: Color(0xFFEF9453),
                              ),
                              child: Text(
                                context.tr('Subscribe Now'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  letterSpacing: 1.20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
