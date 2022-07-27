import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AddEventScreen extends StatefulWidget {
  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  TextEditingController _eventName = TextEditingController();
  TextEditingController _eventDate = TextEditingController();
  TextEditingController _eventLocation = TextEditingController();
  TextEditingController _eventabout = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Add Event',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24,),
              CustomText(text: 'Event Name',),
              SizedBox(height: 15,),
              CustomTextField(controller: _eventName,fontSize: 14,hintText: 'Event Name',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              SizedBox(height: 24,),
              CustomText(text: 'Event date',),
              SizedBox(height: 15,),
              CustomTextField(controller: _eventDate,fontSize: 14,hintText: 'MM/DD/YYYY',borderRadius: 30,enabledBorder: true,focusedBorder: true,iconName: CupertinoIcons.calendar,iconColor: ColorResources.blackColor,onPressed:(){}),
              SizedBox(height: 24,),
              CustomText(text: 'Event Location',),
              SizedBox(height: 15,),
              CustomTextField(controller: _eventLocation,fontSize: 14,hintText: 'Choose Location',borderRadius: 30,enabledBorder: true,focusedBorder: true,iconName: Icons.location_on_outlined,iconColor: ColorResources.blackColor,onPressed:(){}),
              SizedBox(height: 24,),
              CustomText(text: 'About Event',),
              SizedBox(height: 15,),
              CustomTextField(controller: _eventabout,fontSize: 14,hintText: 'Write here',borderRadius: 30,enabledBorder: true,focusedBorder: true,onPressed:(){},maxLines: 5,),
              SizedBox(height: 24,),
              Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CustomButton(
                      height: 45,
                      backgroundColor: ColorResources.blackColor,
                      onPressed: (){

                      },
                      buttonText: 'Post',
                      fontSize: 16.0,
                      textColor: ColorResources.whiteColor,
                      width:MediaQuery.of(context).size.width,
                    )
                ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
