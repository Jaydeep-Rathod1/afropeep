
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/survey/take_survey_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resouces/constants.dart';
import '../../widgets/custom_sizedbox.dart';

class LookingForScreen extends StatefulWidget {
String choices;
LookingForScreen({this.choices});
  @override
  State<LookingForScreen> createState() => _LookingForScreenState();
}

class _LookingForScreenState extends State<LookingForScreen> {
  String value ;
  Dio _dio = Dio();
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
              CustomSizedBox(newheight: 47.0,),
              InkWell(
                  onTap: (){
                    Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight,));
                  },
                  child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
              ),
              CustomSizedBox(newheight: 32.0,),
              CustomText(text: 'Looking for...',fontSize: 22,color: ColorResources.whiteColor,),
              CustomSizedBox(newheight: 88.0,),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                value = "Male";
                              });
                            },
                            child: Container(
                              width: 109,
                              height: 107,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: value == "Male"? ColorResources.blackColor:ColorResources.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset('assets/icons/icon_male.png',color:value == "Male"? ColorResources.whiteColor:ColorResources.blackColor,height: 64,width: 24,),
                            ),
                          ),
                          CustomSizedBox(newheight: 10.0,),
                          CustomText(text: 'Male',fontSize: 14,color: ColorResources.whiteColor,)
                        ],
                      ),
                      SizedBox(width: 24,),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                value = "Female";
                              });
                            },
                            child: Container(
                              width: 109,
                              height: 107,
                              alignment: Alignment.center,

                              decoration: BoxDecoration(
                                color:value == "Female"? ColorResources.blackColor:ColorResources.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset('assets/icons/icon_female.png',color:value == "Female"? ColorResources.whiteColor:ColorResources.blackColor,height: 51.2,width: 24,),
                            ),
                          ),
                          CustomSizedBox(newheight: 10.0,),
                          CustomText(text: 'Female',fontSize: 14,color: ColorResources.whiteColor,)
                        ],
                      ),
                    ],
                  ),
                  CustomSizedBox(newheight: 30.8,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        value = "Other";
                      });
                    },
                    child:Container(
                      width: 109,
                      height: 107,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:value == "Other"? ColorResources.blackColor:ColorResources.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/icon_male.png',color:value == "Other"? ColorResources.whiteColor:ColorResources.blackColor,height: 64,width: 24,),
                          SizedBox(width: 6.8,),
                          Image.asset('assets/icons/icon_female.png',color:value == "Other"? ColorResources.whiteColor:ColorResources.blackColor,height: 51.2,width: 24,)
                        ],
                      ),
                    ),
                  ),
                  CustomSizedBox(newheight: 10.0,),
                  CustomText(text: 'Other',fontSize: 14,color: ColorResources.whiteColor,)
                ],
              ),
              Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CustomButton(
                      height: 45,
                      backgroundColor: ColorResources.blackColor,
                      onPressed: (){
                        updateUserData();
                      },
                      buttonText: 'Next',
                      fontSize: 16.0,
                      textColor: ColorResources.whiteColor,
                      width:MediaQuery.of(context).size.width,
                    )
                ),
              ),
              CustomSizedBox(newheight: 34.0,),
            ],
          ),
        )
    );
    /*return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(text: 'Looking for...',fontSize: 22,color: ColorResources.whiteColor,),
          SizedBox(height: 88.0,),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            value = "Male";
                          });
                        },
                        child: Container(
                          width: 109,
                          height: 107,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: value == "Male"? ColorResources.blackColor:ColorResources.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset('assets/icons/icon_male.png',color:value == "Male"? ColorResources.whiteColor:ColorResources.blackColor,height: 64,width: 24,),
                        ),
                      ),
                      SizedBox(height: 10,),
                      CustomText(text: 'Male',fontSize: 14,color: ColorResources.whiteColor,)
                    ],
                  ),
                  SizedBox(width: 24,),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            value = "Female";
                          });
                        },
                        child: Container(
                          width: 109,
                          height: 107,
                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            color:value == "Female"? ColorResources.blackColor:ColorResources.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset('assets/icons/icon_female.png',color:value == "Female"? ColorResources.whiteColor:ColorResources.blackColor,height: 51.2,width: 24,),
                        ),
                      ),
                      SizedBox(height: 10,),
                      CustomText(text: 'Female',fontSize: 14,color: ColorResources.whiteColor,)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.8,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    value = "Other";
                  });
                },
                child:Container(
                  width: 109,
                  height: 107,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:value == "Other"? ColorResources.blackColor:ColorResources.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon_male.png',color:value == "Other"? ColorResources.whiteColor:ColorResources.blackColor,height: 64,width: 24,),
                      SizedBox(width: 6.8,),
                      Image.asset('assets/icons/icon_female.png',color:value == "Other"? ColorResources.whiteColor:ColorResources.blackColor,height: 51.2,width: 24,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              CustomText(text: 'Other',fontSize: 14,color: ColorResources.whiteColor,)
            ],
          ),
          */
    /*Expanded(
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> NameDetailsScreen()));
                },
                buttonText: 'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width,
              )
          ),
        ),
        const SizedBox(
          height: 34,
        ),*//*

        ],
      ),
    );*/
  }
  updateUserData() async{
    List<String> selectedChoicesName =[];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');
    Map<String, String> params = Map();
    params['user_id'] = userid.toString();
    params['looking_for'] = value;
    params['intrest'] = widget.choices;
    print(params);
    await _dio.post(UPDATE_USER1,data: params).then((value) {
      print("value = ${value}");
      if(value.statusCode == 200)
      {
        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child:  TakeSurveyScreen()));
      }
    });
  }
}
