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

/*
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
          width: 90,
          height: 90,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox.expand(
                child: Image.asset('assets/images/loading.gif',
                    height: 80, width: 80)),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.deepOrange, width: 2),
            borderRadius: BorderRadius.circular(45),
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
}*/
