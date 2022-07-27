

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/onboarding_screen/onboarding_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key key}) : super(key: key);
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
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
              const SizedBox(
                height: 47.0,
              ),
              InkWell(
                  onTap: (){
                    Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight, child: null,));
                  },
                  child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
              ),
              const SizedBox(
                height: 32.0,
              ),
              CustomText(text: 'OTP Verification',fontSize: 22,color: ColorResources.whiteColor,),
              const SizedBox(
                height: 14.0,
              ),
              CustomText(
                text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod.',
                fontSize: 14,
                color: ColorResources.whiteColor,
                height: 1.5,
              ),
              const SizedBox(
                height: 14,
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


              Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CustomButton(
                      height: 45,
                      backgroundColor: ColorResources.blackColor,
                      onPressed: (){
                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: OnboardingScreen()));

                      },
                      buttonText: 'Verify',
                      fontSize: 16.0,
                      textColor: ColorResources.whiteColor,
                      width:MediaQuery.of(context).size.width,
                    )
                ),
              ),
              const SizedBox(
                height: 34,
              )
            ],
          ),
        )
    );
  }
}
