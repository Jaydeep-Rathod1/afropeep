
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChooseYourLocationScreen extends StatefulWidget {
  const ChooseYourLocationScreen({Key key}) : super(key: key);

  @override
  State<ChooseYourLocationScreen> createState() => _ChooseYourLocationScreenState();
}

class _ChooseYourLocationScreenState extends State<ChooseYourLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorResources.primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 47.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child:  InkWell(
                  onTap: (){
                    Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight, child: null,));
                  },
                  child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: CustomText(text: 'Choose your location ',fontSize: 22,color: ColorResources.whiteColor,),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Flexible(
                child: Stack(
                  children: [
                     Image.asset("assets/images/map_image.png",width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,fit: BoxFit.cover,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top:20,left: 15),
                          hintText: 'Enter Address',
                          filled: true,
                          fillColor: ColorResources.whiteColor,
                          prefixIcon: Icon(Icons.my_location,color: ColorResources.blackColor,),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 34,
                      left: 20,
                      right: 20,
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CustomButton(
                          height: 45,
                          backgroundColor: ColorResources.blackColor,
                          onPressed: (){
                            Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: HomeScreen()));
                          },
                          buttonText: 'Save & Continue',
                          fontSize: 16.0,
                          textColor: ColorResources.whiteColor,
                          width:MediaQuery.of(context).size.width,
                        )
                    ),),

                  ],
                ),

            ),

          ],
        ),
    );
  }
}
