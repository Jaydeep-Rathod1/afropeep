// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  Color color;
  double fontSize;
  FontWeight fontWeight;
  double height;
  bool letterSpacing;
  CustomText({Key key, this.text,this.color,this.fontSize,this.fontWeight,this.height,this.letterSpacing = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        // wordSpacing: 1.0,
        letterSpacing : letterSpacing== true ? 1.5:1.0,
      ),

    );
  }
}
