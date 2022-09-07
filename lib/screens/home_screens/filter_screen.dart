import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_models/modetostart_model.dart';
import '../../provider/card_provider.dart';
import '../../resouces/functions.dart';
import '../../widgets/custom_textfield.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Dio _dio = Dio();
  String value;
  static const min = 18.0;
  static const max = 26.0;
  double low = 18.0;
  double high = 18.0;
  double km = 10;
  String dropdownvalue = 'Choose Natonality';
  TextEditingController _nationalityTxt = TextEditingController();
  BuildContext _mainContext;
  // List of items in our dropdown menu


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContext = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        getModeToStartList();
      });
    });
  }
  List<ModeToStartModel> arrAllModeToStartList = [];
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
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Filters',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        actions: [
          Padding(
            padding:EdgeInsets.only(top:20,right: 20),
            child: Text('Reset',style: TextStyle(fontSize: 14, decoration: TextDecoration.underline,),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(text: 'Who you want to date',fontSize: 12,),
              SizedBox(height: 17,),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1,color: Color(0xffABABAB)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: [
                     ...arrAllModeToStartList.map((e) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                            setState(() {
                              value = e.modeId.toString();
                            });
                          },
                           child: Padding(
                           padding: EdgeInsets.only(left:10,right: 10,top: 10),
                           child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                           CustomText(text: e.modeName,fontSize: 14,),
                           value == e.modeId.toString()? Icon(Icons.check_circle ,color: Colors.black,) :Icon(Icons.circle_outlined ,color: Colors.black,),
                           ],
                           ),
                           )
                           // child: ListTile(
                           //   title: Text('Men'),
                           //   trailing:
                           //   value == 'Men'? Icon(Icons.check_circle ,color: Colors.black,) :Icon(Icons.circle_outlined ,color: Colors.black,),
                           // ),
                           ),
                            e.modeId != 3? Padding(
                                padding: EdgeInsets.only(left:10,right: 10),
                                child:Divider()
                            ):Padding(
                                padding: EdgeInsets.only(bottom:10),

                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                )
              ),

              SizedBox(height: 20,),
              CustomText(text: 'Age',fontSize: 12,),
              SizedBox(height: 17,),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1,color: Color(0xffABABAB)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left:10),
                          child:CustomText(text: 'Age Between 18 to 26  ',fontSize: 12,),),
                        RangeSlider(
                          min: min,
                          max: max,
                          activeColor: ColorResources.primaryColor,
                          inactiveColor: Color(0xffABABAB),
                          values: RangeValues(low, high),
                          onChanged: (values) => setState((){
                            low = values.start;
                            high = values.end;
                          }),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 20,),
              CustomText(text: 'Distance',fontSize: 12,),
              SizedBox(height: 17,),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1,color: Color(0xffABABAB)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.only(left:10),
                        child:CustomText(text: 'Up to 26Km ',fontSize: 12,),),
                        Slider(
                          label: "Select Km",
                          value: km,
                          onChanged: (value) {
                            setState(() {
                              km = value;
                            });
                          },
                          min: 5,
                          max: 100,
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 20,),
              /* Container(
                 height: 40,
                 width: MediaQuery.of(context).size.width,
                 padding: EdgeInsets.only(left: 20,right: 10),
                 decoration: BoxDecoration(
                   border: Border.all(color: Color(0xff757575)),
                   borderRadius: BorderRadius.circular(29)
                 ),
                 child: DropdownButtonHideUnderline(
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
                   ),
                 ),
               ),*/
              CustomTextField(controller: _nationalityTxt,fontSize: 14,hintText: 'Enter Nationality',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),

        bottomNavigationBar:Container(
          height:60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75)
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child:   Container(
              width: 66,
              color: Colors.white,
              padding: EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
              child:CustomButton(
                height: 45,
                fontSize: 16,
                width: MediaQuery.of(context).size.width,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  getFilteredUser();
                },
                buttonText: 'Apply',
              ),
            ),
          ),
        )
    );
  }
  List<UserModel> arrAllCountryList= [];
  getFilteredUser()async {
    var datewho = value;
    var kmnew = km.round();
    var minage =low.round();
    var maxage =high.round();
    var nationality = _nationalityTxt.text.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid =prefs.getInt('userid').toString();
    print(datewho);
    print(kmnew);
    print(minage);
    print(maxage);
    var isfilter= true;
    Provider.of<CardProvider>(context, listen: false).getCardImages(datewho,kmnew,minage,maxage,nationality,isfilter).then((value){
      Navigator.push(context,PageTransition(type: PageTransitionType.rightToLeft, child:  HomeScreen()));
    });
  }
}
