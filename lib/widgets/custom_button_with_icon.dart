// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';



class CustomButtonWithIcon extends StatelessWidget {
  Function onPressed;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  Color backgroundColor;
  String buttonText;
  Color textColor;
  double fontSize;
  String iconName;
  CustomButtonWithIcon({Key key, this.onPressed,this.width,this.height,this.padding,this.backgroundColor,this.iconName,this.buttonText,this.textColor,this.fontSize}) : super(key: key);
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(iconName.isNotEmpty)
              Image.asset(iconName,height: 24,width: 24,),
              const SizedBox(width: 10,),
            Text(buttonText,style: TextStyle(color: textColor,fontSize: fontSize),)
          ],
        ),
      ),
    );
  }
}
