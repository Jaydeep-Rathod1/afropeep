import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../resouces/constants.dart';
import '../../resouces/network/functions.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import 'forgot_password_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var formkey = new GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  BuildContext ctx;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AuthProvider provider;
  bool isLoading=false;
  Dio _dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      provider = Provider.of<AuthProvider>(context,listen: false);
    });
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      ctx=context;
    });
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Forgot Password',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: Container(

        child: SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(20.0),
                // padding: EdgeInsets.only(left: StyleResources.ContainerSize,right: StyleResources.ContainerSize),
                // color: StyleResources.BlueColor,
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 22.0),
                        CustomTextField(controller: _email,textInputType: TextInputType.text,fontSize: 14,hintText: 'Enter Emailid',borderRadius: 30,enabledBorder: true,focusedBorder: true,

                        ),
                        SizedBox(height: 15.0),
                        CustomButton(
                          height: 45,
                          fontSize: 16,
                          width: MediaQuery.of(context).size.width,
                          backgroundColor: ColorResources.blackColor,
                          onPressed: ()async{
                            Map<String,String> params = {
                              "email":_email.text.toString(),
                            };
                            await _dio.post(FORGOT_PASSWORD_EMAIL,data: params).then((value) {
                              // var varJson = value.data;
                              print("value = ${value.data}");
                              if(value.statusCode == 200)
                              {
                                if(value.data['message']=="Email address not found")
                                  {
                                    Fluttertoast.showToast(
                                      msg: "Email address not found",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ColorResources.primaryColor,
                                      textColor: ColorResources.whiteColor,
                                      fontSize: 16.0,
                                    );
                                  }
                                else{
                                  var otp = value.data['otp'].toString();
                                   Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ForgotPasswordOtpScreen(otp:otp))
                            );
                                }

                              }
                            });
                           /* Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ForgotPasswordOtpScreen())
                            );*/

                           /* if(validateEmail()){
                              print("called");
                                if(formkey.currentState.validate())
                              {
                                setState(() {
                                  isLoading=true;
                                });

                               *//* if(provider.isemailfound=="true")
                                {
                                  FunctionDefualt.ShowSnackbar(context,_scaffoldKey, provider.emailotp,"OK");
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => ForgotPasswordOtpScreen())
                                  );
                                }
                                else
                                {
                                  print(provider.emailmessage);
                                  FunctionDefualt.ShowSnackbar(context,_scaffoldKey, provider.emailmessage,"OK");
                                }
                                setState(() {
                                  isLoading=false;
                                });*//*
                              }
                            }*/

                          },
                          buttonText: 'Send OTP',
                        ),


                      ],
                    ),
                  ),
                ),
              ),
              // isLoading ?loading_screen() : Container()
            ],
          ),
        ),
      ),
    );
  }
  validateEmail(){
    if(_email.text.toString().isEmpty){
      return false;
    }else if(FunctionDefualt.isEmail(_email.text.toString())){
      return false;
    }
    return true;
  }
}
