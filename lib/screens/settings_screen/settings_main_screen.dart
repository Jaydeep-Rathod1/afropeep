import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/authentication_screens/login_screen.dart';
import 'package:afropeep/screens/home_screens/filter_screen.dart';
import 'package:afropeep/screens/profile_screens/myprofile_screen.dart';
import 'package:afropeep/screens/settings_screen/about_screen.dart';
import 'package:afropeep/screens/settings_screen/block_screen.dart';
import 'package:afropeep/screens/settings_screen/change_password_screen.dart';
import 'package:afropeep/screens/settings_screen/notification_screen.dart';
import 'package:afropeep/screens/settings_screen/notification_settings_screen.dart';
import 'package:afropeep/screens/settings_screen/privacy_policy_screen.dart';
import 'package:afropeep/screens/settings_screen/subscription_screen.dart';
import 'package:afropeep/screens/settings_screen/terms_and_conditions_screen.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resouces/constants.dart';
import '../onboarding_screen/choose_mode_to_start_screen.dart';

class SettingsMainScreen extends StatefulWidget {
  @override
  State<SettingsMainScreen> createState() => _SettingsMainScreenState();
}

class _SettingsMainScreenState extends State<SettingsMainScreen> {
  Dio _dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Row(
            children: [

              CustomText(
                text: 'Settings',
                fontSize: 18,
              )
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),

        ),*/
       body: Padding(
         padding:EdgeInsets.all(20),
         child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyprofileScreen()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Icon(Icons.account_circle_outlined,color: ColorResources.blackColor,size: 24,),
                    SizedBox(width: 13,),
                    CustomText(text: "Account", fontSize: 14,)
                  ],
                ),
              )
            ),
            SizedBox(height: 10,),
            Divider(
              height: 2,
              color: Color(0xffF3F3F3),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FilterScreen()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,

                child: Row(
                  children: [
                    ImageIcon(AssetImage('assets/icons/subscription_icon.png'),size: 20),
                    SizedBox(width: 13,),
                    CustomText(text: "Preferences", fontSize: 14,)
                  ],
                ),
              )
            ),
            SizedBox(height: 10,),
            Divider(
              height: 2,
              color: Color(0xffF3F3F3),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SubscriptionScreen()));
              },
              child:  Row(
                  children: [
                    Icon(Icons.account_circle_outlined,color: ColorResources.blackColor,size: 24,),
                    SizedBox(width: 13,),
                    CustomText(text: "Subscription", fontSize: 14,)
                  ],
              )
            ),
            SizedBox(height: 10,),
            Divider(
              height: 2,
              color: Color(0xffF3F3F3),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NotificationSettingsScreen()));
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NotificationScreen()));

              },
              child: Row(
                children: [
                  Icon(Icons.notifications_none_outlined,color: ColorResources.blackColor,size: 24,),
                  SizedBox(width: 13,),
                  CustomText(text: "Notifications", fontSize: 14,)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Divider(
              height: 2,
              color: Color(0xffF3F3F3),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChangePasswordScreen()));
              },
              child: Row(
                children: [
                  Icon(Icons.lock_outline_rounded,color: ColorResources.blackColor,size: 24,),
                  SizedBox(width: 13,),
                  CustomText(text: "Change Password", fontSize: 14,)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Divider(
              height: 2,
              color: Color(0xffF3F3F3),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BlockScreen()));
              },
              child: Row(
                children: [
                  ImageIcon(AssetImage('assets/icons/block_icon.png'),size: 24),
                  SizedBox(width: 13,),
                  CustomText(text: "Block", fontSize: 14,)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Divider(
              height: 2,
              color: Color(0xffF3F3F3),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PrivacyPolicyScreen()));
              },
              child: Row(
                children: [
                  ImageIcon(AssetImage('assets/icons/privacy_icon.png'),size: 24),
                  SizedBox(width: 13,),
                  CustomText(text: "Privacy", fontSize: 14,)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Divider(
              height: 2,
              color: Color(0xffF3F3F3),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TermsAndConditionsScreen()));
              },
              child: Row(
                children: [
                  Icon(Icons.description_outlined,color: ColorResources.blackColor,size: 24,),
                  SizedBox(width: 13,),
                  CustomText(text: "Terms & Conditions", fontSize: 14,)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Divider(
              height: 2,
              color: Color(0xffF3F3F3),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AboutScreen()));
              },
              child: Row(
                children: [
                  Icon(Icons.info_outlined,color: ColorResources.blackColor,size: 24,),
                  SizedBox(width: 13,),
                  CustomText(text: "About", fontSize: 14,)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Divider(
              height: 2,
              color: Color(0xffF3F3F3),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: ()async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove("userid");
                      prefs.remove("isLogin");
                      prefs.remove("isCompleteAllData");
                      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: LoginScreen()));
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(29.0)),
                      side: BorderSide(width: 1.0, color: ColorResources.blackColor),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      alignment: Alignment.center,
                      child: CustomText(text: 'Log Out',color: ColorResources.blackColor,fontSize: 16,),
                    ),
                  ),
                  SizedBox(height: 10,),
                  OutlinedButton(
                    onPressed: ()async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      int userid = prefs.getInt('userid');
                      prefs.setBool("isLogin", true);
                      Map<String, String> params = Map();
                      params['user_id'] = userid.toString();

                      print(params);
                      await _dio.post(DELETE_ACCOUNT,data: {"userid":userid}).then((value) {
                        // var varJson = value.data;
                        print("value = ${value.data["message"]}");
                        if(value.statusCode == 200)
                        {
                          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child: LoginScreen()));
                          // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const OtpVerificationScreen()));
                        }
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(29.0)),
                      side: BorderSide(width: 1.0, color: Color(0xffFF0000)),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      alignment: Alignment.center,
                      child: CustomText(text: 'Delete Account',color: Color(0xffFF0000),fontSize: 16,),
                    ),
                  ),
                ],
              )
            ),
          ],
         ),
       ),



    );
  }
}
