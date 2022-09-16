import 'dart:convert';
import 'dart:io';

import 'package:afropeep/models/event_models/event_details_byid.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';

import '../../resouces/constants.dart';
import '../../resouces/functions.dart';
import 'details_event_screen.dart';
import 'edit_event_screen.dart';
import 'event_screen.dart';
import 'joined_event_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  String eventid;
  String eventType;
  EventDetailsScreen({this.eventid,this.eventType});
  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  Dio _dio = Dio();
  BuildContext _mainContex;
  EventDetailsById arrEventDetailsByid =  new EventDetailsById();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
        await getEventDetailsById();
    });
  }
  var eventimg ;
  getEventDetailsById()async{
    Apploader(_mainContex);
    Map params = Map();
    params['eventid'] = widget.eventid.toString();
    await _dio.post(MY_EVENT_BY_ID,data: jsonEncode(params)).then((value) {
      print(value.data);
      if(value.statusCode == 200)
      {
        setState(() {

          arrEventDetailsByid = EventDetailsById.fromJson(value.data);
          eventimg = arrEventDetailsByid.eventImg.toString();
          RemoveAppLoader(_mainContex);
        });

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
                top: 0.0,
                child:Stack(
                  children: [
                   /* Container(
                      child: Image.network(
                        GET_EVENT_IMAGES_LINK+eventimg,
                        height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),*/
                    arrEventDetailsByid.eventImg!=null? Container(
                      child: CachedNetworkImage(
                        imageUrl: GET_EVENT_IMAGES_LINK+arrEventDetailsByid.eventImg,
                        imageBuilder: (context, imageProvider) => Container(
                          height: MediaQuery.of(context).size.height/3,
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
                    ):Container(),
                    Positioned(
                      top: 50.0,
                      child:Padding(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
                        ),
                      ),
                    ),
                    Positioned(
                        top: 50.0,
                        right: 0.0,
                        child:Row(
                          children: [
                            widget.eventType == "myEvent"?GestureDetector(
                              onTap: (){
                                print(widget.eventid);
                                Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child:  EditEventScreen(eventid:widget.eventid)));
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle
                                ),
                                child: Icon(Icons.edit,size: 20,),
                              ),
                            ):Container(),
                            SizedBox(width: 10,),
                            widget.eventType == "myEvent"?GestureDetector(
                              onTap: (){
                                print(widget.eventid);
                                deleteEvent(widget.eventid);
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle
                                ),
                                child: Icon(Icons.delete,size: 20,color: Color(0xffF92626),),
                              ),
                            ):Container(),
                            SizedBox(width: 20,)
                          ],
                        )
                    ),


                  ],
                ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height/3.5,
              left: 0.0,
              right: 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Padding(
                            padding: EdgeInsets.only(left:20,right: 20),
                            child:Column(
                              children: [
                                Column(
                                  children: [
                                    TabBar(
                                      labelColor: ColorResources.primaryColor,
                                      unselectedLabelColor: ColorResources.blackColor,
                                      tabs: [
                                        Tab(
                                          text: "Details",
                                        ),
                                        Tab(text: "Joined"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        height: MediaQuery.of(context).size.height*1.3,

                                        child: TabBarView(children: <Widget>[
                                          //all event tab
                                          DetailsScreen(arrEventDetailsByid:arrEventDetailsByid,eventType:widget.eventType),
                                          // my events tab
                                          JoinedScreen(eventid:arrEventDetailsByid.eventId.toString()),

                                        ]),
                                      ),




                                  ],
                                ),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),
              )
            ),
          ],
        ),
      )
    );
  }
  deleteEvent(String eventid)async{
    Apploader(context);
    var event_id= int.parse(eventid);
    var event_imgage = arrEventDetailsByid.eventImg.toString();
   /* FormData newdata = FormData.fromMap({
      'eventid':event_id,
      'event_img': event_imgage.toString(),
    });*/
    Map params = Map();
    params['eventid'] = event_id;
    params['event_img'] = event_imgage.toString();

    print(params);

    await _dio.post(DELETE_EVENT,data:jsonEncode(params),).then((value)async {
      print("value= ${value}");
      if(value.statusCode == 200)
      {
        print(value);
        print("called");
        // Navigator.of(context).pop();
        RemoveAppLoader(context);
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child:  EventScreen()));
      }
    });
   /* await _dio.post(DELETE_EVENT,data:data,options: Options(contentType: 'multipart/form-data')).then((value)async {
      print(value.data);
      if(value.statusCode == 200)
      {
        RemoveAppLoader(context);
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child:  EventScreen()));
      }
    });*/
  }
}




