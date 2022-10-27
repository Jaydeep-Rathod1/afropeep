import 'dart:math';

import 'package:afropeep/models/user_models/call.dart';
import 'package:afropeep/models/user_models/log.dart';
import 'package:afropeep/models/user_models/single_user_model.dart';
import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/call_methods.dart';
import 'package:afropeep/provider/log_repository.dart';
import 'package:afropeep/screens/chat_screens/audio_call_screen.dart';
import 'package:afropeep/screens/chat_screens/video_call_screen.dart';
import 'package:afropeep/screens/chat_screens/video_player_screen.dart';
import 'package:flutter/material.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dialVideo({SingleUserModel from, UserModel to, context}) async {
    Call call = Call(
      callerId: from.userId.toString(),
      callerName: from.firstname.toString(),
      callerPic: from.photoUrl1.toString(),
      callerauthorise: from.status,
      callType: "video",
      receiverId: to.uerId.toString(),
      receiverName: to.firstname.toString(),
      receiverPic: to.photoUrl1.toString(),
      channelId: Random().nextInt(1000).toString(),
    );

    Log log = Log(
      callerid:from.userId.toString(),
      callerName: from.firstname.toString(),
      callerPic: from.photoUrl1.toString(),
      callStatus: "dialled",
      receiverId: to.uerId.toString(),
      receiverName: to.firstname.toString(),
      receiverPic: to.photoUrl1.toString(),
      timestamp: DateTime.now().toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;
    String now=DateTime.now().toString();

    if (callMade) {
      // enter log
      LogRepository.addLogs(log);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoCallScreen(call: call,receiver: to,),
        ),
      );
    }
  }

  static dialAudio({SingleUserModel from, UserModel to, context}) async {
    Call call = Call(
      callerId: from.userId.toString(),
      callType: "audio",
      callerName: from.firstname.toString(),
      callerPic: from.photoUrl1.toString(),
      callerauthorise: from.status,
      receiverId: to.uerId.toString(),
      receiverName: to.firstname.toString(),
      receiverPic: to.photoUrl1.toString(),
      channelId: Random().nextInt(1000).toString(),
    );

    Log log = Log(
      callerid:from.userId.toString(),
      callerName: from.firstname.toString(),
      callerPic: from.photoUrl1.toString(),
      callStatus: "dialled",
      receiverId: to.uerId.toString(),
      receiverName: to.firstname.toString(),
      receiverPic: to.photoUrl1.toString(),
      timestamp: DateTime.now().toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;
    String now=DateTime.now().toString();

    if (callMade) {
      // enter log
      LogRepository.addLogs(log);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AudioCallScreen(call: call,receiver: to,),
        ),
      );
    }
  }
}
