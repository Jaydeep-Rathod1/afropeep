import 'dart:convert';

import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/user_models/country_model.dart';
import '../../models/user_models/modetostart_model.dart';
import '../../models/user_models/single_user_model.dart';
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
  // String dropdownvalue = 'Choose Natonality';
  CountryModel dropdownvalue;
  TextEditingController _nationalityTxt = TextEditingController();
  TextEditingController _distancetxt = TextEditingController();
  BuildContext _mainContext;
  // List of items in our dropdown menu
  bool visibleEventLocation = false;
  var newlatitude;
  var newlongitude;
  var uuid = Uuid();
  String _sessionToken = "122344";
  List<Location> locations;
  void onChange(){
    if(_sessionToken == null)
    {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestions(_distancetxt.text);
  }
  List _placesList =[];
  getSuggestions(String input)async{
    String kPLACES_API_KEY = "AIzaSyAj1U4NV784fzjvERjGzevCpjKzeJQkQyk";
    String base_url = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$base_url?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken";
    var response = await _dio.get(request);
    print(response.data['predictions']);

    if(response.statusCode == 200)
    {
      setState(() {
        _placesList = response.data['predictions'];
      });
    }
    else{
      throw Exception("Failed");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContext = this.context;
    visibleEventLocation = false;
    _distancetxt.addListener(() {
      onChange();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getSingleUserDetails();
     await  getModeToStartList();
      await getCountryCode();
    });
  }

  SingleUserModel arrAllUser;
  getSingleUserDetails()async{
    Apploader(context);
    Map params = Map();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid =prefs.getInt('userid');
    print("userid = ${userid}");
    params['userid'] = userid;
    await _dio.post(GET_USER_BY_ID,data: jsonEncode(params)).then((value)async {
      print("value = ${value}");
      if(value.statusCode == 200)
      {
        setState(() {
          arrAllUser =SingleUserModel.fromJson(value.data[0]);
          RemoveAppLoader(context);
        });

      }
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
  List<CountryModel> getData = [];
  List<CountryModel> arrAllCountryList = [];
  List<CountryModel> arrCountryList = [];
  getCountryCode()async {
    print("called");
    Apploader(context);

    await _dio.get(GET_COUNTRY).then((value) {

      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrAllCountryList =varJson.map((e) =>CountryModel.fromJson(e)).toList();
          RemoveAppLoader(context);
          dropdownvalue = arrAllCountryList[0];
        });
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
          GestureDetector(
            onTap: (){
              getFilteredUser();
            },
            child: Padding(
              padding:EdgeInsets.only(top:20,right: 20),
              child: Text('Reset',style: TextStyle(fontSize: 14, decoration: TextDecoration.underline,),),
            ),
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
              CustomTextField(controller: _distancetxt,fontSize: 14,hintText: 'Choose Location',borderRadius: 30,enabledBorder: true,focusedBorder: true,iconName: Icons.location_on_outlined,iconColor: ColorResources.blackColor,onPressed:(){
                setState(() {
                  visibleEventLocation = true;
                });
              }),
              Visibility(
                  visible: visibleEventLocation,
                  child: Container(
                    height: 150,
                    width: 300,
                    child: Card(
                        child: ListView.builder(
                            itemCount: _placesList.length,
                            padding: EdgeInsets.all(10),
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: ()async{
                                  // List<Location> locations = await
                                  locations = await locationFromAddress(_placesList[index]['description']);
                                  print(locations.last.longitude);
                                  print(locations.last.latitude);
                                  print(locations.toString());
                                  setState(() {
                                    _distancetxt.text = _placesList[index]['description'].toString();
                                    visibleEventLocation = false;
                                    newlongitude = locations.last.longitude;
                                    newlatitude = locations.last.latitude;
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(_placesList[index]['description']),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              );
                            })
                    ),
                  )),
              SizedBox(height: 20,),
              CustomText(text: 'Nationality',fontSize: 12,),
              SizedBox(height: 17,),
              /*CustomTextField(controller: _nationalityTxt,fontSize: 14,hintText: 'Enter Nationality',borderRadius: 30,enabledBorder: true,focusedBorder: true,),*/
              Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
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
                          child: Text("${value.countryName}  ",overflow: TextOverflow.ellipsis,),
                        );
                      }).toList(),
                      onChanged: (CountryModel newValue) {
                        setState(() {
                          dropdownvalue = newValue;
                        });
                      },
                    ),)
              ),
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

  var  currentAddress;
  getFilteredUser()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userlat =prefs.getString('userLattitude');
    var userlong = prefs.getString('userLongitude');
    var datewho = value;
    var kmnew = km.round();
    var minage =low.round();
    var maxage =high.round() == 18? null:high.round();
    var nationality = dropdownvalue.countryId;
    var mylatitude =arrAllUser.lattitude;
    var mylongitude=arrAllUser.longitude;
    var distancelatitude=newlatitude;
    var distancelongitude=newlongitude;
    var userid =prefs.getInt('userid').toString();
    print(datewho);
    print("nationality = ${nationality}");
    print("minage = ${minage}");
    print("maxage = ${maxage}");
    print("mylat = ${mylatitude}");
    print("mylong = ${mylongitude}");
    print("dislat = ${distancelatitude}");
    print("dislong = ${distancelongitude}");
    var isfilter= true;
    Provider.of<CardProvider>(context, listen: false).getCardImages(datewho,kmnew,minage,maxage,nationality.toString(),mylatitude!=null?double.parse(mylatitude):0.0,mylongitude !=null?double.parse(mylongitude):0.0,distancelatitude,distancelongitude,isfilter).then((value){
      Navigator.push(context,PageTransition(type: PageTransitionType.rightToLeft, child:  HomeScreen()));
    });
  }
  getAddressFromLatLng() async {
    if(newlatitude != null && newlongitude != null)
    {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          newlatitude,
          newlongitude
      );
      Placemark place = placemarks[0];
      setState(() {
        currentAddress = "${place.locality}, ${place.subLocality}";
      });
    }
  }
}
