import 'package:flutter/material.dart';



import 'package:hiwetaan/theme/theme_helper.dart';

import '../core/utils/size_utils.dart';



class AppDecoration {
  // Backround decorations
  static BoxDecoration get backround => BoxDecoration(
        color: appTheme.gray50,
      );

  // Fill decorations
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray400,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );

  // Gradient decorations
  static BoxDecoration get gradient => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(1.31, 0.31),
          end: Alignment(-0.25, 0.33),
          colors: [
            appTheme.deepOrange300,
            appTheme.red400,
          ],
        ),
      );

  // Outline decorations
  static BoxDecoration get outline => BoxDecoration();
  static BoxDecoration get outlineGray => BoxDecoration(
        border: Border.all(
          color: appTheme.gray90002,
          width: getHorizontalSize(1),
        ),
      );
  static BoxDecoration get outlineGray90002 => BoxDecoration(
        color: appTheme.gray40019,
        border: Border.all(
          color: appTheme.gray90002,
          width: getHorizontalSize(1),
        ),
      );
  static BoxDecoration get outlineTeal => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.teal300,
          width: getHorizontalSize(2),
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.cyan800.withOpacity(0.15),
            spreadRadius: getHorizontalSize(2),
            blurRadius: getHorizontalSize(2),
            offset: Offset(
              0,
              2,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineTeal400 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.5),
        border: Border(
          bottom: BorderSide(
            color: appTheme.teal400,
            width: getHorizontalSize(1),
          ),
        ),
      );
  static BoxDecoration get outlineWhiteA => BoxDecoration(
        color: appTheme.teal300,
        border: Border.all(
          color: appTheme.whiteA700,
          width: getHorizontalSize(2),
        ),
      );
  static BoxDecoration get outlineWhiteA700 => BoxDecoration(
        border: Border.all(
          color: appTheme.whiteA700,
          width: getHorizontalSize(2),
        ),
      );

  // Primary decorations
  static BoxDecoration get primary => BoxDecoration(
        color: appTheme.teal300.withOpacity(0.2),
        border: Border.all(
          color: appTheme.cyan800,
          width: getHorizontalSize(1),
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder16 => BorderRadius.circular(
        getHorizontalSize(16),
      );

  // Custom borders
  static BorderRadius get customBorderBL10 => BorderRadius.vertical(
        bottom: Radius.circular(getHorizontalSize(10)),
      );

  // Rounded borders
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        getHorizontalSize(8),
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
