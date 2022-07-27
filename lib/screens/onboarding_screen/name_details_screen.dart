
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class NameDetailsScreen extends StatefulWidget {
  @override
  State<NameDetailsScreen> createState() => _NameDetailsScreenState();
}

class _NameDetailsScreenState extends State<NameDetailsScreen> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "What's your name?",fontSize: 22.0,color: ColorResources.whiteColor,),
        SizedBox(height: 27.0,),
        CustomText(text: "First Name",fontSize: 14.0,color: ColorResources.whiteColor,),
        SizedBox(height: 15.0,),
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
            controller: _firstName,
            hintText: 'First Name',
            fontSize: 14.0,
            textInputType: TextInputType.text,
              borderRadius: 29
          ),
        ),
        SizedBox(height: 24.0,),
        CustomText(text: "Sur Name / Last Name",fontSize: 14.0,color: ColorResources.whiteColor,),
        SizedBox(height: 15.0,),
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: CustomTextField(
            controller: _firstName,
            hintText: 'Sur Name / Last Name',
            fontSize: 14.0,
            textInputType: TextInputType.text,
              borderRadius: 29
          ),
        ),
        /*Expanded(
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseDateScreen()));
                },
                buttonText: 'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width,
              )
          ),
        ),*/
      ],
    );
  }
}
