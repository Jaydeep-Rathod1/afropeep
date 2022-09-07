import 'dart:async';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/authentication_screens/login_screen.dart';
import 'package:afropeep/screens/face_rekognition/camera_new_screen.dart';
import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_mode_to_start_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_photos_screen.dart';
import 'package:afropeep/screens/survey/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), ()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var validateLogin = prefs.getBool('loginvalid');
      print(validateLogin);
      if(validateLogin == false || validateLogin == null)
        {
          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: LoginScreen()));
        }
      else{

        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: HomeScreen()));
      }
    },
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
