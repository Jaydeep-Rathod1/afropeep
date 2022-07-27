
import 'package:afropeep/screens/choose_your_location_screen.dart';
import 'package:afropeep/screens/onboarding_screen/looking_for_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class FacialRecognitionScreen extends StatefulWidget {
  @override
  State<FacialRecognitionScreen> createState() => _FacialRecognitionScreenState();
}

class _FacialRecognitionScreenState extends State<FacialRecognitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: LookingForScreen()));
          },
          child: Image.asset("assets/images/Facial_Recognition.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
        ),
      ),
     /* body: GestureDetector(
        onTap: (){
          print("on tap");

        },
        child: Image.asset("assets/images/Facial_Recognition.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),*/
    );
  }
}
