import 'dart:convert';
import 'dart:io';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/resouces/functions.dart';
import 'package:afropeep/screens/event_screens/event_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddEventScreen extends StatefulWidget {
  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}


class _AddEventScreenState extends State<AddEventScreen> {
  TextEditingController _eventDate = TextEditingController();
  TextEditingController _eventLocation = TextEditingController();
  TextEditingController _eventabout = TextEditingController();
  TextEditingController _eventName = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = "122344";
  Dio _dio = Dio();
  File imageFile;
  List<File> imageList = [];
  bool visibleEventLocation = false;
  var newlatitude;
  var newlongitude;
  List<Location> locations;
  void onChange(){
    if(_sessionToken == null)
    {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestions(_eventLocation.text);
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
  _getFromGallery() async {
    pickedFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 60,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
      imageList.add(imageFile);
    }
    Navigator.pop(context);
    // params['ptaskattachment'] = await MultipartFile.fromFile(arrImageList[0].path, filename:
  }

  _getFromCamera() async {
    pickedFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 60,
    );
    if (pickedFile != null) {
      setState(() {

        imageFile = pickedFile;
      });
      imageList.add(imageFile);

    }
    Navigator.pop(context);
    // params['ptaskattachment'] = await MultipartFile.fromFile(arrImageList[0].path, filename:
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visibleEventLocation = false;
    _eventLocation.addListener(() {
      onChange();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Add Event',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24,),
              CustomText(text: 'Event Name',),
              SizedBox(height: 15,),
              CustomTextField(controller: _eventName,fontSize: 14,hintText: 'Event Name',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              SizedBox(height: 24,),
              CustomText(text: 'Event date',),
              SizedBox(height: 15,),
              CustomTextField(
                  controller: _eventDate,
                  fontSize: 14,
                  hintText: 'MM/DD/YYYY',
                  borderRadius: 30,
                  enabledBorder: true,
                  focusedBorder: true,

                  iconName: CupertinoIcons.calendar,
                  iconColor: ColorResources.blackColor,
                  onPressed:(){
                    FocusScope.of(context).requestFocus(new FocusNode());
                    CustomDateTimePicker();
                  }),
              SizedBox(height: 24,),
              CustomText(text: 'Event Location',),
              SizedBox(height: 15,),
              CustomTextField(controller: _eventLocation,fontSize: 14,hintText: 'Choose Location',borderRadius: 30,enabledBorder: true,focusedBorder: true,iconName: Icons.location_on_outlined,iconColor: ColorResources.blackColor,onPressed:(){
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
                                      _eventLocation.text = _placesList[index]['description'].toString();
                                      visibleEventLocation = false;
                                      newlongitude = locations.last.longitude;
                                      newlatitude = locations.last.latitude;
                                    });
                                   /* List<Placemark> placemarks = await placemarkFromCoordinates(
                                        locations.last.longitude,
                                        locations.last.latitude
                                    ).then((value) {

                                    });*/
                                    // Placemark place = placemarks[0];


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

              SizedBox(height: 24,),
              CustomText(text: 'About Event',),
              SizedBox(height: 15,),
              CustomTextField(controller: _eventabout,fontSize: 14,hintText: 'Write here',borderRadius: 30,enabledBorder: true,focusedBorder: true,onPressed:(){},maxLines: 5,),
              SizedBox(height: 24,),
              CustomText(text: 'Add Event Image',),
              SizedBox(height: 15,),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                      _pickedImage();
                    },
                    child:  Container(
                      width: MediaQuery.of(context).size.width/3.2,
                      height: 138,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color:ColorResources.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorResources.blackColor)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_rounded,color: ColorResources.primaryColor,size: 25,),
                          CustomText(text: "Take Photo",fontSize: 10.0,color: ColorResources.primaryColor,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/3.2,
                        height: 138,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:ColorResources.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorResources.blackColor)
                        ),
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: imageList.asMap().containsKey(0) ? Image.file(imageList[0],fit: BoxFit.cover,height: 138,width: MediaQuery.of(context).size.width/3.2,):Icon(Icons.add,size:30),
                        ),
                      ),
                      Positioned(
                          top: 7,
                          right: 8,
                          child: InkWell(
                            onTap: (){
                              // print(imageList.removeAt(index));
                              FocusManager.instance.primaryFocus?.unfocus();
                              imageList.removeAt(0);
                              setState((){});
                            },
                            child: ClipOval(
                              child: Material(
                                color: Colors.white, // Button color
                                child: Container(
                                  child:imageList.asMap().containsKey(0) ? Icon(Icons.close,size: 16,):null,),
                              ),
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 24,),
              Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CustomButton(
                      height: 45,
                      backgroundColor: ColorResources.blackColor,
                      onPressed: ()async{
                       addEvent();
                      },
                      buttonText: 'Post',
                      fontSize: 16.0,
                      textColor: ColorResources.whiteColor,
                      width:MediaQuery.of(context).size.width,
                    )
                ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
  var pickedFile ;
  void _pickedImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
          content: Text("Choose image source"),
          actions: [
            CustomButton(
              height: 40,
              width:100,
              backgroundColor: ColorResources.blackColor,
              onPressed: (){
                _getFromCamera();
              },
              buttonText: 'Camera',
              fontSize: 16.0,
              textColor: ColorResources.whiteColor,
              // width:MediaQuery.of(context).size.width,
            ),
            CustomButton(
              height: 40,
              width:100,
              backgroundColor: ColorResources.blackColor,
              onPressed: (){
                _getFromGallery();
              },
              buttonText: 'Gallery',
              fontSize: 16.0,
              textColor: ColorResources.whiteColor,
              // width:MediaQuery.of(context).size.width,
            ),
          ]
      ),
    ).then((ImageSource source) async {
    });
  }
  CustomDateTimePicker()async{
    // initialDate: DateTime.now().subtract(Duration(days: 1)),
    // firstDate: DateTime(1950),
    // //DateTime.now() - not to allow to choose before today.
    // lastDate: DateTime.now().subtract(Duration(days: 1)));
    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      String date =
      DateFormat('dd').format(pickedDate);
      String month =
      DateFormat('MM').format(pickedDate);
      String year =
      DateFormat('yyyy').format(pickedDate);
      // 10/08/2022

      setState(() {
        _eventDate.text = "${date}/${month}/${year}";//set output date to TextField value.
      });
    } else {}
  }
  var  currentAddress;
  addEvent()async{
    FocusManager.instance.primaryFocus?.unfocus();
    print("we are here");
    Apploader(context);
    await getAddressFromLatLng();

    var name = _eventName.text.toString();
    var eventDate = _eventDate.text.toString();
    var eventLatitude= newlatitude;
    var eventLongitude = newlongitude;
    var address = currentAddress.toString();
    var eventabout = _eventabout.text.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userid');


    FormData data = FormData.fromMap({
      "user_id":userid,
      "event_name" :name,
      "event_Date" :eventDate,
      "latitude": eventLatitude,
      "longitude": eventLongitude,
      "address":address,
      "about_event":eventabout,
      "event_img": await MultipartFile.fromFile(
        imageList[0].path,
        filename: imageList[0].path.split('/').last,
      ),
    });
    print(data.fields);
    // var respone =await _dio.post(ADD_EVENT,data:data).catchError((e) => print(e.response.toString()));

    // print(data.files);
    await _dio.post(ADD_EVENT,data:data).then((value) {
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
