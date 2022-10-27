
import 'package:afropeep/models/user_models/interestes_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/functions.dart';
import 'package:afropeep/screens/facial_recognition_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resouces/constants.dart';
import '../../widgets/custom_sizedbox.dart';

class ChooseInterestesScreen extends StatefulWidget {

  @override
  State<ChooseInterestesScreen> createState() => _ChooseInterestesScreenState();
}

class _ChooseInterestesScreenState extends State<ChooseInterestesScreen> {

  // List<String> selectedReportList = [];
  int maxSelection;
  List<InterestModel> selectedChoices = [];
  List<InterestModel> arrAllChoices = [];
  Dio _dio = Dio();
  getChoiceData()async {
    Apploader(context);
    await _dio.get(GET_INTERSET).then((value) {
      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrAllChoices =varJson.map((e) =>InterestModel.fromJson(e)).toList();
          RemoveAppLoader(context);
        });
      }
    });
  }
  _buildChoiceList() {
    List<Widget> choices = [];

    arrAllChoices.forEach((InterestModel item) {
      choices.add(
          Container(
            height: 41,
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          backgroundColor: ColorResources.whiteColor,
          label: Text(item.intrestName,style: TextStyle(color: selectedChoices.contains(item)?ColorResources.whiteColor:ColorResources.blackColor),),
          selected: selectedChoices.contains(item),
          selectedColor: ColorResources.blackColor,
          onSelected: (selected) {
            if(selectedChoices.length == (maxSelection  ?? -1) && !selectedChoices.contains(item)) {
              // onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                // onSelectionChanged?.call(selectedChoices);
              });
            }
          },
        ),
      ));
    });
    return choices;
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        getChoiceData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSizedBox(newheight: 47.0,),
            InkWell(
                onTap: (){
                  Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight, child: null,));
                },
                child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
            ),
            CustomSizedBox(newheight: 32.0,),
            CustomText(text: 'Choose Your Interests',fontSize: 22,color: ColorResources.whiteColor,),
            CustomSizedBox(newheight: 18.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Choose at least 6 ',fontSize: 14,color: ColorResources.whiteColor,),
                CustomText(text: '0${selectedChoices.length}/0${arrAllChoices.length}',fontSize: 14,color: ColorResources.whiteColor,),
              ],
            ),
            CustomSizedBox(newheight: 23.0,),
            Wrap(
              children: _buildChoiceList(),
            ),
            CustomSizedBox(newheight: 5.0,),
            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CustomButton(
                    height: 45,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: (){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseDateScreen()));
                      // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: FacialRecognitionScreen()));
                      updateUserData();
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
  var isvalidChoicesNumber = false;
  updateUserData() async{
    List<String> selectedChoicesName =[];
    selectedChoices.forEach((element) {
      selectedChoicesName.add(element.intrestName);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');
    Map<String, String> params = Map();
    params['user_id'] = userid.toString();
    params['intrest'] = selectedChoicesName.toString();
    print(selectedChoices);
    print(params);
    if(selectedChoicesName.length >= 6)
      {
        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: FacialRecognitionScreen(choices:selectedChoicesName.toString())));
        // await _dio.post(UPDATE_USER1,data: params).then((value) {
        //   print("value = ${value}");
        //   if(value.statusCode == 200)
        //   {
        //     Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: FacialRecognitionScreen()));
        //   }
        // });
      }
    else{
      setState(() {
        selectedChoicesName.length <= 6? isvalidChoicesNumber = true : isvalidChoicesNumber = false;
      });
    }

  }
}
