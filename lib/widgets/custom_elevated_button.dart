import 'package:flutter/material.dart';


import '../core/utils/size_utils.dart';
import '../theme/custom_text_style.dart';
import 'base_button.dart';

class CustomElevatedButton extends BaseButton {
  CustomElevatedButton({
    Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    EdgeInsets? margin,
    VoidCallback? onTap,
    ButtonStyle? buttonStyle,
    Alignment? alignment,
    TextStyle? buttonTextStyle,
    bool? isDisabled,
    double? height,
    double? width,

    required String text,
  }) : super(
    text: text,
    onTap: onTap,
    buttonStyle: buttonStyle,
    isDisabled: isDisabled,
    buttonTextStyle: buttonTextStyle,
    height: height,
    width: width,
    alignment: alignment,
    margin: margin,
  );

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: buildElevatedButtonWidget,
    )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
    height: this.height ?? getVerticalSize(59),
    width: this.width ?? double.maxFinite,
    margin: margin,
    decoration: BoxDecoration(

      // Replace Colors.blue with the desired color
      borderRadius: BorderRadius.circular(9), // Example border radius
    ),
    child: ElevatedButton(
      // style: buttonStyle,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF234E5C),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: isDisabled ?? false ? null : onTap ?? () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIcon ?? const SizedBox.shrink(),
          Text(
            text,
            style: buttonTextStyle ?? CustomTextStyles.titleMediumWhiteA700,
          ),
          rightIcon ?? const SizedBox.shrink(),
        ],
      ),
    ),
  );
}
