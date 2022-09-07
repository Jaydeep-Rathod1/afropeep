import 'dart:convert';

import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../resouces/constants.dart';
import '../../resouces/functions.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  Dio _dio = Dio();
  var termsAndConditionData ;
  BuildContext _mainContex;
  getTermsAndConditiondata()async{
    Apploader(_mainContex);
    Map<String, String> params = Map();
    params['settingid'] = "2";

    await _dio.post(SETTING_URL,data:jsonEncode(params)).then((value)async {
      if(value.statusCode == 200)
      {
        print("data status = ${value}");
        var varJson = value.data;
        print(varJson['setting_id']);
        setState(() {
          termsAndConditionData = varJson;
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
      await getTermsAndConditiondata();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Terms And Conditions',
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
                CustomText(
                  text: termsAndConditionData!= null && termsAndConditionData.isNotEmpty ? removeHtmlTagsFromString(termsAndConditionData['setting_value']):'',
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
