import 'package:flutter/material.dart';
import 'package:hilinky/widgets/custom_image_view.dart';

// Your CustomTextFormField class
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import '../theme/theme_helper.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.suffixIcon,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.prefixIcon, // Added prefixIcon parameter
    this.onChanged, // Added onChanged parameter
  }) : super(key: key);

  final Alignment? alignment;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool filled;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon; // Added prefixIcon parameter
  final ValueChanged<String>? onChanged; // Added onChanged parameter

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: _buildTextFormFieldWithShadow(),
    )
        : _buildTextFormFieldWithShadow();
  }

  Widget _buildTextFormFieldWithShadow() {
    return Container(
      decoration: BoxDecoration(
        color: fillColor ?? appTheme.white,
        borderRadius: BorderRadius.circular(getHorizontalSize(8.00)),
        boxShadow: [
          BoxShadow(
            color: Color(0x26286F8C),
            blurRadius: 10,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: textFormFieldWidget,
    );
  }

  Widget get textFormFieldWidget => Container(
    width: width ?? double.maxFinite,
    margin: margin,
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      maxLines: maxLines ?? 1,
      onChanged: onChanged, // Added onChanged callback
      decoration: decoration,
      validator: validator,
    ),
  );

  InputDecoration get decoration => InputDecoration(
    hintText: hintText ?? "",
    hintStyle: hintStyle ?? theme.textTheme.titleSmall,
    prefixIcon: prefixIcon, // Used the provided prefixIcon
    prefixIconConstraints: prefixConstraints,
    suffixIcon: suffixIcon,
    suffixIconConstraints: suffixConstraints,
    isDense: true,
    contentPadding: contentPadding ??
        getPadding(
          left: 16,
          top: 18,
          right: 16,
          bottom: 18,
        ),
    fillColor: fillColor ?? appTheme.white,
    filled: filled,
    border: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(getHorizontalSize(8.00)),
          borderSide: BorderSide(
            color: appTheme.teal300,
            width: 2,
          ),
        ),
    enabledBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(getHorizontalSize(8.00)),
          borderSide: BorderSide(
            color: appTheme.white,
            width: 2,
          ),
        ),
    focusedBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(getHorizontalSize(8.00)),
          borderSide: BorderSide(
            color: appTheme.teal300,
            width: 2,
          ),
        ),
  );
}

// Password field widget that manages its own state
class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final String label;

  PasswordField({
    required this.controller,
    required this.hintText,
    required this.hintStyle,
    required this.labelStyle,
    required this.label,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: widget.labelStyle,
        ),
        CustomTextFormField(
          controller: widget.controller,
          obscureText: obscureText,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          textInputType: TextInputType.visiblePassword,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
    child: Container(
                      margin: getMargin(
                        left: 30,
                        top: 15,
                        right: 16,
                        bottom: 15,
                      ),
    child: CustomImageView(
                          svgPath: obscureText
                              ? ImageConstant
                                  .imgAkariconseyeClose // Closed eye SVG
                              : ImageConstant
                                  .imgAkariconseyeopen // Open eye SVG
                          ),
    ),
          ),
        ),
      ],
    );
  }
}

