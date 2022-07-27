import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  var tmpArray = [];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Notifications',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body:  Padding(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: ScrollPhysics(),

              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){},
                  child: Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 0,right: 10),
                    decoration: BoxDecoration(
                      color: (index == 0 || index == 1) ?ColorResources.primaryColor:ColorResources.whiteColor,
                      border: Border.all(color:(index == 0 || index == 1) ?ColorResources.whiteColor: ColorResources.blackColor,),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Icon(Icons.circle,size: 5,color: (index == 0 || index == 1) ?ColorResources.whiteColor:ColorResources.blackColor,),
                            SizedBox(width: 10,),
                            CustomText(text: 'Lorem ipsum',fontSize: 14,color: (index == 0 || index == 1) ?ColorResources.whiteColor:ColorResources.blackColor,),
                            Spacer(),
                            CustomText(text: '30min ago',fontSize: 12,color: (index == 0 || index == 1) ?ColorResources.whiteColor:ColorResources.blackColor,),
                          ],
                        ),
                        SizedBox(height: 14,),
                        Container(
                         padding: EdgeInsets.only(left: 10,right: 10),
                         child:CustomText(text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ',fontSize: 12,color: (index == 0 || index == 1) ?ColorResources.whiteColor:ColorResources.blackColor,),
                        ),

                      ],
                    ),
                  ),
                );
              }),
        ),
    );
  }

}
