import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

import '../core/utils/size_utils.dart';
import '../theme/theme_helper.dart';
import 'custom_text_form_field.dart';

// ignore: must_be_immutable
class CustomPhoneNumber extends StatelessWidget {
  CustomPhoneNumber({
    Key? key,
    required this.country,
    required this.onTap,
    required this.controller,
  }) : super(
          key: key,
        );

  Country country;

  Function(Country) onTap;

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            _openCountryPicker(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              borderRadius: BorderRadius.circular(
                getHorizontalSize(8),
              ),
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
            ),
            child: Padding(
              padding: getPadding(
                left: 10,
                top: 18,
                right: 10,
                bottom: 18,
              ),
              child: Text(
                "+${country.phoneCode}",
                style: theme.textTheme.titleSmall,
              ),
            ),
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            width: getHorizontalSize(287),
            controller: controller,
            margin: getMargin(
              left: 8,
            ),
            hintText: "1023456789",
            hintStyle: theme.textTheme.titleSmall!,
            textInputType: TextInputType.phone,
          ),
        ),
      ],
    );
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Container(
            margin: EdgeInsets.only(
              left: getHorizontalSize(10),
            ),
            width: getHorizontalSize(60.0),
            child: Text(
              "+${country.phoneCode}",
              style: TextStyle(fontSize: getFontSize(14)),
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Text(
              country.name,
              style: TextStyle(fontSize: getFontSize(14)),
            ),
          ),
        ],
      );
  void _openCountryPicker(BuildContext context) => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          searchInputDecoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(fontSize: getFontSize(14)),
          ),
          isSearchable: true,
          title: Text('Select your phone code',
              style: TextStyle(fontSize: getFontSize(14))),
          onValuePicked: (Country country) => onTap(country),
          itemBuilder: _buildDialogItem,
        ),
      );
}
