import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  double newheight;
  double newwidth;
  Widget widgetChild;
  CustomSizedBox({this.newheight,this.newwidth,this.widgetChild});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: newheight,
      width: newwidth,
      child: widgetChild,
    );
  }
}
