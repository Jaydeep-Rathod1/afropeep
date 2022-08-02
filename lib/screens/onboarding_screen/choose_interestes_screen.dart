
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/facial_recognition_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChooseInterestesScreen extends StatefulWidget {

  @override
  State<ChooseInterestesScreen> createState() => _ChooseInterestesScreenState();
}

class _ChooseInterestesScreenState extends State<ChooseInterestesScreen> {
  List<String> reportList = [
    "Cooking",
    "Health care",
    "Tracking",
    "Outdoor activites",
    "Riding",
    "Yoga",
    "Dancing",
    "Sports",
    "Video Games",
    "Movies",
    "Gardening",
    "Crafts",
    "Gym"
  ];
  List<String> selectedReportList = [];
   Function(List<String>) onSelectionChanged;
   Function(List<String>) onMaxSelected;
   int maxSelection;
  List<String> selectedChoices = [];
  _buildChoiceList() {
    List<Widget> choices = [];

   reportList.forEach((item) {
      choices.add(
          Container(
            height: 41,
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          backgroundColor: ColorResources.whiteColor,
          label: Text(item,style: TextStyle(color: selectedChoices.contains(item)?ColorResources.whiteColor:ColorResources.blackColor),),
          selected: selectedChoices.contains(item),
          selectedColor: ColorResources.blackColor,
          onSelected: (selected) {
            if(selectedChoices.length == (maxSelection  ?? -1) && !selectedChoices.contains(item)) {
              onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                onSelectionChanged?.call(selectedChoices);
              });
            }
          },
        ),
      ));
    });
    return choices;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
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
            CustomText(text: 'Choose Your Interests',fontSize: 22,color: ColorResources.whiteColor,),
            SizedBox(height: 18.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Choose at least 6 ',fontSize: 14,color: ColorResources.whiteColor,),
                CustomText(text: '01/05',fontSize: 14,color: ColorResources.whiteColor,),
              ],
            ),
            SizedBox(height: 23,),
            Wrap(
              children: _buildChoiceList(),
            ),
            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CustomButton(
                    height: 45,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: (){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseDateScreen()));
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: FacialRecognitionScreen()));
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
            /*Expanded(
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> LookingForScreen()));
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
        )*/
          ],
        ),
      ),
    );
  }
}
