import 'dart:convert';

import 'package:afropeep/models/user_models/modetostart_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/onboarding_screen/choose_photos_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resouces/constants.dart';
import '../../resouces/functions.dart';
import '../../widgets/custom_sizedbox.dart';
class ChooseDateScreen extends StatefulWidget {
  String firstName;
  String lastName;
  ModeToStartModel chooseToStart;
  String chooseGender;
  String collegeName;
  String schoolName;
  ChooseDateScreen({this.firstName,this.lastName,this.chooseToStart,this.chooseGender,this.schoolName,this.collegeName});
  @override
  State<ChooseDateScreen> createState() => _ChooseDateScreenState();
}

class _ChooseDateScreenState extends State<ChooseDateScreen> {
  TextEditingController _chooseDate = TextEditingController();
  TextEditingController _chooseMonth = TextEditingController();
  TextEditingController _chooseYear = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isValidateDate = false;
  bool validateChoosedDate = false;
  Dio _dio = Dio();
  var newdate;
  DateTime newpickedDate;
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
            CustomSizedBox(newheight: 47.0,),
            InkWell(
                onTap: (){
                  Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight, child: null,));
                },
                child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
            ),
            CustomSizedBox(newheight: 32.0,),
            CustomText(text: "When's your birthday?",fontSize: 22.0,color: ColorResources.whiteColor,),
            CustomSizedBox(newheight: 27.0,),
            CustomSizedBox(
              newheight: 40,
              widgetChild: Row(
                children: [
                  Container(
                    width: 66,
                    height: 44,
                    alignment: Alignment.center,
                    child: TextField(
                        readOnly: true,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        CustomDateTimePicker();
                      },
                      style: TextStyle(fontSize: 14, ),
                      controller: _chooseMonth,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top:20,left: 15),
                        hintText: 'MM',
                        filled: true,
                        fillColor: ColorResources.whiteColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29),
                          borderSide: BorderSide.none,
                        ),
                      ),

                    ),
                  ),
                  SizedBox(width: 7.0,),
                  Container(
                    width: 66,
                    height: 44,
                    alignment: Alignment.center,
                    child:TextField(
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        CustomDateTimePicker();
                        /*showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                          initialDatePickerMode: DatePickerMode.year,
                        )*/
                      },
                      readOnly: true,
                      style: TextStyle(fontSize: 14, ),
                      controller: _chooseDate,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top:20,left: 15),
                        hintText: 'DD',
                        filled: true,
                        fillColor: ColorResources.whiteColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 7.0,),
                  Container(
                    width: 86,
                    height: 44,
                    alignment: Alignment.center,

                    child:TextField(
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        CustomDateTimePicker();
                      },
                      readOnly: true,
                      style: TextStyle(fontSize: 14, ),
                      controller: _chooseYear,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top:20,left: 15),
                        hintText: 'YYYY',
                        filled: true,
                        fillColor: ColorResources.whiteColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomSizedBox(newheight: 5.0,),
            isValidateDate ?Container(
              padding: EdgeInsets.only(left: 2.0),
              child: CustomText(text: 'Please Choose Date',color: Colors.white,fontSize: 11,),):Container(),
            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CustomButton(
                    height: 45,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: () async{
                      if(newdate != null)
                        {
                          setState(() {
                            isValidateDate = false;
                          });
                          insertUserData();
                        }
                      else{
                        setState(() {
                          isValidateDate = true;
                        });
                      }
                      //

                    },
                    buttonText: 'Next',
                    fontSize: 16.0,
                    textColor: ColorResources.whiteColor,
                    width:MediaQuery.of(context).size.width,
                  )
              ),
            ),
            CustomSizedBox(newheight: 34.0,),
          ],
        ),
      ),
    );
  }
  insertUserData() async{
    Apploader(context);
    DateTime birthday = newpickedDate;
    DateDuration duration;
    duration = AgeCalculator.age(newpickedDate);
    print(duration.years);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');
    Map<String, String> params = Map();
    params['user_id'] = userid.toString();
    params['mode_id'] = widget.chooseToStart.modeId.toString();
    params['gender'] = widget.chooseGender.toString();
    params['firstname'] = widget.firstName.toString();
    params['lastname'] = widget.lastName.toString();
    params['birth_date'] = newdate;
    params['age'] =duration.years.toString();
    params['school'] = widget.schoolName.toString();
    params['collage'] = widget.collegeName.toString();
    print(params);
    await _dio.post(UPDATE_USER,data: params).then((value) {
      print("value = ${value}");
      if(value.statusCode == 200)
      {
        setState(() {
          RemoveAppLoader(context);
        });
        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChoosePhotosScreen()));
      }
    });
  }
  DateTime pickedDate;
  CustomDateTimePicker()async{
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(Duration(days: 1)),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().subtract(Duration(days: 1)));
    if (pickedDate != null) {
      if(pickedDate == DateTime.now())
        {
            setState(() {
              validateChoosedDate = true;
            });

        }
      else{
        newpickedDate = pickedDate;
        String date =
        DateFormat('dd').format(pickedDate);
        String month =
        DateFormat('MM').format(pickedDate);
        String year =
        DateFormat('yyyy').format(pickedDate);
        // 10/08/2022

        setState(() {
          _chooseDate.text = date;
          _chooseMonth.text = month;
          _chooseYear.text = year;
          newdate = "${date}/${month}/${year}";//set output date to TextField value.
        });
      }
    } else {}
  }
}