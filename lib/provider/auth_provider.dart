import 'dart:convert';

import 'package:afropeep/resouces/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../resouces/error_handler.dart';


class AuthProvider with ChangeNotifier
{
  bool isRegister=false;
  var registerMessage="";
  var registeruserid="";
  var registerotp="";
  var registermobile="";



  bool isverify=false;
  var otpmessage="";
  verifyotp(context,params) async
  {
    try
    {
      /*await ApiHandler.post(UrlResources.OTP_VERIFY,body: params).then((json) async{
        if(json["status"]=="true")
        {
          isverify=true;
          otpmessage=json["message"].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("islogin", true);
          UserData obj = UserData.fromJson(json["userdata"]);
          prefs.setString("userdata", jsonEncode(obj));
          loggedinuser = UserData.fromJson(jsonDecode(prefs.getString("userdata")));
        }
        else
        {
          isverify=false;
          otpmessage=json["message"].toString();
        }
      });*/
    }
    on ErrorHandler catch (e)
    {
      // Functions.PageRedirection(context, e.message);
    }
  }






  // CustomSettings setting;
  getSettings(context,params) async
  {
   /* try
    {
      await ApiHandler.post(UrlResources.SETTINGS,body: params).then((json) async{
        setting = CustomSettings.fromJson(json);
        notifyListeners();
      });
    }
    on ErrorHandler catch (e)
    {
      Functions.PageRedirection(context, e.message);
    }*/
  }

  Dio _dio = Dio();
  var isemailfound="false";
  var emailmessage="";
  var emailotp="";
  var emailuserid="";
  checkemail(context,params) async
  {
    print("calldhere");
   /* try
    {
      await _dio.post(FORGOT_PASSWORD_EMAIL,data: params).then((value) {
        // var varJson = value.data;
        print("value = ${value}");
        if(value.statusCode == 200)
        {
          // Navigator.pushReplacement(context,PageTransition(type: PageTransitionType.rightToLeft, child: const OtpVerificationScreen()));
          // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const OtpVerificationScreen()));
        }
      });
      *//*await ApiHandler.post(UrlResources.FORGOTPASSWORD_SEND_OTP,body: params).then((json) async{
        if(json["status"]=="true")
        {
          isemailfound="true";
          emailmessage=json["message"].toString();
          emailotp=json["otp"].toString();
          emailuserid=json["userid"].toString();
        }
        else
        {
          isemailfound="false";
          emailmessage=json["message"].toString();
        }
      });*//*
    }
    on ErrorHandler catch (e)
    {
      // Functions.PageRedirection(context, e.message);
    }*/
  }

  var isresetpassword="false";
  var resetpasswordmessage="";
  resetpassword(context,params) async
  {
   /* try
    {
      await ApiHandler.post(UrlResources.RESET_PASSWORD,body: params).then((json) async{
        if(json["status"]=="true")
        {
          isresetpassword="true";
          resetpasswordmessage=json["message"].toString();
        }
        else
        {
          isresetpassword="false";
          resetpasswordmessage=json["message"].toString();
        }
      });
    }
    on ErrorHandler catch (e)
    {
      Functions.PageRedirection(context, e.message);
    }*/
  }



}