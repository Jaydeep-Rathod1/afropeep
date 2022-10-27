
import 'package:afropeep/screens/survey/questions_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../resouces/color_resources.dart';
import '../../widgets/custom_sizedbox.dart';

class TakeSurveyScreen extends StatefulWidget {
  @override
  State<TakeSurveyScreen> createState() => _TakeSurveyScreenState();
}

class _TakeSurveyScreenState extends State<TakeSurveyScreen> {
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
                    Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight, child: null,));
                  },
                  child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
              ),
              CustomSizedBox(newheight: 32.0,),
              CustomText(text: 'Let us know you better...',fontSize: 34,color: ColorResources.whiteColor,),
              CustomSizedBox(newheight: 14.0,),
              CustomText(
                text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.',
                fontSize: 14,
                color: ColorResources.whiteColor,
                height: 1.5,
              ),
              CustomSizedBox(newheight: 14.0,),

              Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: CustomButton(
                      height: 45,
                      backgroundColor: ColorResources.blackColor,
                      onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QuestionsScreen()));
                      },
                      buttonText: "Let's Start",
                      fontSize: 16.0,
                      textColor: ColorResources.whiteColor,
                      // width:MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width/2.7,
                    )
                ),
              ),
              CustomSizedBox(newheight: 34.0,),
            ],
          ),
        )
    );
  }
}

