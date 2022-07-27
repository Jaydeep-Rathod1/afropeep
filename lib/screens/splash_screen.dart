import 'dart:async';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/authentication_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: LoginScreen())),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  ColorResources.primaryColor,
      body:Center(
        child: Container(
          height: 80,
          width: 270,
          child: Image.asset('assets/images/logo.png'),
        ),
      )

    );
  }
}
