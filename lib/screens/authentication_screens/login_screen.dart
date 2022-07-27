

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/authentication_screens/phone_number_screen.dart';
import 'package:afropeep/widgets/custom_button_with_icon.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 70,
          ),
          Center(
            child:SizedBox(
              height: 70,
              width: 235,
              child: Image.asset('assets/images/logo.png'),
            )
          ),
          const Spacer(),
          Column(
            children: [
              // ElevatedButton(onPressed: (){}, child: )
              CustomButtonWithIcon(
                iconName: 'assets/icons/google_icon.png',
                height: 45,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                backgroundColor: ColorResources.whiteColor,
                onPressed: loginWithGoogle,
                buttonText: 'Continue With Google',
                fontSize: 16.0,
                textColor: ColorResources.blackColor,
                width:MediaQuery.of(context).size.width,

              ),
              const SizedBox(height: 10,),
              CustomButtonWithIcon(
                iconName: 'assets/icons/facebook_icon.png',
                height: 45,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                backgroundColor: const Color(0xff3B5999),
                onPressed: loginWithFacebook,
                buttonText: 'Continue With Facebook',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width,

              ),
              const SizedBox(height: 10,),
              CustomButtonWithIcon(
                iconName: 'assets/icons/apple_icon.png',
                height: 45,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                backgroundColor: ColorResources.blackColor,
                onPressed: loginWithApple,
                buttonText: 'Continue With Apple',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 10,),
              CustomButtonWithIcon(
                iconName: '',
                height: 45,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                backgroundColor: ColorResources.whiteColor,
                onPressed:loginWithPhoneNumber,
                buttonText: 'Continue With Phone Number',
                fontSize: 16.0,
                textColor: ColorResources.blackColor,
                width:MediaQuery.of(context).size.width,

              )

            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle,size: 4,color: ColorResources.whiteColor,),
              const SizedBox(width: 5,),
              CustomText(text: 'Privacy Policy',fontSize: 14,color: ColorResources.whiteColor,),
              const SizedBox(width: 30,),
              Icon(Icons.circle,size: 4,color: ColorResources.whiteColor,),
              const SizedBox(width: 5,),
              CustomText(text: 'Terms and Conditions',fontSize: 14,color: ColorResources.whiteColor,),
            ],
          ),
          const SizedBox(
            height: 23,
          ),
        ],
      )
    );
  }
  loginWithGoogle(){}
  loginWithFacebook(){}
  loginWithApple(){}
  loginWithPhoneNumber(){
    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const PhoneNumberScreen()));
  }
}
