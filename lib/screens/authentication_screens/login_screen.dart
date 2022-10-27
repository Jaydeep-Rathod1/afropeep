

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/authentication_screens/phone_number_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_mode_to_start_screen.dart';
import 'package:afropeep/widgets/custom_button_with_icon.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../resouces/constants.dart';
import '../../widgets/custom_sizedbox.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var googleSignInAccount;
  var _googleSignIn = GoogleSignIn();
  Dio _dio = Dio();
  bool isSignIn =false;
  bool google =false;
  Map<String, dynamic> _userData;
  AccessToken _accessToken;
  bool _checking = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  _checkIfisLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    setState(() {
      _checking = false;
    });

    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    } else {
      _login();
    }
  }
  _login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      print(userData);
      _userData = userData;
      print(_userData);

    } else {
      print(result.status);
      print(result.message);
    }
    setState(() {
      _checking = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomSizedBox(
            newheight: 70,
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
                onPressed: ()async{
                  // await signInwithGoogle();

                  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
                  GoogleSignInAuthentication googleSignInAuthentication =  await googleSignInAccount.authentication;

                  print("email = ${googleSignInAccount.email}");
                  final fcmToken = await FirebaseMessaging.instance.getToken();
                  print("fcmtoken = ${fcmToken}");
                  await _dio.post(ADD_USER_WITH_EMAIL,data: {"useremail":googleSignInAccount.email.toString(),"accesstoken":fcmToken}).then((value) async{
                    print(value);
                    print(value.data);
                    print(value.statusCode);
                    if(value.statusCode == 200)
                    {
                      var userid = value.data['user_id'];
                      print("user id = ${userid}");
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setInt('userid', userid);
                      print("userid");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ChooseModeToStart()));
                    }
                  });

                },
                buttonText: 'Continue With Google',
                fontSize: 16.0,
                textColor: ColorResources.blackColor,
                width:MediaQuery.of(context).size.width,
              ),
              CustomSizedBox(
                newheight: 10,
              ),
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
              CustomSizedBox(
                newheight: 10,
              ),
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
              CustomSizedBox(
                newheight: 10,
              ),
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
          CustomSizedBox(
            newheight: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle,size: 4,color: ColorResources.whiteColor,),
              CustomSizedBox(
                newwidth: 5,
              ),
              CustomText(text: 'Privacy Policy',fontSize: 14,color: ColorResources.whiteColor,),
              CustomSizedBox(
                newwidth: 5,
              ),
              Icon(Icons.circle,size: 4,color: ColorResources.whiteColor,),
              CustomSizedBox(
                newwidth: 5,
              ),
              CustomText(text: 'Terms and Conditions',fontSize: 14,color: ColorResources.whiteColor,),
            ],
          ),

          CustomSizedBox(
            newheight: 23,
          )
        ],
      )
    );
  }



  Future<String> signInwithGoogle() async {

      final GoogleSignInAccount googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      // await _auth.signInWithGoogle( accessToken: googleSignInAuthentication.accessToken,
      //   idToken: googleSignInAuthentication.idToken,);


  }
  loginWithGoogle(){}
  loginWithFacebook(){
    _login();
  }
  loginWithApple(){}
  loginWithPhoneNumber(){
    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const PhoneNumberScreen()));
  }
}
