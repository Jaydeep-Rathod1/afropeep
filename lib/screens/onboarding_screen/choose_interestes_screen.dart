
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
    );
  }
}
