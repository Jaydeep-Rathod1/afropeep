

// ignore_for_file: missing_required_param

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/authentication_screens/opt_verification_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key key}) : super(key: key);
  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}
class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownvalue = 'CA +1';
  // List of items in our dropdown menu
  var items = [
    'CA +1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
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
                 Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight,));
               },
               child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
           ),
           const SizedBox(
             height: 32.0,
           ),
           CustomText(text: 'Enter phone number',fontSize: 22,color: ColorResources.whiteColor,),
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
           Row(
             children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width/3.5,
                padding: const EdgeInsets.only(left: 13,right:8 ,top: 3,bottom: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29),
                  color: ColorResources.whiteColor,
                ),
                child:  DropdownButtonHideUnderline(
                    child:  DropdownButton(
                      style: TextStyle(fontSize: 14.0,color: ColorResources.blackColor ),
                      value: dropdownvalue,
                      icon: const Icon(Icons.arrow_drop_down_sharp,size: 34,),
                      items: items.map((String items) {
                        return DropdownMenuItem(

                          value: items,
                          child: Text(items,overflow: TextOverflow.ellipsis,),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownvalue = newValue;
                        });
                      },
                    ),),

              ),
               const SizedBox(
                 width: 7,
               ),
               Expanded(child:  SizedBox(
                 height: 40,
                 child: CustomTextField(
                   controller: _phoneNumberController,
                   hintText: 'Enter phone number here',
                   fontSize: 14.0,
                   textInputType: TextInputType.phone,
                     borderRadius: 29
                 ),
               ))
             ],
           ),
          
           Expanded(
             child: Align(
               alignment: FractionalOffset.bottomCenter,
               child: CustomButton(
                 height: 45,
                 backgroundColor: ColorResources.blackColor,
                 onPressed: (){
                   Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const OtpVerificationScreen()));
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
       )
    );
  }
}
