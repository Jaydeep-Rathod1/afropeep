import 'dart:convert';
import 'dart:ui';

import 'package:afropeep/models/match_models/get_match_request_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/match_screens/its_match_screen.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:blur/blur.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/match_models/get_match_new_request_model.dart';
import '../../models/user_models/single_user_model.dart';
import '../../resouces/functions.dart';

class MatchScreen extends StatefulWidget {
  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  Dio _dio = Dio();
  List<GetMatchNewRequestModel> arrAllMatchRequest = [];
  BuildContext _mainContex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
// print(GetAddressFromLatLong(21.211739698046472, 72.78160081534332).runtimeType);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Apploader(_mainContex);
      await getSingleUserDetails();
      await getMatchList();
      // RemoveAppLoader(_mainContex);
    });
  }
  getMatchList()async{
    // Apploader(context);
    // Apploader(_mainContex);
    setState(() {
      arrAllMatchRequest = [];
    });
    Map params = Map();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid =prefs.getInt('userid');
    print(userid);
    params['userid'] = userid;
    await _dio.post(GET_MATCH_LIST,data: jsonEncode(params)).then((value) {
      var varJson = value.data as List;
      print(varJson.length);
      if(value.statusCode == 200)
      {
        // RemoveAppLoader(_mainContex);
        print(value.data);
       if(mounted){
         print("called if");
         setState(() {
           arrAllMatchRequest =varJson.map((e) =>GetMatchNewRequestModel.fromJson(e)).toList();
         });

       }

      }
    });
  }
  var photourlmain;
  getSingleUserDetails()async{

    Map params = Map();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid =prefs.getInt('userid');
    print("userid = ${userid}");
    params['userid'] = userid;
    await _dio.post(GET_USER_BY_ID,data: jsonEncode(params)).then((value)async {
      print("value = ${value}");
      // final coordinates = new Coordinates(
      //     myLocation.latitude, myLocation.longitude);
      // var addresses = await Geocoder.local.findAddressesFromCoordinates(
      //     coordinates);
      // var first = addresses.first;

      if(value.statusCode == 200)
      {
        setState(() {
          SingleUserModel arrAllMyUser =SingleUserModel.fromJson(value.data[0]);
          photourlmain = arrAllMyUser.photoUrl1;

        });

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:20,right: 20,top: 20,bottom: 0.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
        itemCount: arrAllMatchRequest.length,
        itemBuilder: (BuildContext context,index){
          return  Container(
            height: 180,
            width: 190,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:arrAllMatchRequest[index].photoUrl1 != null? NetworkImage(GET_IMAGES_LINK+arrAllMatchRequest[index].photoUrl1):AssetImage('assets/icons/img_user.png'),

                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:10.0,right: 10.0),
                  child: CustomText(text: '${arrAllMatchRequest[index].firstName},${arrAllMatchRequest[index].lastName != null ?arrAllMatchRequest[index].lastName:0}',color: ColorResources.whiteColor,fontSize: 12,),
                ),
                SizedBox(height: 2,),
                Padding(
                    padding: EdgeInsets.only(left:10.0,right: 8.0),
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined,size: 12.0,color: ColorResources.whiteColor,),
                        SizedBox(width: 5.0,),
                        /*CustomText(
                          text: '${arrAllMatchRequest[index].address != null ?arrAllMatchRequest[index].address:""} '
                          ,fontSize: 10.0,
                          color: ColorResources.whiteColor,

                        ),*/
                        Expanded(
                            child:  Text(
                          '${arrAllMatchRequest[index].address != null ?arrAllMatchRequest[index].address:""} ',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10.0,
                            color: Colors.white
                          ),
                        ))
                        // GetAddressFromLatLong(21.211739698046472, 72.78160081534332),
                      ],
                    )
                ),
                SizedBox(height: 5.0,),
                Padding(
                  padding: EdgeInsets.only(left:0,right: 0),
                  child:  Container(
                    height: 40.0,
                    width: MediaQuery.of(context).size.width/2.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white10.withAlpha(80)),
                      borderRadius: BorderRadius.only(
                        bottomRight: const Radius.circular(10.0),
                        bottomLeft: const Radius.circular(10.0),
                      ),
                    ),
                  ).blurred(
                    colorOpacity: 0.2,
                    borderRadius: BorderRadius.only(
                      bottomRight: const Radius.circular(10.0),
                      bottomLeft: const Radius.circular(10.0),
                    ),
                    blur: 2.5,
                    overlay:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()async{
                            var senderimage =arrAllMatchRequest[index].photoUrl1;
                            var myimage = photourlmain;
                            var requestid = arrAllMatchRequest[index].reqId;
                            print(requestid);
                            Map params = Map();
                            params['requestid'] =requestid ;
                            params['status'] = "like";
                            await _dio.post(REQUEST_REJECT_MATCH,data: jsonEncode(params)).then((value)async {
                              if(value.statusCode == 200)
                              {
                                await getMatchList();
                              }
                            }).then((value) {
                              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ItsMatchScreen(senderimage:senderimage,myimage:myimage)));
                              // implementation platform('com.google.firebase:firebase-bom:30.3.2')
                            });
                          },
                          child:Align(
                            alignment: Alignment.center,
                            child: Image.asset('assets/icons/white_heart.png',height: 20,width: 25,),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.all(10),
                          child: VerticalDivider(
                            color: ColorResources.whiteColor,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: ()async{
                            var requestid = arrAllMatchRequest[index].reqId;
                            print(requestid);
                            Map params = Map();
                            params['requestid'] =requestid ;
                            params['status'] = "dislike";

                            await _dio.post(REQUEST_REJECT_MATCH,data: jsonEncode(params)).then((value)async {
                              if(value.statusCode == 200)
                                {
                                  await getMatchList();
                                }
                            });
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset('assets/icons/close_icon.png',height: 20,width: 25,),
                          ),
                        )
                      ],
                    ),
                  ),),
              ],
            ),
          );
        },
      ),
    );
  }
  GetAddressFromLatLong(latitude,longitude)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    print(placemarks);
    Placemark place = placemarks[0];
     var Address = await '${place.subLocality}, ${place.locality}';
    return CustomText(text: Address,fontSize: 10.0,color: ColorResources.whiteColor,);
  }
}
