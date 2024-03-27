import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


showInSnackBar(String value,Color backgroundColor,Color textColor,int duration,BuildContext context,GlobalKey<ScaffoldState> _scaffoldKey) {
  FocusScope.of(context).requestFocus(FocusNode());// Request Keyboard to hide
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
      height: 55,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
              value,
              textAlign: TextAlign.center,
              style: GoogleFonts.andadaPro(
                color: textColor,
                fontSize: 18,
              )
          ),
        ),
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: duration),
  ));
}

showInWaitingSnackBar(String value,Color backgroundColor,Color textColor,BuildContext context,GlobalKey<ScaffoldState> _scaffoldKey) {
  FocusScope.of(context).requestFocus(FocusNode());// Request Keyboard to hide
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          height: 55,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.andadaPro(
                    color: textColor,
                    fontSize: 16,
                  )
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 1000),
      )
  );
}

