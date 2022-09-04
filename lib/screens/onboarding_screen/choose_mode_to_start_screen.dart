
import 'package:afropeep/models/user_models/modetostart_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/resouces/functions.dart';
import 'package:afropeep/screens/onboarding_screen/choose_gender_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class ChooseModeToStart extends StatefulWidget {

  @override
  State<ChooseModeToStart> createState() => _ChooseModeToStartState();
}

class _ChooseModeToStartState extends State<ChooseModeToStart> {
  ModeToStartModel value ;
  bool isSelected = false;
  String selectedvalue ='modetostart';
  List<ModeToStartModel> arrAllModeToStartList = [];
  Dio _dio = Dio();
  bool isValidateModeToStart = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        getModeToStartList();
      });
    });
  }
  getModeToStartList()async{
    Apploader(context);
    await _dio.get(GET_MODE).then((value) {
      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrAllModeToStartList =varJson.map((e) =>ModeToStartModel.fromJson(e)).toList();
          RemoveAppLoader(context);
          // dropdownvalue = arrAllCountryList[0];
        });
        print("aal = ${arrAllModeToStartList}");
      }
    });
  }
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
            CustomText(text: 'Choose a mode to start',fontSize: 22,color: ColorResources.whiteColor,),
            SizedBox(height: 30.0,),
            Container(
              child: Column(
                children: [
                  /*arrAllModeToStartList.map((ModeToStartModel mode) {
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          // isSelected = !isSelected;
                          // value = "Friends";
                        });
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 61,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left:30),
                          decoration: BoxDecoration(
                              color: ColorResources.whiteColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: ListTile(
                            title: Text(mode.modeName),
                            trailing: value == 'Friends'? Icon(Icons.check_circle ,color: Colors.black,):Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
                          )
                      ),
                    );
                    // SizedBox(height: 14.0,),
                  } ).toList(),*/
                ]
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/2.0,
              child: ListView.builder(
                  itemCount: arrAllModeToStartList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              // isSelected = !isSelected;
                              value = arrAllModeToStartList[index];
                            });
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 61,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left:30),
                              decoration: BoxDecoration(
                                  color: ColorResources.whiteColor,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: ListTile(
                                title: Text(arrAllModeToStartList[index].modeName),
                                trailing: value == arrAllModeToStartList[index] ? Icon(Icons.check_circle ,color: Colors.black,):Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
                              )
                          ),
                        ),
                        SizedBox(height: 14.0,),
                      ],
                    );
                  }),
            ),
            isValidateModeToStart == true ?
            Container(
              padding: EdgeInsets.only(left: 2.0),
              child: CustomText(text: 'Please Choose Mode To Start',color: Colors.white,fontSize: 11,),):Container(),
            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CustomButton(
                    height: 45,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: (){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChoosePhotosScreen()));
                      if(value != null)
                        {
                          setState(() {
                            isValidateModeToStart = false;
                          });
                          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChooseGenderScreen(chooseToStart:value)));
                        }
                      else{
                        setState(() {
                          isValidateModeToStart = true;
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
        ),
      ),
    );
  }

}



