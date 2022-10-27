import 'dart:convert';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';



import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_models/single_user_model.dart';
import '../../resouces/constants.dart';
import '../../resouces/functions.dart';
import 'forgot_password_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _reTypeNewPassword = TextEditingController();
  bool isValidatePassword = false;
  bool isValidateNewPassword = false;
  bool isValidateRetypePassword = false;
  Dio _dio = Dio();
  SingleUserModel arrAllUser;
  BuildContext _mainContex;
  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getSingleUserDetails();

    });
  }
  getSingleUserDetails()async{
    Apploader(_mainContex);
    Map params = Map();
    prefs = await SharedPreferences.getInstance();
    var userid =prefs.getInt('userid');
    print(userid);
    params['userid'] = userid;
    await _dio.post(GET_USER_BY_ID,data: jsonEncode(params)).then((value) {
     var jsonData = value.data ;
      if(value.statusCode == 200)
      {
        setState(() {
          arrAllUser =SingleUserModel.fromJson(jsonData[0]);
          // _currentPassword.text = arrAllUser.password.toString();
          RemoveAppLoader(_mainContex);
        });
        setValueChangePassword();
      }
    });
  }
  setValueChangePassword(){
    if(arrAllUser.changepass == "no")
      {
        _currentPassword.text = arrAllUser.password;
      }
    else{
      // _currentPassword.text = arrAllUser.password;
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Change Password',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(20.0),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(controller: _currentPassword,textInputType: TextInputType.text,fontSize: 14,hintText: 'Current Password',borderRadius: 30,enabledBorder: true,focusedBorder: true,),

              SizedBox(height: 20,),
              CustomTextField(controller: _newPassword,textInputType: TextInputType.text,obSequreText:true,maxLines: 1,fontSize: 14,hintText: 'New Password',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              isValidateNewPassword ?Container(
                padding: EdgeInsets.only(left: 12.0),
                child: CustomText(text: 'Please Enter Password',color: Colors.red,fontSize: 11,),):Container(),
              SizedBox(height: 20,),
              CustomTextField(controller: _reTypeNewPassword,maxLines: 1,obSequreText: true,textInputType: TextInputType.text,fontSize: 14,hintText: 'Re-type New Password ',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              isValidateRetypePassword ?Container(
                padding: EdgeInsets.only(left: 12.0),
                child: CustomText(text: 'Please Re-type New Password',color: Colors.red,fontSize: 11,),):Container(),
              isValidatePassword ?Container(
                padding: EdgeInsets.only(left: 12.0),
                child: CustomText(text: 'Password doesn\'t match',color: Colors.red,fontSize: 11,),):Container(),
              SizedBox(height: 48,),
              CustomButton(
                height: 45,
                fontSize: 16,
                width: MediaQuery.of(context).size.width,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  insertChangePassword();
                },
                buttonText: 'Update Password',
              ),
              SizedBox(height: 11.0,),
              CustomButton(
                height: 45,
                fontSize: 16,
                width: MediaQuery.of(context).size.width,
                backgroundColor: Color(0xffF4F4F6),
                onPressed: (){
                  Navigator.of(context).pop();
                },
                buttonText: 'Cancel',
                textColor: ColorResources.blackColor,
              ),
              SizedBox(height: 0.0,),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>ForgotPasswordScreen()));
              }, child: CustomText(text: 'Forgot your Password',fontSize: 12,color: Color(0xff009EFF),))
            ],
          ),
        )
      ),
    );
  }
  insertChangePassword()async{
    print("called");
    var oldPassword = _currentPassword.text.toString();
    var newPassword = _newPassword.text.toString();
    var reTypePassword = _reTypeNewPassword.text.toString();
    if(newPassword.isEmpty)
      {
        setState(() {
          isValidateNewPassword = true;
        });
      }
    if(reTypePassword.isEmpty)
      {
        setState(() {
          isValidateRetypePassword = true;
        });
      }
    if(newPassword.isNotEmpty && reTypePassword.isNotEmpty)
      {
        setState(() {
          isValidateNewPassword = false;
          isValidateRetypePassword = false;
        });
        if(newPassword == reTypePassword)
        {
          print("matched");
          setState(() {
            isValidatePassword = false;
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var userid =prefs.getInt('userid');
          Map params = Map();
          params['oldpass'] = oldPassword;
          params['newpass'] = newPassword;
          params['userid'] = userid.toString();
          // params['userid'] = 82;
          print("paramert = ${params}");
          await _dio.post(CHANGE_PASSWORD,data:jsonEncode(params)).then((value)async {
            print(value);
            if(value.statusCode == 200)
            {
              Fluttertoast.showToast(
                msg: "Edit Password Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorResources.primaryColor,
                textColor: ColorResources.whiteColor,
                fontSize: 16.0,
              );
                Navigator.of(context).pop();
                Navigator.push(context,PageTransition(type: PageTransitionType.rightToLeft, child: HomeScreen()));
            }


          });
        }
        else{
          print("not matched");
          setState(() {
            isValidatePassword = true;
          });
        }
      }
  }
}
