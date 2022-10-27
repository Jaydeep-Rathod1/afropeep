import 'dart:async';
import 'dart:convert';
import 'package:afropeep/models/user_models/call.dart';
import 'package:afropeep/models/user_models/log.dart';
import 'package:afropeep/models/user_models/single_user_model.dart';
import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/call_methods.dart';
import 'package:afropeep/provider/log_repository.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/chat_screens/audio_call_screen.dart';
import 'package:afropeep/screens/chat_screens/video_call_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickupScreen extends StatefulWidget {
  final Call call;

  PickupScreen({
    @required this.call,
  });

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final CallMethods callMethods = CallMethods();
  SharedPreferences prefs;
  // final LogRepository logRepository = LogRepository(isHive: true);
  // final LogRepository logRepository = LogRepository(isHive: false);

  bool isCallMissed = true,vibrates=true;
  SingleUserModel user;
  String image,name;
  int coin;


  @override
  void initState(){
    super.initState();
    FlutterRingtonePlayer.play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.glass,
      looping: true,
      volume: 1.0,
    );
    _loadpref();
  }
  _loadpref() async
  {
    Dio _dio = Dio();
    await _dio
        .post(GET_USER_BY_ID,
        data: jsonEncode({"userid": widget.call.callerId}))
        .then((value) async {
      if (value.statusCode == 200) {
        setState(() {
          user =
              SingleUserModel.fromJson(value.data[0]);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user==null?Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(10)),
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xffefefef),
                      blurRadius: 8.0
                  )
                ],
              ),
              alignment: Alignment.centerLeft,
              height: 65,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("Please Wait...",style: TextStyle(
                          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600),),
                    )
                  ],
                ),
              ),
            )
        ),
      ):Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Incoming...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 50),
            Image.network(
              GET_IMAGES_LINK + user.photoUrl1,
              height: 200,
              width: 200,
            ),
            SizedBox(height: 15),
            Text(
              user.firstname,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.call_end),
                  color: Colors.redAccent,
                  onPressed: () async {
                    setState(() {
                      vibrates=false;
                    });
                    FlutterRingtonePlayer.stop();
                    isCallMissed = false;
                    await callMethods.endCall(call: widget.call);
                  },
                ),
                SizedBox(width: 25),
                IconButton(
                    icon: Icon(Icons.call),
                    color: Colors.green,
                    onPressed: () async {
                      String now = DateTime.now().toString();
                      FlutterRingtonePlayer.stop();
                      isCallMissed = false;
                      var status = await Permission.camera.status;
                      if (status.isDenied) {
                        await Permission.camera.request();
                        if(status.isGranted){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    widget.call.callType=="video"?VideoCallScreen(call: widget.call,):AudioCallScreen(call: widget.call),
                              )
                          );
                        }
                      }else if(status.isGranted){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              widget.call.callType=="video"?VideoCallScreen(call: widget.call,):AudioCallScreen(call: widget.call),
                            )
                        );
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
