import 'package:flutter/material.dart';

extension NavExtension on BuildContext {
  pushPage(Widget widget) {
    Navigator.push(this, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  get pop => Navigator.of(this).pop();
  get width => MediaQuery.of(this).size.width;
  get height => MediaQuery.of(this).size.height;
}
