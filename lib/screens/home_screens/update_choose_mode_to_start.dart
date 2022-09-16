import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/user_models/modetostart_model.dart';
import '../../provider/card_provider.dart';
import '../../resouces/constants.dart';
import '../../resouces/functions.dart';
import '../../widgets/custom_button.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
class UpdateChooseModeToStart extends StatefulWidget {
  @override
  State<UpdateChooseModeToStart> createState() => _UpdateChooseModeToStartState();
}

class _UpdateChooseModeToStartState extends State<UpdateChooseModeToStart> {
  String value ;
  bool isSelected = false;
  String selectedvalue ='modetostart';
  Dio _dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        getModeToStartList();
      });
    });
  }
  List<ModeToStartModel> arrAllModeToStartList = [];
  getModeToStartList()async{
    Apploader(context);
    await _dio.get(GET_MODE).then((value) {
      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrAllModeToStartList =varJson.map((e) =>ModeToStartModel.fromJson(e)).toList();
          RemoveAppLoader(context);
          // dropdownvalue = arrAllCountryList[0];
        });
        print("aal = ${arrAllModeToStartList}");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Choose Mode To Start',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomText(text: 'Choose a mode to start',fontSize: 22,color: ColorResources.blackColor,),
          // SizedBox(height: 30.0,),

         ...arrAllModeToStartList.map((element) {
           return GestureDetector(
             onTap: (){
               setState(() {
                 value = element.modeId.toString();
               });
             },
             child: Container(
                 width: MediaQuery.of(context).size.width,
                 height: 61,
                 alignment: Alignment.center,
                 padding: EdgeInsets.only(left:30),
                 margin: EdgeInsets.only(bottom:20),
                 decoration: BoxDecoration(
                     color: ColorResources.whiteColor,
                     borderRadius: BorderRadius.circular(8),
                     border: Border.all(color: Color(0xff757575))
                 ),
                 child: ListTile(
                   title: Text(element.modeName),
                   trailing: value == element.modeId.toString()? Icon(Icons.check_circle ,color: Colors.black,) :Icon(Icons.circle_outlined ,color: Colors.black,),
                 )
             ),
           );
         }),
          Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: CustomButton(
                  height: 45,
                  backgroundColor: ColorResources.primaryColor,
                  onPressed: (){
                    var datewho = value;
                    var kmnew = 0;
                    var minage =0;
                    var maxage =0;
                    var nationality = "";
                    var isfilter = true;
                    print("date who = ${datewho}");
                    // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChoosePhotosScreen()));
                    Provider.of<CardProvider>(context, listen: false).getCardImages(datewho,kmnew,minage,maxage,nationality,isfilter).then((value){
                      Navigator.push(context,PageTransition(type: PageTransitionType.rightToLeft, child:  HomeScreen()));
                    });
                  },
                  buttonText: 'Apply',
                  fontSize: 16.0,
                  textColor: ColorResources.whiteColor,
                  width:MediaQuery.of(context).size.width,
                )
            ),
          ),
          const SizedBox(
            height: 34,
          )
        ],
      ),
      )
    );
  }
}
