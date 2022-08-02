
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/onboarding_screen/name_details_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChooseGenderScreen extends StatefulWidget {

  @override
  State<ChooseGenderScreen> createState() => _ChooseGenderScreenState();
}

class _ChooseGenderScreenState extends State<ChooseGenderScreen> {
  String value ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body:Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child:  Column(
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
            CustomText(text: 'What is your gender?',fontSize: 22,color: ColorResources.whiteColor,),
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
            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CustomButton(
                    height: 45,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: (){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> NameDetailsScreen()));
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: NameDetailsScreen()));
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
            ),

          ],
        ),
      ),
    );
  }
}
