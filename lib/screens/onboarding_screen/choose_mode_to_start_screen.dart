
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/onboarding_screen/choose_gender_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChooseModeToStart extends StatefulWidget {

  @override
  State<ChooseModeToStart> createState() => _ChooseModeToStartState();
}

class _ChooseModeToStartState extends State<ChooseModeToStart> {
  String value ;
  bool isSelected = false;
  String selectedvalue ='modetostart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            CustomText(text: 'Choose a mode to start',fontSize: 22,color: ColorResources.whiteColor,),
            SizedBox(height: 30.0,),
            GestureDetector(
              onTap: (){
                setState(() {
                  // isSelected = !isSelected;
                  value = "Friends";
                });
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 61,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left:30),
                  decoration: BoxDecoration(
                      color: ColorResources.whiteColor,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: ListTile(
                    title: Text('Friends'),
                    trailing: value == 'Friends'? Icon(Icons.check_circle ,color: Colors.black,):Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
                  )
              ),
            ),
            SizedBox(height: 14.0,),
            GestureDetector(
              onTap: (){
                setState(() {
                  // isSelected = !isSelected;
                  value = "Business";
                });
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 61,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left:30),
                  decoration: BoxDecoration(
                      color: ColorResources.whiteColor,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: ListTile(
                    title: Text('Business'),
                    trailing: value == "Business"? Icon(Icons.check_circle ,color: Colors.black,):Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
                  )
              ),
            ),
            SizedBox(height: 14.0,),
            GestureDetector(
              onTap: (){
                setState(() {
                  // isSelected = !isSelected;
                  value = "Dating";
                });
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 61,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left:30),
                  decoration: BoxDecoration(
                      color: ColorResources.whiteColor,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: ListTile(
                    title: Text('Dating'),
                    trailing: value == 'Dating'? Icon(Icons.check_circle ,color: Colors.black,):Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
                  )
              ),
            ),

            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CustomButton(
                    height: 45,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: (){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChoosePhotosScreen()));
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChooseGenderScreen()));
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



