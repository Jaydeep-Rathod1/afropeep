import 'dart:convert';

import 'package:afropeep/resouces/functions.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../resouces/constants.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  Dio _dio = Dio();
  var privacyData ;
  BuildContext _mainContex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
        await getPrivcydata();

    });
  }
  getPrivcydata()async{
    Apploader(_mainContex);
    Map<String, String> params = Map();
    params['settingid'] = "1";

    await _dio.post(SETTING_URL,data:jsonEncode(params)).then((value)async {
      if(value.statusCode == 200)
      {
        print("data status = ${value}");
        var varJson = value.data;
        print(varJson['setting_id']);
        setState(() {
          privacyData = varJson;
          RemoveAppLoader(_mainContex);
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Privacy Policy',
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
            children: [
              CustomText(
                text: privacyData!= null && privacyData.isNotEmpty ? privacyData['setting_value']:'',
                fontSize: 12,
                height:1.5,
              ),
              SizedBox(height: 10,),


            ],
          ),
        ),
      ),
    );
  }
}
