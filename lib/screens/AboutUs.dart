import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/utils/image_constant.dart';
import '../widgets/custom_image_view.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'About Us',
          style: TextStyle(
            color: Color(0xFF133039),
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0.05,
            letterSpacing: -0.48,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Color(0xFF133039),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Transform(
                //   transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-1.03),
                //   child: Container(
                //     width: 230.10,
                //     height: 226.04,
                //     // child: Stack(
                //     // children: [
                //     //   SvgPicture.string(ImageConstant.hilinkyBg_logo), // add this line
                //     // ]),
                //   ),
                // ),
                // Image.asset('assets/logo.png'), // Replace 'assets/logo.png' with the actual logo image path
                CustomImageView(
                  imagePath: ImageConstant.hilinkyLogoText,
                ),

                SizedBox(height: 40),
                SizedBox(
                  width: 361,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'To create and design YOUR Elegant  business card,',
                          style: TextStyle(
                            color: Color(0xFF286F8C),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ' We offer the best solutions to transform your traditional business card into a simple and innovative digital experience. \n',
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
                      border: Border.all(style: BorderStyle.solid,color: Color(0xFF286F8C)),
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
                                  'Individual ',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF286F8C),
                                    fontSize: 16,
                                    fontFamily: 'Space Grotesk',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              Text(
                                  'Dive into creativity without any strings attached!',
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
                                    'One design.',
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
                                    'Create card.',
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
                                    'Edit card.',
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
                                    'Barcode Scanning.',
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
                      border: Border.all(style: BorderStyle.solid,color: Color(0xFF286F8C)),
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
                            'Enterprise ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xFF286F8C),
                              fontSize: 16,
                              fontFamily: 'Space Grotesk',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Empower your enterprise with unparalleled creative control!',
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
                                'Design with company theme.',
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
                                'Create, Edit, Share, Save Card',
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
                                'Providing  premium features.',
                                style: TextStyle(
                                  color: Color(0xFF707070),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              String url =
                                  'https://api.whatsapp.com/send/?phone=966532595204&text=Hello,%20how%20are%20you%3F';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                // side: BorderSide(width: 1.50, color: Color(0xFFEF9453)),
                              ),
                              backgroundColor: Color(0xFFEF9453),
                            ),
                            child: Text(
                              'Subscribe Now',
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
        ]),)
        ),
      ));
  }
}
