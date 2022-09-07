import 'dart:convert';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../resouces/constants.dart';
import '../../resouces/functions.dart';

class AboutScreen extends StatefulWidget {


  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Dio _dio = Dio();
  var aboutData ;
  BuildContext _mainContex;
  getAboutdata()async{
    Apploader(_mainContex);
    Map<String, String> params = Map();
    params['settingid'] = "3";

    await _dio.post(SETTING_URL,data:jsonEncode(params)).then((value)async {
      if(value.statusCode == 200)
      {
        print("data status = ${value}");
        var varJson = value.data;
        print(varJson['setting_id']);

        setState(() {
          aboutData = varJson;
          RemoveAppLoader(_mainContex);
        });
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getAboutdata();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'About',
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
            padding:EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 30.0,),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.png",
                    color: ColorResources.blackColor,
                    width: MediaQuery.of(context).size.width/2,
                    height: 53,
                  ),
                ),
                SizedBox(height: 30.0,),
                CustomText(
                  text: aboutData!= null && aboutData.isNotEmpty ? removeHtmlTagsFromString(aboutData['setting_value']):'',
                  fontSize: 12,
                  height:1.5,
                ),


              ],
            ),
        ),
      ),
    );
  }

}
