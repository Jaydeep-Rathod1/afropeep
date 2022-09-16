import 'package:flutter/material.dart';

import 'color_resources.dart';

BuildContext _appLoaderContex;

void Apploader(BuildContext context) {
  showGeneralDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    pageBuilder: (_, __, ___) {
      _appLoaderContex = context;
      return Align(
        alignment: Alignment.center,
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: ColorResources.primaryColor,
              ),
              // SizedBox(height: 20,),
              // Text("Please Wait...",style: TextStyle(color: ColorResources.primaryColor,fontSize: 10),),
            ],
          ),
        ),
      );
    },
  ).then((value) {
    // if (Commonmessage != '') {
    //   displayDialog(context, Commonmessage, '');
    //   Commonmessage = '';
    // }
  });
}

void RemoveAppLoader(BuildContext context) {
  if (_appLoaderContex != null) {
    Navigator.of(_appLoaderContex).pop();
  }
  // Navigator.of(context, rootNavigator: false).pop('dialog');
}
removeHtmlTagsFromString(String html){
  RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
  String parsedstring1 = html.replaceAll(exp, '');
  return parsedstring1;
}
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}