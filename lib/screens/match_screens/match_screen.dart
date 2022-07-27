import 'dart:ui';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class MatchScreen extends StatefulWidget {
  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:20,right: 20,top: 20,bottom: 0.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children: List.generate(15, (index) {
          return  Container(
            height: 180,
            width: 190,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/match_1.png'),
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
                  child: CustomText(text: 'Elizabeth Olsen, 25',color: ColorResources.whiteColor,fontSize: 12,),
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
                      CustomText(text: 'Ottawa, Canada ',fontSize: 10.0,color: ColorResources.whiteColor,),

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
                     Align(
                       alignment: Alignment.center,
                       child: Image.asset('assets/icons/white_heart.png',height: 20,width: 25,),
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
                     Align(
                       alignment: Alignment.center,
                       child: Image.asset('assets/icons/close_icon.png',height: 20,width: 25,),
                     ),
                   ],
                 ),
               ),),
              ],
            ),
            /*Container(
              height: 40,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Center(
                  child: Card(
                    elevation: 10,
                    color: Colors.black.withOpacity(0.5),
                    child: const SizedBox(
                      width: 300,
                      height: 200,
                      child: Center(
                        child: Text(
                          'Some Text',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),*/

          );
        },),
      ),
    );
  }
}
