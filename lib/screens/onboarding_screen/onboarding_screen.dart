
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/facial_recognition_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_date_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_gender_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_interestes_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_mode_to_start_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_photos_screen.dart';
import 'package:afropeep/screens/onboarding_screen/looking_for_screen.dart';
import 'package:afropeep/screens/onboarding_screen/name_details_screen.dart';
import 'package:afropeep/screens/survey/take_survey_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 47.0,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: InkWell(
                  onTap: (){
                    Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight, child: null,));
                    /*if(_pageController.page.toInt() > 1)
                    {
                      print(_pageController.page.toInt() -1);
                      _pageController.animateToPage(_pageController.page.toInt() -1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeIn
                      );
                    }
                    else{
                      print('else');
                      if(_pageController.page.toInt() != 1)
                        Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight,));

                    }*/

                  },
                  child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
              ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          Flexible(
            child:  Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: ChooseModeToStart(),
            )
          ),
        /* Flexible(
           child:  Padding(
             padding: EdgeInsets.only(left: 20,right: 20),
             child: PageView(
               controller: _pageController,
               physics: NeverScrollableScrollPhysics(), // Prevent the user from swiping
               scrollDirection: Axis.horizontal,
               children: [
                 ChooseModeToStart(),
                 ChooseGenderScreen(),
                 NameDetailsScreen(),
                 ChooseDateScreen(),
                 ChoosePhotosScreen(),
                 ChooseInterestesScreen(),
                 // FacialRecognitionScreen(),
                 // LookingForScreen(),
               ],
             ),
           ),
         ),*/
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
            child:  Align(
                alignment: FractionalOffset.bottomCenter,
                child: CustomButton(
                  height: 45,
                  backgroundColor: ColorResources.blackColor,
                  onPressed: (){
                    // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseGenderScreen()));
                    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChooseGenderScreen()));
                   /* if(_pageController.page.toInt()+1 >5)
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FacialRecognitionScreen()));
                      }
                    else{
                      _pageController.animateToPage(_pageController.page.toInt() + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeIn
                      );
                    }*/
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
          )
        ],
      ),
    );
  }
}

/*children: [
ChooseModeToStart(),
ChooseGenderScreen(),
NameDetailsScreen(),
ChooseDateScreen(),
ChoosePhotosScreen(),
ChooseInterestesScreen(),
LookingForScreen()
],*/
/*class ChooseModeToStart extends StatelessWidget {
  const ChooseModeToStart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(text: 'Choose a mode to start',fontSize: 22,color: ColorResources.whiteColor,),
        SizedBox(height: 30.0,),

      ],
    );
  }
  Widget CustomRadioButton(String text, int index) {
    return OutlineButton(
      onPressed: () {
        setState(() {
          value = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.green : Colors.black,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderSide:
      BorderSide(color: (value == index) ? Colors.green : Colors.black),
    );
  }
}*/



