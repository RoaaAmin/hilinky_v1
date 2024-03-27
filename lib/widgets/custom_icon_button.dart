import 'package:flutter/material.dart';

import '../core/utils/size_utils.dart';
import '../theme/theme_helper.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.margin,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final EdgeInsetsGeometry? margin;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => Padding(
        padding: margin ?? EdgeInsets.zero,
        child: SizedBox(
          height: height ?? 0,
          width: width ?? 0,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Container(
              padding: padding ?? EdgeInsets.zero,
              decoration: decoration ??
                  BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(getHorizontalSize(16.00)),
                    gradient: LinearGradient(
                      begin: Alignment(1.31, 0),
                      end: Alignment(-0.25, 0),
                      colors: [
                        appTheme.deepOrange300,
                        appTheme.red400,
                      ],
                    ),
                  ),
              child: child,
            ),
            onPressed: onTap,
          ),
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get gradientDeepOrangeToRedTL25 => BoxDecoration(
        borderRadius: BorderRadius.circular(getHorizontalSize(25.00)),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: getHorizontalSize(2.00),
            blurRadius: getHorizontalSize(2.00),
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment(1.31, 0),
          end: Alignment(-0.25, 0),
          colors: [
            appTheme.deepOrange300,
            appTheme.red400,
          ],
        ),
      );
  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black900.withOpacity(0.5),
        borderRadius: BorderRadius.circular(getHorizontalSize(12.00)),
      );
}
