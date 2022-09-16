

// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:afropeep/provider/card_provider.dart';
import 'package:afropeep/resouces/MyHttpOverrides.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/face_rekognition/camera_new_screen.dart';
import 'package:afropeep/screens/profile_screens/myprofile_screen.dart';
import 'package:afropeep/screens/splash_screen.dart';
import 'package:afropeep/screens/survey/congratulation_screen.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


void main()async {
  HttpOverrides.global = new MyHttpOverrides();
  // WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFFFFFFF),
            primarySwatch: ColorResources.primaryColor,
            fontFamily: 'Poppins',
            textTheme:GoogleFonts.poppinsTextTheme()
          // textTheme: const TextTheme(
          //   headline1: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          //   headline2: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
          //   bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
          // )
        ),
        home:  SplashScreen(),
      ),
    );
  }
}
