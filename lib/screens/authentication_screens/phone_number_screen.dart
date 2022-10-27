

// ignore_for_file: missing_required_param

import 'dart:convert';

import 'package:afropeep/models/user_models/country_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/resouces/functions.dart';
import 'package:afropeep/screens/authentication_screens/opt_verification_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/custom_sizedbox.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key key}) : super(key: key);
  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}
class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  Dio _dio =new Dio();
  CountryModel dropdownvalue;
  // List of items in our dropdown menu
  BuildContext _mainContex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        getCountryCode();
      });
    });
  }

  List<CountryModel> getData = [];
  List<CountryModel> arrAllCountryList = [];
  List<CountryModel> arrCountryList = [];
  getCountryCode()async {
    print("called");
    Apploader(_mainContex);

    await _dio.get(GET_COUNTRY).then((value) {

      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
        {
          setState(() {
            arrAllCountryList =varJson.map((e) =>CountryModel.fromJson(e)).toList();
            RemoveAppLoader(_mainContex);
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
           CustomSizedBox(
             newheight: 47.0,
           ),
           InkWell(
               onTap: (){

                 Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight,));
               },
               child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
           ),
           CustomSizedBox(
             newheight: 32.0,
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
           CustomSizedBox(
             newheight: 14,
           ),

           Expanded(child: Row(
             children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
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
                   CustomSizedBox(
                     newheight: 5,
                   ),
                   validCountryCode? CustomText(text: 'Choose Code',color: Colors.white,fontSize: 11,):Container(),
                 ],
               ),
               CustomSizedBox(
                 newwidth: 7,
               ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Container(
                     height: 40,
                     width: MediaQuery.of(context).size.width/1.72,
                     child: CustomTextField(
                       controller: _phoneNumberController,
                       hintText: 'Enter phone number here',
                       fontSize: 14.0,
                       textInputType: TextInputType.phone,
                       borderRadius: 29,
                     ),
                   ),
                   CustomSizedBox(
                     newheight: 5,
                   ),
                   validPhone ?Container(
                     padding: EdgeInsets.only(left: 2.0),
                     child: CustomText(text: 'Please Enter Phone Number',color: Colors.white,fontSize: 11,),):Container(),
                   validPhoneLength? Container(
                     padding: EdgeInsets.only(left: 2.0),
                     child: CustomText(text: 'Phone Number Must Be 10 Digits',color: Colors.white,fontSize: 11,),):Container(),
                   validNumber? Expanded(child: Container(
                     padding: EdgeInsets.only(left: 2.0),
                     child: Text('Mobile Number Already Registered',style: TextStyle(color: Colors.white,fontSize: 11,),),)):Container(),
                 ],
               ),

               // Expanded(child:  )
             ],
           ),),
           Expanded(
             child: Align(
               alignment: FractionalOffset.bottomCenter,
               child: CustomButton(
                 height: 45,
                 backgroundColor: ColorResources.blackColor,
                 onPressed: ()async{
                   _isValidate();
                   if(_phoneNumberController.text.isNotEmpty &&_phoneNumberController.text.isNotEmpty && _phoneNumberController.text.length == 10 &&  dropdownvalue.countryId != null){
                     // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const OtpVerificationScreen()));
                     final fcmToken = await FirebaseMessaging.instance.getToken();
                     print("fcmtoken = ${fcmToken}");
                     Map<String, String> params = Map();
                     params['mobile_number'] = _phoneNumberController.text.toString();
                     params['country_id'] = dropdownvalue.countryId.toString();
                     params['accesstoken'] = fcmToken.toString();
                     print(params);
                     await _dio.post(ADD_USER,data:jsonEncode(params)).then((value)async {
                       print(value);
                       if(value.statusCode == 200)
                       {
                         print("data status = ${value.data['status']}");
                         if(value.data['status'] == 'false')
                         {
                           setState(() {
                             validNumber = true;
                           });

                         }
                         else
                         {
                           setState(() {
                             validNumber = false;
                           });
                           print("value = ${value.data}");
                           var userid = value.data['user_id'];
                           print("user id = ${userid}");
                           SharedPreferences prefs = await SharedPreferences.getInstance();
                           prefs.setInt('userid', userid);
                           var otp = value.data['otp'].toString();
                           print(otp);
                           // SendOtpRequest(userid,otp);
                           Navigator.pushReplacement(context,PageTransition(type: PageTransitionType.rightToLeft, child:  OtpVerificationScreen(userotp:otp)));
                         }

                       }
                     });
                   }else{
                     _isValidate();
                   }

                 },
                 buttonText: 'Next',
                 fontSize: 16.0,
                 textColor: ColorResources.whiteColor,
                 width:MediaQuery.of(context).size.width,
               )
             ),
           ),
           CustomSizedBox(
             newheight: 34,
           ),
      ],
    ),
       )
    );
  }
  bool validPhone= false;
  bool validPhoneLength= false;
  bool validCountryCode= false;
  bool validNumber = false;
  _isValidate(){
   setState(() {
     _phoneNumberController.text.isEmpty ?validPhone = true :validPhone = false;
     (_phoneNumberController.text.isNotEmpty && _phoneNumberController.text.length != 10)?validPhoneLength = true:validPhoneLength=false;
     dropdownvalue.countryId == null ? validCountryCode = true:validCountryCode=false;
   });
  }
  /*SendOtpRequest(int userid,String otp) async{
    Map<String, String> params = Map();
    params['user_id'] = userid.toString();
    params['otp'] = otp.toString();
    print("called= ${params}");
    await _dio.post(SEND_OTP_REQUEST,data: params).then((value) {
      // var varJson = value.data;
      print("value = ${value}");
      if(value.statusCode == 200)
      {
        Navigator.pushReplacement(context,PageTransition(type: PageTransitionType.rightToLeft, child: const OtpVerificationScreen()));
        // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const OtpVerificationScreen()));
      }
    });
  }*/
}
