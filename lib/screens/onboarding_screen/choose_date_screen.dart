import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';

import 'package:flutter/material.dart';

class ChooseDateScreen extends StatefulWidget {
  @override
  State<ChooseDateScreen> createState() => _ChooseDateScreenState();
}

class _ChooseDateScreenState extends State<ChooseDateScreen> {
  TextEditingController _chooseDate = TextEditingController();
  TextEditingController _chooseMonth = TextEditingController();
  TextEditingController _chooseYear = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "When's your birthday?",fontSize: 22.0,color: ColorResources.whiteColor,),
        SizedBox(height: 27.0,),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Container(
                width: 66,
                height: 44,
                alignment: Alignment.center,
                child: TextField(
                  onTap: (){},
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
                  onTap: (){},
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
                    onTap: (){},
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

        /*Expanded(
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChoosePhotosScreen()));
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