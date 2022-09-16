
import 'dart:convert';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resouces/constants.dart';
import '../../resouces/functions.dart';
import '../home_screens/home_screen.dart';


class CongratulationScreen extends StatefulWidget {

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  var latitude;
  var longitude;
  Dio _dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Apploader(context);
    getLocationAndAddress();
    // RemoveAppLoader(context);
  }
  getLocationAndAddress()async{
    await _determinePosition().then((value) async {
      latitude = value.latitude;
      longitude = value.longitude;
      await getAddressFromLatLng();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorResources.primaryColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 47.0,
              ),
              InkWell(
                  onTap: (){
                    Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight,));
                  },
                  child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
              ),
              Expanded(
                flex: 4,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/congratulationsIcon.png',width: 211,height: 123,),
                  ),
                  SizedBox(height: 19.6,),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(text: 'Congratulations!',fontSize: 20,color: ColorResources.whiteColor,),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: CustomText(text: 'Your survey completed successfully',fontSize: 14,color: ColorResources.whiteColor,),
                  ),
                  SizedBox(height: 10,),
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: CustomText(text: 'Your survey completed successfully ',fontSize: 20,color: ColorResources.whiteColor,),
                  // ),
                ],
              ),),

               Expanded(child: Align(
                   alignment: FractionalOffset.bottomCenter,
                   child: CustomButton(
                     height: 45,
                     backgroundColor: ColorResources.blackColor,
                     onPressed: ()async{
                       // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChooseYourLocationScreen()));
                       SharedPreferences prefs = await SharedPreferences.getInstance();
                       prefs.setBool("isCompleteAllData", true);
                      var userid = prefs.getInt('userid');
                      FormData data = FormData.fromMap({
                        "user_id":userid,
                        'lattitude':longitude,
                        "longitude":latitude,
                        "address":currentAddress,
                        "status" :"yes"
                      });
                      print(longitude);
                      print(latitude);
                       print(data);
                       await _dio.post(UPDATE_USER1,data: data).then((value) {
                         // var varJson = value.data;
                         print("value = ${value}");
                         if(value.statusCode == 200)
                         {
                           prefs.setBool('loginvalid', true);
                           prefs.setBool("isCompleteCongrations",true);
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                         }
                       });

                     },
                     buttonText: 'Lets Swipe',
                     fontSize: 16.0,
                     textColor: ColorResources.whiteColor,
                     width:MediaQuery.of(context).size.width,
                   )
               ),),
                const SizedBox(
                height: 34,
              )
            ],
          ),
        )
    );

  }
  var currentPostion;
  var currentAddress;
  Future<Position> _determinePosition() async {
    //print("Permission block ");
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
       await Geolocator.requestPermission();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // _determinePosition();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // displayDialog(
      //     context,
      //     "Location permissions are permanently denied, we cannot request permissions. You Have To Go to App Seeting And Allow Permission of Location",
      //     '');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(""),
            content: Text("Location permissions are permanently denied, we cannot request permissions. You Have To Go to App Seeting And Allow Permission of Location."),
            actions: [
              TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
              ),
            ],
          );
        },
      );

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("position = ${position}");
    return position;
  }
  getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude,
          longitude
      );

      Placemark place = placemarks[0];

      setState(() {
        currentAddress = "${place.locality}, ${place.subLocality}";
      });
      print("current Address = ${currentAddress}");
    } catch (e) {
      print(e);
    }
  }

}
