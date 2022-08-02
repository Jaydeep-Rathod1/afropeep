

// ignore_for_file: missing_required_param

import 'dart:convert';

import 'package:afropeep/models/user_models/country_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/authentication_screens/opt_verification_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key key}) : super(key: key);
  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}
class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  Dio _dio = Dio();
  CountryModel dropdownvalue;
  // List of items in our dropdown menu

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryCode();
  }

  List<CountryModel> getData = [];
  List<CountryModel> arrAllCountryList = [];
  List<CountryModel> arrCountryList = [];
  getCountryCode()async {
    await _dio.get(GET_COUNTRY).then((value) {

      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
        {
          setState(() {
            arrAllCountryList =varJson.map((e) =>CountryModel.fromJson(e)).toList();
            dropdownvalue = arrAllCountryList[0];
          });
        }
    });
  }
  CountryModel _selectedValue;
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
                child:DropdownButtonHideUnderline(
                      child:  DropdownButton<CountryModel>(
                        style: TextStyle(fontSize: 14.0,color: ColorResources.blackColor ),
                        icon: const Icon(Icons.arrow_drop_down_sharp,size: 30,color: Colors.black,),
                        hint: new Text("US +1"),
                        borderRadius: BorderRadius.circular(10),
                        isDense: true,
                        value: dropdownvalue,
                        items: arrAllCountryList.map((CountryModel value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text("${value.countryShortname}  +${value.countryCode}",overflow: TextOverflow.ellipsis,),
                          );
                        }).toList(),
                        onChanged: (CountryModel newValue) {
                          setState(() {
                            dropdownvalue = newValue;
                          });
                        },
                      ),)
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
                 onPressed: ()async{
                   // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const OtpVerificationScreen()));
                   Map<String, String> params = Map();
                   params['mobile_number'] = _phoneNumberController.text.toString();
                   params['country_id'] = dropdownvalue.countryId.toString();
                   await _dio.post(ADD_USER,data:jsonEncode(params)).then((value) {
                     if(value.statusCode == 200)
                     {
                       Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const OtpVerificationScreen()));
                     }
                   });
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
