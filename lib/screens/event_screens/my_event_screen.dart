import 'package:afropeep/models/event_models/event_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/event_screens/event_details_screen.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyEventScreen extends StatefulWidget {

  @override
  State<MyEventScreen> createState() => _MyEventScreenState();
}

class _MyEventScreenState extends State<MyEventScreen> {
  List<EventModel> arrAllMyEventList = [];
  List<EventModel> arrMyEventList = [];
  Dio _dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMyEventList();
  }
  getMyEventList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');
    print("user = ${userid}");
    await _dio.post(MY_EVENT,data: {'userid':userid}).then((value) {
      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrAllMyEventList =varJson.map((e) =>EventModel.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height, //height of TabBarView
      child: Column(
        children: [
          Expanded(
            child:ListView.builder(
                itemCount: arrAllMyEventList.length,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventDetailsScreen()));
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/event_4.png',
                                    height: MediaQuery.of(context).size.height/4.5,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                )
                            ),
                            Positioned(
                              bottom: 0.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 25,),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomText(text:arrAllMyEventList[index].eventName,fontSize: 14,color: ColorResources.whiteColor,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/icons/calender_icon.png',color: ColorResources.whiteColor,width: 11, fit: BoxFit.cover,),
                                        SizedBox(width: 4.0,),
                                        CustomText(text:arrAllMyEventList[index].eventDate,fontSize: 10,color: ColorResources.whiteColor,),
                                        SizedBox(width: 22.0,),
                                        Icon(Icons.location_on_outlined,color: ColorResources.whiteColor,size: 11,),
                                        SizedBox(width: 4.0,),
                                        CustomText(text:arrAllMyEventList[index].longitude,fontSize: 10,color: ColorResources.whiteColor,),
                                      ],
                                    ),
                                    SizedBox(height: 13.0,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0,),
                    ],
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}