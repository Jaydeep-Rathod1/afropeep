

import 'dart:convert';
import 'dart:math';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/authentication_screens/phone_number_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_mode_to_start_screen.dart';
import 'package:afropeep/widgets/custom_button_with_icon.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uuid/uuid.dart';


import 'dart:io' show Platform;
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
    _checkIfisLoggedIn();
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
      // _login();
    }
  }
  _login() async {
    final LoginResult result = await FacebookAuth.instance.login(permissions: ["public_profile", "email"]);
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
                onPressed: signInWithFacebook,
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
                onPressed: (){
                  if(Platform.isIOS)
                    {
                      signInWithApple();
                    }
                  else{
                    Fluttertoast.showToast(
                      msg: "Device is not ios",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: ColorResources.whiteColor,
                      textColor: ColorResources.primaryColor,
                      fontSize: 16.0,
                    );
                  }
                },
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
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email','public_profile']);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);
    var userdata =await FacebookAuth.instance.getUserData();
    print("userdata = ${userdata}");
    var useremail = userdata['email'];
    await insertEmail(useremail);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
  insertEmail(String email)async{
    final fcmToken = await FirebaseMessaging.instance.getToken();
    await _dio.post(ADD_USER_WITH_EMAIL,data: {"useremail":email,"accesstoken":fcmToken}).then((value) async{
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
  }
  loginWithPhoneNumber(){
    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const PhoneNumberScreen()));
  }
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    await insertEmail(appleCredential.email);
    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

}
