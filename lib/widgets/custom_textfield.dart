
import 'package:afropeep/resouces/color_resources.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  TextInputType textInputType;
  String hintText;
  double fontSize;
  double borderRadius;
  bool obSequreText;
  bool enabledBorder;
  bool focusedBorder;
  IconData iconName;
  Function onPressed;
  Color iconColor;
  int maxLines;
  String errorText;

  CustomTextField({
    Key key,
    this.controller,
    this.textInputType,
    this.fontSize,
    this.hintText,
    this.borderRadius,
    this.obSequreText  = false,
    this.enabledBorder = false,
    this.focusedBorder = false,
    this.iconName,
    this.onPressed,
    this.iconColor,
    this.maxLines
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      onTap: onPressed,
      style: TextStyle(fontSize: fontSize, ),
        controller: controller,
        keyboardType: textInputType,
        obscureText: obSequreText,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top:20,left: 15),
          hintText: hintText,
          filled: true,
          fillColor: ColorResources.whiteColor,
          suffixIcon: Icon(iconName,color: iconColor,),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,

          ),
          enabledBorder: OutlineInputBorder( //Outline border type for TextFeild
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color:(enabledBorder == true) ? Color(0xff757575):Colors.transparent,
              width: 1,
            )
            ),
          focusedBorder:OutlineInputBorder( //Outline border type for TextFeild
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color:(focusedBorder == true) ? ColorResources.primaryColor:Colors.transparent,
                width: 1,
              )
          ),
          // errorText: "Error Text",

        ),

    );
  }
}
