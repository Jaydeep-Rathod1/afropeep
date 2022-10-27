

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_mode_to_start_screen.dart';
import 'package:afropeep/screens/onboarding_screen/onboarding_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_sizedbox.dart';

class OtpVerificationScreen extends StatefulWidget {
  String userotp;
  OtpVerificationScreen({this.userotp});
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  Dio _dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("otp = ${widget.userotp}");
    Fluttertoast.showToast(
        msg: "${widget.userotp}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorResources.whiteColor,
        textColor: ColorResources.primaryColor,
        fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorResources.primaryColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSizedBox(
                newheight: 47,
              ),
              InkWell(
                  onTap: (){
                    Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight, child: null,));
                  },
                  child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
              ),
              CustomSizedBox(
                newheight: 32,
              ),
              CustomText(text: 'OTP Verification',fontSize: 22,color: ColorResources.whiteColor,),
              CustomSizedBox(
                newheight: 14.0,
              ),
              CustomText(
                text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod.',
                fontSize: 14,
                color: ColorResources.whiteColor,
                height: 1.5,
              ),
              CustomSizedBox(
                newheight: 14.0,
              ),
              SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width/1.96,
                    child: CustomTextField(
                      controller: _otpController,
                      hintText: 'OTP here',
                      fontSize: 14.0,
                      textInputType: TextInputType.phone,
                      borderRadius: 29
                    ),
                  ),
              CustomSizedBox(
                newheight: 5.0,
              ),
              validOtpEmpty ?Container(
                padding: EdgeInsets.only(left: 8.0),
                child: CustomText(text: 'Please Enter OTP',color: Colors.white,fontSize: 11,),):Container(),
              validOtp ?Container(
                padding: EdgeInsets.only(left: 8.0),
                child: CustomText(text: 'Please Enter Valid OTP',color: Colors.white,fontSize: 11,),):Container(),

              Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CustomButton(
                      height: 45,
                      backgroundColor: ColorResources.blackColor,
                      onPressed: (){
                        // _isValidate();
                        otpVerification();

                      },
                      buttonText: 'Verify',
                      fontSize: 16.0,
                      textColor: ColorResources.whiteColor,
                      width:MediaQuery.of(context).size.width,
                    )
                ),
              ),
              CustomSizedBox(
                newheight: 34.0,
              ),
            ],
          ),
        )
    );
  }
  bool validOtp= false;
  bool validOtpTime= false;
  bool validOtpEmpty= false;
  bool isvalidateAll = false;
  _isValidate(){
    setState(() {
      _otpController.text.isEmpty ?validOtpEmpty = true : validOtpEmpty = false;
      // (_otpController.text.isNotEmpty) ? validOtp = true : validOtp = false;
      // ()?validOtpTime = true:validOtpTime=false;
      // dropdownvalue.countryId == null ? validOtpEmpty = true:validOtpEmpty=false;
    });
  }
  otpVerification()async{
    var otpget = _otpController.text.toString();
    var correctotp = widget.userotp.toString();
    if(otpget == correctotp)
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int userid = prefs.getInt('userid');
        prefs.setBool("isLogin", true);
        Map<String, String> params = Map();
        params['user_id'] = userid.toString();
        params['otp'] = _otpController.text.toString();

          await _dio.post(VERIFY_OTP,data: params).then((value) {
            var varJson = value.data;
            print(varJson);
            if(value.statusCode == 200)
            {
              prefs.setBool("loginvalid", true);
              var statusVerify =varJson['status'];
              if(statusVerify == "no")
                {
                  print("if called");
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChooseModeToStart()));
                }else{
                prefs.setBool('loginvalid', true);
                prefs.setBool("isCompleteCongrations",true);
                Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: HomeScreen()));
              }
              // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChooseModeToStart()));
              // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const OtpVerificationScreen()));
            }
          });
        }else{
        setState(() {
          validOtp = true;
        });
      }


  }
}
