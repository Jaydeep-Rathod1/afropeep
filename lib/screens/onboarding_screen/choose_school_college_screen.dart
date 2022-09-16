import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/user_models/modetostart_model.dart';
import '../../resouces/color_resources.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textfield.dart';
import 'choose_date_screen.dart';
class ChooseSchoolCollege extends StatefulWidget {
  String firstName;
  String lastName;
  ModeToStartModel chooseToStart;
  String chooseGender;
  ChooseSchoolCollege({this.firstName,this.lastName,this.chooseToStart,this.chooseGender});
  @override
  State<ChooseSchoolCollege> createState() => _ChooseSchoolCollegeState();
}

class _ChooseSchoolCollegeState extends State<ChooseSchoolCollege> {
  TextEditingController _schoolName = TextEditingController();
  TextEditingController _collegeName = TextEditingController();
  bool isValidSchoolName = false;
  bool isValidCollegeName = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child:Column(
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
              CustomText(text: "What's your School Name?",fontSize: 22.0,color: ColorResources.whiteColor,),
              SizedBox(height: 27.0,),
              CustomText(text: "School Name",fontSize: 14.0,color: ColorResources.whiteColor,),
              SizedBox(height: 15.0,),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: CustomTextField(
                    controller: _schoolName,
                    hintText: 'School Name',
                    fontSize: 14.0,
                    textInputType: TextInputType.text,
                    borderRadius: 29
                ),
              ),
              SizedBox(height: 5.0,),
              isValidSchoolName ?Container(
                padding: EdgeInsets.only(left: 2.0),
                child: CustomText(text: 'Please Enter School Name',color: Colors.white,fontSize: 11,),):Container(),
              SizedBox(height: 24.0,),
              CustomText(text: "College Name",fontSize: 14.0,color: ColorResources.whiteColor,),
              SizedBox(height: 15.0,),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: CustomTextField(
                    controller: _collegeName,
                    hintText: 'College Name',
                    fontSize: 14.0,
                    textInputType: TextInputType.text,
                    borderRadius: 29
                ),
              ),
              SizedBox(height: 5.0,),
              isValidCollegeName ?Container(
                padding: EdgeInsets.only(left: 2.0),
                child: CustomText(text: 'Please Enter College Name',color: Colors.white,fontSize: 11,),):Container(),
              Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CustomButton(
                      height: 45,
                      backgroundColor: ColorResources.blackColor,
                      onPressed: (){
                        // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseDateScreen()));
                        // Navigator.push(context, PageTransition(
                        //     type: PageTransitionType.rightToLeft,
                        //     child: ChooseDateScreen(firstName:_firstName.text.toString(),lastName:_lastName.text.toString(),chooseToStart:widget.chooseToStart,chooseGender:widget.chooseGender)
                        // ));
                        if(_schoolName.text.isNotEmpty && _collegeName.text.isNotEmpty)
                        {
                          setState(() {
                            _schoolName.text.isEmpty ?isValidSchoolName = true :isValidSchoolName = false;
                            _collegeName.text.isEmpty ?isValidCollegeName = true :isValidCollegeName = false;
                          });
                          Navigator.push(context, PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ChooseDateScreen(
                                  firstName:widget.firstName,
                                  lastName:widget.lastName,
                                  chooseToStart:widget.chooseToStart,
                                  chooseGender:widget.chooseGender,
                                  schoolName:_schoolName.text.toString(),
                                  collegeName:_collegeName.text.toString())
                          ));
                        }
                        else{
                          setState(() {
                            _schoolName.text.isEmpty ?isValidSchoolName = true :isValidSchoolName = false;
                            _collegeName.text.isEmpty ?isValidCollegeName = true :isValidCollegeName = false;
                          });
                        }
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
          )

      ),
    );
  }
}
