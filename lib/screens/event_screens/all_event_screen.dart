

import 'package:afropeep/models/event_models/event_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/event_screens/event_details_screen.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../resouces/functions.dart';

class AllEventScreen extends StatefulWidget {

  @override
  State<AllEventScreen> createState() => _AllEventScreenState();
}

class _AllEventScreenState extends State<AllEventScreen> {
  List<EventModel> arrAllEventList = [];
  List<EventModel> arrEventList = [];
  List<EventModel> arrRevAllEventList = [];
  Dio _dio = Dio();
  BuildContext _mainContex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("called");
      getAllEventList();
    });
  }
  getAllEventList() async{
    Apploader(_mainContex);
    await _dio.get(ALL_EVENT).then((value) {
      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrRevAllEventList =varJson.map((e) =>EventModel.fromJson(e)).toList();
          arrAllEventList =arrRevAllEventList.reversed.toList();
          RemoveAppLoader(_mainContex);
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height/1.32,
        child: ListView.builder(
            itemCount: arrAllEventList.length,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index){
              return Column(
                children: [
                  GestureDetector(
                    onTap: (){
                     var eventid = arrAllEventList[index].eventId.toString();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventDetailsScreen(eventid:eventid,eventType:"allEvent")));
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              child: CachedNetworkImage(
                                imageUrl: GET_EVENT_IMAGES_LINK+arrAllEventList[index].eventImg,
                                imageBuilder: (context, imageProvider) => Container(
                                  height: MediaQuery.of(context).size.height/4.5,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage( //image size fill
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  child: CircularProgressIndicator(
                                    color: ColorResources.primaryColor,
                                  ), // you can add pre loader iamge as well to show loading.
                                ), //show progress  while loading image
                                errorWidget: (context, url, error) => Image.asset("assets/images/noimage.png"),
                                //show no iamge availalbe image on error laoding
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
                                CustomText(text:arrAllEventList[index].eventName,fontSize: 14,color: ColorResources.whiteColor,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/icons/calender_icon.png',color: ColorResources.whiteColor,width: 11, fit: BoxFit.cover,),
                                    SizedBox(width: 4.0,),
                                    CustomText(text:arrAllEventList[index].eventDate,fontSize: 10,color: ColorResources.whiteColor,),
                                    SizedBox(width: 22.0,),
                                    Icon(Icons.location_on_outlined,color: ColorResources.whiteColor,size: 11,),
                                    SizedBox(width: 4.0,),
                                    CustomText(text:arrAllEventList[index].event_address != null?arrAllEventList[index].event_address:"",fontSize: 10,color: ColorResources.whiteColor,)
                                    // getAddressFromLatLng(arrAllEventList[index].latitude,arrAllEventList[index].longitude),
                                    /* CustomText(text:arrAllEventList[index].longitude,fontSize: 10,color: ColorResources.whiteColor,),*/
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
      )
    );
  }


}
