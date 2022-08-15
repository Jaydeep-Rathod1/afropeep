
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/choose_your_location_screen.dart';
import 'package:afropeep/screens/facial_recognition_screen.dart';
import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';

class CongratulationScreen extends StatefulWidget {

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {

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
                     onPressed: (){
                       // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChooseYourLocationScreen()));
                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));

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
  final geolocator =
  Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  Position _currentPosition;
  String currentAddress = "";
  /*void getCurrentLocation() {
    if(Geolocator.requestPermission)
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }*/
  void getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];

      setState(() {
        currentAddress =
        "${place.thoroughfare},${place.subThoroughfare},${place.name}, ${place.subLocality}";
      });
    } catch (e) {
      print(e);
    }
  }
}
