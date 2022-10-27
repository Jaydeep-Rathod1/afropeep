import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool isSwitchedAllNotification = false;
  bool isSwitchedMatch = false;
  bool isSwitchedEvents = false;
  bool isSwitchedMessages = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Notification Settings',
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
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: 'All Notifications',fontSize: 14,),
                  Container(
                    width: 48,
                    height: 35,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child:Switch(

                        value: isSwitchedAllNotification,
                        onChanged: (value) {
                          setState(() {
                            isSwitchedAllNotification = value;
                            print(isSwitchedAllNotification);
                          });
                        },
                        activeTrackColor: Color(0xffE2FFE2),
                        activeColor: ColorResources.primaryColor,
                      ),
                    ),),
                ],
              ),
              SizedBox(height: 7,),
              Divider(
                height: 2,
                color: Color(0xffF3F3F3),
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: 'Match',fontSize: 14,),
                  Container(
                    width: 48,
                    height: 35,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child:Switch(
                        value: isSwitchedMatch,
                        onChanged: (value) {
                          setState(() {
                            isSwitchedMatch = value;
                            print(isSwitchedMatch);
                          });
                        },
                        activeTrackColor: Color(0xffE2FFE2),
                        activeColor: ColorResources.primaryColor,
                      ),
                    ),),

                ],
              ),
              SizedBox(height: 7,),
              Divider(
                height: 2,
                color: Color(0xffF3F3F3),
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: 'Events',fontSize: 14,),
                  Container(
                    width: 48,
                    height: 35,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child:Switch(
                        value: isSwitchedEvents,
                        onChanged: (value) {
                          setState(() {
                            isSwitchedEvents = value;
                            print(isSwitchedEvents);
                          });
                        },
                        activeTrackColor: Color(0xffE2FFE2),
                        activeColor: ColorResources.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7,),
              Divider(
                height: 2,
                color: Color(0xffF3F3F3),
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: 'Messages',fontSize: 14,),
                  Container(
                    width: 48,
                    height: 35,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child:Switch(

                        value: isSwitchedMessages,
                        onChanged: (value) {
                          setState(() {
                            isSwitchedMessages = value;
                            print(isSwitchedMessages);
                          });
                        },
                        activeTrackColor: Color(0xffE2FFE2),
                        activeColor: ColorResources.primaryColor,
                      ),
                    ),),

                ],
              ),
              SizedBox(height: 7,),
              Divider(
                height: 2,
                color: Color(0xffF3F3F3),
              ),
              SizedBox(height: 7,),
            ],
          ),
        ),
      ),
    );
  }
}
