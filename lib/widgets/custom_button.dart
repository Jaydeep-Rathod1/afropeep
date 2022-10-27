// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function onPressed;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  Color backgroundColor;
  String buttonText;
  Color textColor;
  double fontSize;
  CustomButton({Key key, this.onPressed,this.width,this.height,this.padding,this.backgroundColor,this.buttonText,this.textColor,this.fontSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      // child: ElevatedButton.icon(onPressed: (){}, icon: ImageIcon(AssetImage('')), label: label),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              primary: backgroundColor,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(29.0),
              )
          ),
          onPressed: onPressed,
          child: Text(buttonText,style: TextStyle(color: textColor,fontSize: fontSize),)

      ),
    );
  }
}

