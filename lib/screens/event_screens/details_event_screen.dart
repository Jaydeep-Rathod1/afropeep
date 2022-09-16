
import 'dart:convert';

import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:afropeep/screens/survey/questions_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/event_models/event_details_byid.dart';
import '../../resouces/color_resources.dart';
import '../../resouces/constants.dart';
import '../../widgets/custom_text.dart';


class DetailsScreen extends StatefulWidget {
  EventDetailsById arrEventDetailsByid;
  String eventType;
  DetailsScreen({this.arrEventDetailsByid,this.eventType});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
   LatLng showLocation;
  var userid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("called");
      await getUserid();
      await setLatLong();

    });

  }
  setLatLong()async{
    print(widget.arrEventDetailsByid.latitude);
    print(widget.arrEventDetailsByid.longitude);
    showLocation =   LatLng(double.parse(widget.arrEventDetailsByid.latitude), double.parse(widget.arrEventDetailsByid.longitude));
  }
  getUserid()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    print("user = ${userid}");
  }
  @override
  Widget build(BuildContext context) {
    return   IgnorePointer(
          ignoring: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.arrEventDetailsByid.eventName!=null?CustomText(text: widget.arrEventDetailsByid.eventName,fontSize: 20,fontWeight: FontWeight.w700,color: ColorResources.blackColor,letterSpacing: true,):Container(),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width/0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ColorResources.primaryColor)
                ),
                padding: EdgeInsets.all(10),
                child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Container(
                        padding:EdgeInsets.only(left:10,right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/icons/calender_icon.png',color: ColorResources.primaryColor,width: 12,height: 12,),
                                SizedBox(width: 10,),
                                CustomText(text: 'Event Date',color: ColorResources.primaryColor,fontSize: 12,)
                              ],
                            ),
                            widget.arrEventDetailsByid.eventDate!=null? CustomText(text: widget.arrEventDetailsByid.eventDate,fontSize: 14,):Container(),
                          ],
                        ),
                      ),
                      Container(
                        height: 90,
                        padding: const EdgeInsets.all(10),
                        child: VerticalDivider(
                          color: ColorResources.blackColor,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          width: 10,
                        ),
                      ),
                      Container(
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,color: ColorResources.primaryColor,size: 15),
                                  SizedBox(width: 8,),
                                  CustomText(text: 'Event Location',color: ColorResources.primaryColor,fontSize: 12,)
                                ],
                              ),

                              widget.arrEventDetailsByid.event_address!=null? Container(

                                child: Text(
                                  widget.arrEventDetailsByid.event_address,
                                  textAlign: TextAlign.center,
                                  // overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ):Container(),


                            ],
                          ),
                        )
                      )
                    ],
                  ),

              ),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              CustomText(text: 'About Event',fontSize: 16,fontWeight: FontWeight.w700,color: ColorResources.blackColor,letterSpacing: true,),
              SizedBox(height: 10,),
              widget.arrEventDetailsByid.aboutEvent!= null?Container(
                child: CustomText(text:  widget.arrEventDetailsByid.aboutEvent,),
              ):Container(),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              CustomText(text: 'Host By',fontSize: 16,fontWeight: FontWeight.w700,color: ColorResources.blackColor,letterSpacing: true,),
              SizedBox(height: 14,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffF3F3F3))
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    widget.arrEventDetailsByid.photoUrl1!=null?
                Container(
                  height:40,
                  width:40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child:  Image.network( GET_IMAGES_LINK+widget.arrEventDetailsByid.photoUrl1,height: 40,fit: BoxFit.cover,),
                  ),
                ):Container(),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/1.6,
                          child: Wrap(
                            children: [
                              widget.arrEventDetailsByid.firstname!=null? CustomText(text:  widget.arrEventDetailsByid.firstname + " " +widget.arrEventDetailsByid.lastname,fontSize: 14,):Container(),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,size: 10,),
                            CustomText(text:  widget.arrEventDetailsByid.address != null ?widget.arrEventDetailsByid.address:"",fontSize: 8,)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(3),
                child: GoogleMap( //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition( //innital position in map
                    target: showLocation, //initial position
                    zoom: 15.0, //initial zoom level
                  ),
                  markers: getmarkers(), //markers to show on map
                  mapType: MapType.normal, //map type
                  onMapCreated: (controller) { //method called when map is created
                    setState(() {
                      mapController = controller;
                    });
                  },
                ),
              ),
              // Image.asset('assets/images/map_2.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height/3.5,fit: BoxFit.cover,),
              SizedBox(height: 30,),
              userid == widget.arrEventDetailsByid.userId
                  ?widget.eventType == "allEvent"? Container():Container()
                  :widget.eventType == "allEvent"? Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CustomButton(
                    height: 45,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: () async{
                      print("called");
                      var eventid = widget.arrEventDetailsByid.eventId.toString();
                      print(eventid);
                      print(userid);
                      await insertEventJoinedData(eventid,userid.toString());
                    },
                    buttonText: 'JOIN',
                    fontSize: 16.0,
                    textColor: ColorResources.whiteColor,
                    width:MediaQuery.of(context).size.width,
                  )
              ):Container(),
            ],
          ),
        );
  }
  insertEventJoinedData(String event_id,String user_id)async{
    Dio _dio = Dio();
    Map<String, String> params = Map();
    params['eventid'] = event_id;
    params['userid'] = user_id;
    await _dio.post(JOIN_EVENT,data:jsonEncode(params)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
      Fluttertoast.showToast(
          msg: "${"Joined Event"}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorResources.primaryColor,
          textColor: ColorResources.whiteColor,
          fontSize: 16.0
      );
    });
  }
  Set<Marker> getmarkers() { //markers to place on map
    setState(() {
      markers.add(Marker( //add first marker
        markerId: MarkerId(showLocation.toString()),
        position: showLocation, //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Marker Title First ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker( //add second marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(27.7099116, 85.3132343), //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Marker Title Second ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker( //add third marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(27.7137735, 85.315626), //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Marker Title Third ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }
}