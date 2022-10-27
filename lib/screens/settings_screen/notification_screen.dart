import 'dart:convert';

import 'package:afropeep/models/user_models/notification_list_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/settings_models/SubscriptionModel.dart';
import '../../resouces/constants.dart';
import '../../resouces/functions.dart';

class NotificationScreen extends StatefulWidget {

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
Dio _dio = Dio();
  var tmpArray = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("called");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getotificationList();

    });

  }
  var userid;
List<NotificationListModel> arrNotificationList = [];
  getotificationList()async{
    Apploader(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    Map params = Map();
    params['userid'] = userid;
    await _dio.post(NOTIFICATION_LIST,data: jsonEncode(params)).then((value) {
      print(value.data);
      var varJson = value.data as List;
      if(value.statusCode == 200)
      {
        setState(() {
          arrNotificationList =varJson.map((e) =>NotificationListModel.fromJson(e)).toList();
        });
        RemoveAppLoader(context);
      }
    });

  }
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
              itemCount: arrNotificationList.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),

              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){},
                  child: Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 0,right: 10),
                    decoration: BoxDecoration(
                      // color: (index == 0 || index == 1) ?ColorResources.primaryColor:ColorResources.whiteColor,
                      // border: Border.all(color:(index == 0 || index == 1) ?ColorResources.whiteColor: ColorResources.blackColor,),
                        color: ColorResources.primaryColor,
                        border: Border.all(color: ColorResources.primaryColor,),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                       /* Row(
                          children: [
                            SizedBox(width: 10,),
                            // Icon(Icons.circle,size: 5,color: (index == 0 || index == 1) ?ColorResources.whiteColor:ColorResources.blackColor,),
                            // SizedBox(width: 10,),
                            // CustomText(text: arrNotificationList[index].message,fontSize: 14,color: (index == 0 || index == 1) ?ColorResources.whiteColor:ColorResources.blackColor,),
                            Spacer(),
                            // CustomText(text: '30min ago',fontSize: 12,color: (index == 0 || index == 1) ?ColorResources.whiteColor:ColorResources.blackColor,),
                          ],
                        ),*/
                        // SizedBox(height: 14,),
                        Container(
                         padding: EdgeInsets.only(left: 10,right: 10),
                         child:CustomText(text: arrNotificationList[index].message,fontSize: 12,color: ColorResources.whiteColor,),
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
