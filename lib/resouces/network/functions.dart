import 'package:flutter/material.dart';

import '../color_resources.dart';

class FunctionDefualt{
  static bool isEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }
  static ShowSnackbar(context,_scaffoldKey,message,buttontext)
  {
    var snackBar = SnackBar(
      content: Text(message),
      backgroundColor: (Colors.black),
      action: SnackBarAction(
        label: buttontext,
        textColor: ColorResources.primaryColor,
        onPressed: () {
          _scaffoldKey.currentState.removeCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}