

// ignore_for_file: use_key_in_widget_constructors

import 'package:afropeep/provider/card_provider.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/settings_screen/settings_main_screen.dart';
import 'package:afropeep/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:afropeep/screens/home_screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/home_screens/filter_screen.dart';
import 'screens/match_screens/its_match_screen.dart';
import 'screens/profile_screens/myprofile_screen.dart';
void main() {
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
            primarySwatch: ColorResources.primaryColor,
            fontFamily: 'Poppins',
            textTheme:GoogleFonts.poppinsTextTheme()
          // textTheme: const TextTheme(
          //   headline1: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          //   headline2: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
          //   bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
          // )

        ),

        home: HomeScreen(),
      ),
    );
  }
}
