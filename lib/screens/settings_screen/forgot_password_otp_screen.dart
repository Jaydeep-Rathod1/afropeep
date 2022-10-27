import 'package:afropeep/resouces/network/functions.dart';
import 'package:afropeep/screens/settings_screen/change_password_screen.dart';
import 'package:afropeep/screens/settings_screen/reset_password_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../resouces/color_resources.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_sizedbox.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textfield.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  String otp;
  ForgotPasswordOtpScreen({this.otp});
  @override
  State<ForgotPasswordOtpScreen> createState() => _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var otp="";
  final TextEditingController _otpController = TextEditingController();
  Dio _dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          titleSpacing: 0,
          title:CustomText(
            text: 'OTP Verification',
            fontSize: 18,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSizedBox(
                newheight: 25.0,
              ),
              CustomTextField(controller: _otpController,textInputType: TextInputType.text,fontSize: 14,hintText: 'Enter OTP',borderRadius: 30,enabledBorder: true,focusedBorder: true,),

              CustomSizedBox(
                newheight: 5.0,
              ),
              /*validOtpEmpty ?Container(
                padding: EdgeInsets.only(left: 8.0),
                child: CustomText(text: 'Please Enter OTP',color: Colors.white,fontSize: 11,),):Container(),
              validOtp ?Container(
                padding: EdgeInsets.only(left: 8.0),
                child: CustomText(text: 'Please Enter Valid OTP',color: Colors.white,fontSize: 11,),):Container(),*/
              CustomSizedBox(
                newheight: 15.0,
              ),
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CustomButton(
                    height: 45,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: (){
                      // _isValidate();
                      // otpVerification();
                      if(_otpController.text.toString() == widget.otp)
                        {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ResetPasswordScreen())
                          );
                        }else{
                        Fluttertoast.showToast(
                          msg: "Invalid Otp",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: ColorResources.primaryColor,
                          textColor: ColorResources.whiteColor,
                          fontSize: 16.0,
                        );
                      }

                    },
                    buttonText: 'Verify',
                    fontSize: 16.0,
                    textColor: ColorResources.whiteColor,
                    width:MediaQuery.of(context).size.width,
                  )
              ),
            ],
          ),
        )
    );
  }
}
