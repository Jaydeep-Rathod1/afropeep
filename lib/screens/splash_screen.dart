import 'dart:async';
import 'dart:convert';

import 'package:afropeep/main.dart';
import 'package:afropeep/models/user_models/modetostart_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/authentication_screens/login_screen.dart';
import 'package:afropeep/screens/face_rekognition/camera_new_screen.dart';
import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_mode_to_start_screen.dart';
import 'package:afropeep/screens/onboarding_screen/choose_photos_screen.dart';
import 'package:afropeep/screens/profile_screens/map_screen.dart';
import 'package:afropeep/screens/survey/questions_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   var duration = const Duration(seconds: 3);
    //   Timer(duration, navigationPage);
    // });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onSelectNotification(json.encode(message.data).toString());
    });
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/launcher_icon.png");
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (
            int id,
            String title,
            String body,
            String payload,
            ) async {
          didReceiveLocalNotificationStream.add(
            ReceivedNotification(
              id: id,
              title: title,
              body: body,
              payload: payload,
            ),
          );
        });
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    WidgetsBinding.instance.addObserver(this);
    Timer(Duration(seconds: 3), ()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var iscompletecong = await prefs.getBool('isCompleteCongrations');
      var validateLogin = await prefs.getBool('loginvalid');
      print(validateLogin);
      print(iscompletecong);
      if(validateLogin == false || validateLogin == null)
        {
          print("main if");
          Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.rightToLeft, child: LoginScreen()),(Route<dynamic> route) => false);
        }
      else{
        print("main else");
          if(iscompletecong == false || iscompletecong == null)
            {
              print("if");
              Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChooseModeToStart()),(Route<dynamic> route) => false);
            }
          else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            int userId = prefs.getInt("userid")??0;
            String token = await FirebaseMessaging.instance.getToken();
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(userId.toString()).get().then((value) {
              if(value.exists){
                value.reference.update({"is_online": true,"noti_token":token});
              }else{
                value.reference.set({"is_online": true,"noti_token":token});
              }
            });
            Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.rightToLeft, child: HomeScreen()),(Route<dynamic> route) => false);

          }
      }
      // }
    },
    );
  }
  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                print("Tapped");
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String payload) async {
      print("Tapppeedd0");
    });
  }

  onSelectNotification(payload) async {
    var data = json.decode(payload);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("userid")??0;
    String token = await FirebaseMessaging.instance.getToken();
    print("state"+state.toString());
    if (state == AppLifecycleState.resumed) {
      if(userId!=0){
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userId.toString()).get().then((value) {
          if(value.exists){
            value.reference.update({"is_online": true,"noti_token":token});
          }else{
            value.reference.set({"is_online": true,"noti_token":token});
          }
        });
      }
    } else {
      if(userId!=0){
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userId.toString()).get().then((value) {
          if(value.exists){
            value.reference.update({"is_online": false,"noti_token":token});
          }else{
            value.reference.set({"is_online": false,"noti_token":token});
          }
        });
      }
    }
    //TODO: set status to offline here in firestore
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  ColorResources.primaryColor,
      body:Center(
        child: Container(
          height: 80,
          width: 270,
          child: Image.asset('assets/images/logo.png'),
        ),
      )

    );
  }
}
