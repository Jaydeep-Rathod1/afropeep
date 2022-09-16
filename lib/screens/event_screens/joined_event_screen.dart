
import 'dart:convert';

import 'package:afropeep/models/event_models/joined_event_model.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/resouces/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../resouces/color_resources.dart';
import '../../widgets/custom_text.dart';

class JoinedScreen extends StatefulWidget {
  String eventid;
  JoinedScreen({this.eventid});
  @override
  State<JoinedScreen> createState() => _JoinedScreenState();
}

class _JoinedScreenState extends State<JoinedScreen> {
  List<JoinedEventDetailsModel> arrAllJoinedEventList = [];
  List<JoinedEventDetailsModel> arrJoinedEventList = [];
  List<JoinedEventDetailsModel> arrRevJoinedEventList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getJoinedUserDetails();
    });

  }
  getJoinedUserDetails()async{
    Apploader(context);
    Dio _dio = Dio();
    Map<String, String> params = Map();
    params['eventid'] = widget.eventid;

    await _dio.post(JOIN_EVENT_DETAILS,data:jsonEncode(params)).then((value)async {
      print(value.statusCode);
      print(value.data);
      if(value.statusCode == 500){
        setState(() {
          RemoveAppLoader(context);
        });
      }
      if(value.statusCode == 200)
      {
        var varJson = value.data as List;
        if(varJson.isNotEmpty)
        {
          setState(() {
            arrRevJoinedEventList =varJson.map((e) =>JoinedEventDetailsModel.fromJson(e)).toList();
            arrAllJoinedEventList= arrRevJoinedEventList.reversed.toList();
            RemoveAppLoader(context);
          });
        }
        else{
          setState(() {
            RemoveAppLoader(context);
          });
        }
      }


    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(text: 'Joined : ${arrAllJoinedEventList.length} ',),
          Expanded(
            child:arrAllJoinedEventList.length>0? ListView.builder(
                itemCount: arrAllJoinedEventList.length,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: [
                      Divider(),
                         Row(
                            children: [

                              Container(
                                height:40,
                                width:40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child:  Image.network( GET_IMAGES_LINK+arrAllJoinedEventList[index].photoUrl1,height: 40,fit: BoxFit.cover,),
                                ),
                              ),
                             /* CachedNetworkImage(
                                imageUrl:arrAllJoinedEventList[index].photoUrl1!= null? GET_IMAGES_LINK+arrAllJoinedEventList[index].photoUrl1:"",
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 40,
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
                              ),*/
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomText(text: "  ${arrAllJoinedEventList[index].firstname != null?arrAllJoinedEventList[index].firstname:""} ${arrAllJoinedEventList[index].lastname != null?arrAllJoinedEventList[index].lastname:""}",fontSize: 14,),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,size: 10,),
                                      CustomText(text: '${arrAllJoinedEventList[index].address != null ?arrAllJoinedEventList[index].address:""}',fontSize: 8,)
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),

                                  ],
                  );
                }
            ):Container(),
          ),
        ],
      ),
    );
  }
}