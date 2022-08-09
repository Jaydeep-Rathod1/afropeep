
import 'package:afropeep/models/user_models/modetostart_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/onboarding_screen/choose_date_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NameDetailsScreen extends StatefulWidget {
  ModeToStartModel chooseToStart;
  String chooseGender;
  NameDetailsScreen({this.chooseToStart,this.chooseGender});
  @override
  State<NameDetailsScreen> createState() => _NameDetailsScreenState();
}

class _NameDetailsScreenState extends State<NameDetailsScreen> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  bool isValidFirstName = false;
  bool isValidLastName = false;
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
              SizedBox(height: 5.0,),
              isValidFirstName ?Container(
                padding: EdgeInsets.only(left: 2.0),
                child: CustomText(text: 'Please Enter First Name',color: Colors.white,fontSize: 11,),):Container(),
              SizedBox(height: 24.0,),
              CustomText(text: "Sur Name / Last Name",fontSize: 14.0,color: ColorResources.whiteColor,),
              SizedBox(height: 15.0,),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: CustomTextField(
                    controller: _lastName,
                    hintText: 'Sur Name / Last Name',
                    fontSize: 14.0,
                    textInputType: TextInputType.text,
                    borderRadius: 29
                ),
              ),
              SizedBox(height: 5.0,),
              isValidLastName ?Container(
                padding: EdgeInsets.only(left: 2.0),
                child: CustomText(text: 'Please Enter Last Name',color: Colors.white,fontSize: 11,),):Container(),
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
                        if(_firstName.text.isNotEmpty && _lastName.text.isNotEmpty)
                          {
                            Navigator.push(context, PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ChooseDateScreen(firstName:_firstName.text.toString(),lastName:_lastName.text.toString(),chooseToStart:widget.chooseToStart,chooseGender:widget.chooseGender)
                            ));
                          }
                        else{
                          setState(() {
                            _firstName.text.isEmpty ?isValidFirstName = true :isValidFirstName = false;
                            _lastName.text.isEmpty ?isValidLastName = true :isValidLastName = false;
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
