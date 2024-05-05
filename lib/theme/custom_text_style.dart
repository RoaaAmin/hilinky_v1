import 'package:flutter/material.dart';
import 'package:hilinky/theme/theme_helper.dart';

import '../core/app_export.dart';
import '../core/utils/size_utils.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLarge16 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: getFontSize(
          16,
        ),
      );
  static get bodyLarge19 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: getFontSize(
          19,
        ),
      );
  static get bodyLargeCyan800 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.cyan800.withOpacity(0.6),
      );
  static get bodyLargeGray90001 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray90001,
        fontSize: getFontSize(
          16,
        ),
      );
  static get bodyLargeGray90002 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray90002.withOpacity(0.49),
        fontSize: getFontSize(
          16,
        ),
      );
  static get bodyLargeGray9000217 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray90002,
        fontSize: getFontSize(
          17,
        ),
      );
  static get bodyLargeOnPrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
        fontSize: getFontSize(
          16,
        ),
      );
  static get bodyLargeOnPrimaryContainer_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static get bodyMediumInterBluegray300 =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.blueGray300,
      );
  static get bodyMediumInterCyan800 =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.cyan800.withOpacity(0.6),
      );
  static get bodyMediumInterOnPrimaryContainer =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: getFontSize(
          15,
        ),
      );
  static get bodyMediumInterWhiteA700 =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.whiteA700,
        fontSize: getFontSize(
          15,
        ),
      );
  static get bodySmallCyan800 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.cyan800.withOpacity(0.6),
      );
  static get bodySmallDeeporange300 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.deepOrange300,
      );
  static get bodySmallPoppinsBlack900 =>
      theme.textTheme.bodySmall!.poppins.copyWith(
        color: appTheme.black900.withOpacity(0.56),
      );
  static get bodySmallPoppinsGray600 =>
      theme.textTheme.bodySmall!.poppins.copyWith(
        color: appTheme.gray600,
      );
  // Display text style
  static get displaySmall34 => theme.textTheme.displaySmall!.copyWith(
        fontSize: getFontSize(
          34,
        ),
      );
  static get displaySmall34_1 => theme.textTheme.displaySmall!.copyWith(
        fontSize: getFontSize(
          34,
        ),
      );
  static get displaySmallDeeporange300 =>
      theme.textTheme.displaySmall!.copyWith(
        color: appTheme.deepOrange300,
        fontSize: getFontSize(
          34,
        ),
      );
  // Label text style
  static get labelLargeInterBluegray300 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.blueGray300,
        fontSize: getFontSize(
          13,
        ),
        fontWeight: FontWeight.w500,
      );
  static get labelLargeInterCyan800 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.cyan800.withOpacity(0.6),
        fontSize: getFontSize(
          13,
        ),
        fontWeight: FontWeight.w500,
      );
  static get labelLargeInterDeeporange300 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.deepOrange300,
        fontSize: getFontSize(
          13,
        ),
      );
  static get labelLargeInterDeeporange30013 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.deepOrange300,
        fontSize: getFontSize(
          13,
        ),
      );
  static get labelLargeInterGray900 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.gray900,
        fontSize: getFontSize(
          13,
        ),
        fontWeight: FontWeight.w800,
      );
  static get labelMediumBlack900 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.black900,
      );
  static get labelMediumDeeporange300 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.deepOrange300,
        fontWeight: FontWeight.w600,
      );
  static get labelMediumDeeporange300SemiBold =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.deepOrange300,
        fontWeight: FontWeight.w600,
      );
  static get labelMediumRed300 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.red300,
        fontWeight: FontWeight.w600,
      );
  // Poppins text style
  static get poppinsBlack900 => TextStyle(
        color: appTheme.black900,
        fontSize: getFontSize(
          6,
        ),
        fontWeight: FontWeight.w600,
      ).poppins;
  static get poppinsGray90002 => TextStyle(
        color: appTheme.gray90002,
        fontSize: getFontSize(
          6,
        ),
        fontWeight: FontWeight.w600,
      ).poppins;
  // Title text style
  static get titleMediumDeeporange300 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.deepOrange300,
        fontSize: getFontSize(
          18,
        ),
        fontWeight: FontWeight.w700,
      );
  static get titleMediumGray90002 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray90002.withOpacity(0.49),
        fontWeight: FontWeight.w700,
      );
  static get titleMediumMedium => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleMediumMontserratWhiteA700 =>
      theme.textTheme.titleMedium!.montserrat.copyWith(
        color: appTheme.whiteA700,
        fontSize: getFontSize(
          18,
        ),
        fontWeight: FontWeight.w700,
      );
  static get titleMediumPoppinsBlack900 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumPoppinsGray600 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.gray600,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: getFontSize(
          18,
        ),
        fontWeight: FontWeight.w700,
      );
  static get titleMediumWhiteA70018 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: getFontSize(
          18,
        ),
      );
  static get titleMediumWhiteA70018_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: getFontSize(
          18,
        ),
      );
  static get titleMediumWhiteA700Bold => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: getFontSize(
          18,
        ),
        fontWeight: FontWeight.w700,
      );
  static get titleMediumWhiteA700Medium =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
        fontSize: getFontSize(
          15,
        ),
        fontWeight: FontWeight.w600,
      );
  static get titleSmallGray90002 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray90002,
        fontSize: getFontSize(
          15,
        ),
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get workSans {
    return copyWith(
      fontFamily: 'Work Sans',
    );
  }
}
