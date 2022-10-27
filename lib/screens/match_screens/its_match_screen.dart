import 'dart:async';

import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:afropeep/screens/match_screens/match_screen.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:math' as math;
import '../../resouces/constants.dart';
import '../../widgets/custom_button.dart';
import '../chat_screens/chat_details_screen.dart';

class ItsMatchScreen extends StatefulWidget {
  String myimage,senderimage;
  ItsMatchScreen({this.myimage,this.senderimage});
  // UserModel userdata;
  @override
  State<ItsMatchScreen> createState() => _ItsMatchScreenState();
}

class _ItsMatchScreenState extends State<ItsMatchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 15), ()async{
      Navigator.of(context).pop();
    },
    );

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ColorResources.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
             height: height/1.65,
             child:  Stack(
               children: [
                 //images
                 Positioned(
                   top: 70,
                   left: 160,
                   child: Transform.rotate(
                     angle: math.pi / 14,
                     child:Container(
                       height: 190,
                       width: 125,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border: Border.all(color: ColorResources.blackColor)
                       ),
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(10.0),
                         child:Image.network(GET_IMAGES_LINK+widget.myimage,fit: BoxFit.cover,),
                       ),
                     ),
                   ),
                 ),
                 Positioned(
                   top: 140,
                   left: 70,
                   child: Transform.rotate(
                     angle: -math.pi / 14,
                     child:Container(
                       height: 190,
                       width: 125,
                       decoration: BoxDecoration(

                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: ColorResources.blackColor)
                       ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),

                        child:Image.network(GET_IMAGES_LINK+widget.senderimage,fit: BoxFit.cover,),
                      ),
                     ),
                   ),
                 ),
                  //heartimage
                 Positioned(
                   top: 47,
                   left: 170,
                   child: Container(
                       padding: EdgeInsets.all(3),
                       height: 34,
                       width: 34,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(100),
                           color: ColorResources.blackColor
                       ),
                       child: Image.network("assets/icons/white_heart.png",height: 27,width: 27,)
                   ),),
                 Positioned(
                     top: 325,
                     left: 80,
                     child: Container(
                         padding: EdgeInsets.all(3),
                         height: 34,
                         width: 34,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(100),
                             color: ColorResources.blackColor
                         ),
                         child: Image.asset("assets/icons/white_heart.png",height: 27,width: 27,)
                     )
                 ),

                //black_star left
                 Positioned(
                     top: 75,
                     left: 120,
                     child: Container(
                         padding: EdgeInsets.all(3),
                         height: 38,
                         width: 39,
                         child: Image.asset("assets/icons/black_star.png",height: 38,width: 39,)
                     )
                   /*child: CircleAvatar(
                     backgroundColor: Colors.black,
                     radius: 15,
                     child: Image.asset("assets/icons/white_heart.png",height: 18,width: 10,)
                   ),*/
                 ),
                 Positioned(
                   top: 110,
                   left: 115,
                   child: Container(
                       padding: EdgeInsets.all(3),
                       height: 18,
                       width: 18,
                       child: Image.asset("assets/icons/black_star.png",height: 18,width: 18,)
                   ),
                 ),
                 Positioned(
                   top: 240,
                   left: 50,
                   child: Container(
                       padding: EdgeInsets.all(3),
                       height: 18,
                       width: 18,
                       child: Image.asset("assets/icons/black_star.png",height: 18,width: 18,)
                   ),
                 ),

                 //black_star bottom
                 Positioned(
                     top: 330,
                     left: 170,
                     child: Container(
                         padding: EdgeInsets.all(3),
                         height: 20,
                         width: 20,
                         child: Image.asset("assets/icons/black_star.png",height: 20,width: 20,)
                     )
                   /*child: CircleAvatar(
                     backgroundColor: Colors.black,
                     radius: 15,
                     child: Image.asset("assets/icons/white_heart.png",height: 18,width: 10,)
                   ),*/
                 ),
                 Positioned(
                   top: 270,
                   left: 210,
                   child: Container(
                       padding: EdgeInsets.all(3),
                       height: 22,
                       width: 22,
                       child: Image.asset("assets/icons/black_star.png",height: 22,width: 22,)
                   ),
                 ),

                 //rightside star
                 Positioned(
                   top: 300,
                   left: 255,
                   child: Container(
                       padding: EdgeInsets.all(3),
                       height: 34,
                       width: 34,
                       child: Image.asset("assets/icons/black_star.png",height: 34,width: 34,)
                   ),
                 ),
                 Positioned(
                   top: 160,
                   left: 290,
                   child: Container(
                       padding: EdgeInsets.all(3),
                       height: 22,
                       width: 22,
                       child: Image.asset("assets/icons/black_star.png",height: 22,width: 22,)
                   ),
                 ),
               ],
             ),
           ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "It's a Match",
                      fontSize: 34,
                      color: Colors.white,
                    ),
                    SizedBox(height: 1.0,),
                    CustomText(
                      text: "Start conversation now with each other",
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    SizedBox(height: height/16,),
                    Container(
                        padding: EdgeInsets.only(left: 49,right: 49),
                        child: CustomButton(
                          height: 45,
                          backgroundColor: ColorResources.blackColor,
                          onPressed: (){
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>ChatDetailsScreen(userData: widget.userdata,)));
                          },
                          buttonText: 'Say Hello',
                          fontSize: 16.0,
                          textColor: ColorResources.whiteColor,
                          width:MediaQuery.of(context).size.width,
                        )
                    ),
                    SizedBox(height: 16.0,),
                    Container(
                      padding: EdgeInsets.only(left: 49,right: 49),
                      child: CustomButton(
                        height: 45,
                        backgroundColor: ColorResources.whiteColor,
                        onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con)=>HomeScreen()));
                        },
                        buttonText: 'Keep Swiping',
                        fontSize: 16.0,
                        textColor: ColorResources.blackColor,
                        width:MediaQuery.of(context).size.width,
                      ),
                    )
                  ],
                ),
            ),),
          ],
        ),
      ),
    );
  }
}
