import 'dart:convert';
import 'dart:ui';

import 'package:afropeep/models/match_models/get_match_request_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:blur/blur.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchScreen extends StatefulWidget {
  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  Dio _dio = Dio();
  List<GetMatchRequestModel> arrAllMatchRequest = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getMatchList();
  }
  getMatchList()async{
    Map params = Map();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid =prefs.getInt('userid');
    params['userid'] = userid;
    await _dio.post(GET_MATCH_LIST,data: jsonEncode(params)).then((value) {
      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrAllMatchRequest =varJson.map((e) =>GetMatchRequestModel.fromJson(e)).toList();
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:20,right: 20,top: 20,bottom: 0.0),
      child: GridView.builder(
        // crossAxisCount: 2,
        // crossAxisSpacing: 10.0,
        // mainAxisSpacing: 10.0,
        // shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: arrAllMatchRequest.length,
        itemBuilder: (BuildContext context,index){
          return  Container(
            height: 180,
            width: 190,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/match_1.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:10.0,right: 10.0),
                  child: CustomText(text: 'Elizabeth Olsen, 25',color: ColorResources.whiteColor,fontSize: 12,),
                ),
                SizedBox(height: 2,),
                Padding(
                    padding: EdgeInsets.only(left:10.0,right: 8.0),
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined,size: 12.0,color: ColorResources.whiteColor,),
                        SizedBox(width: 5.0,),
                        CustomText(text: 'Ottawa, Canada ',fontSize: 10.0,color: ColorResources.whiteColor,),

                      ],
                    )
                ),
                SizedBox(height: 5.0,),
                Padding(
                  padding: EdgeInsets.only(left:0,right: 0),
                  child:  Container(
                    height: 40.0,
                    width: MediaQuery.of(context).size.width/2.3,

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white10.withAlpha(80)),
                      borderRadius: BorderRadius.only(
                        bottomRight: const Radius.circular(10.0),
                        bottomLeft: const Radius.circular(10.0),
                      ),
                    ),
                  ).blurred(
                    colorOpacity: 0.2,
                    borderRadius: BorderRadius.only(
                      bottomRight: const Radius.circular(10.0),
                      bottomLeft: const Radius.circular(10.0),
                    ),
                    blur: 2.5,
                    overlay:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            var requestid = arrAllMatchRequest[index].reqId;
                          },
                          child:Align(
                            alignment: Alignment.center,
                            child: Image.asset('assets/icons/white_heart.png',height: 20,width: 25,),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.all(10),
                          child: VerticalDivider(
                            color: ColorResources.whiteColor,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: ()async{
                            var requestid = arrAllMatchRequest[index].reqId;
                            Map params = Map();
                            params['requestid'] =requestid ;
                            params['status'] = "reject";
                            await _dio.post(REQUEST_REJECT_MATCH,data: jsonEncode(params)).then((value)async {
                              if(value.statusCode == 200)
                                {
                                  await getMatchList();
                                }
                            });
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset('assets/icons/close_icon.png',height: 20,width: 25,),
                          ),
                        )
                      ],
                    ),
                  ),),
              ],
            ),
            /*Container(
              height: 40,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Center(
                  child: Card(
                    elevation: 10,
                    color: Colors.black.withOpacity(0.5),
                    child: const SizedBox(
                      width: 300,
                      height: 200,
                      child: Center(
                        child: Text(
                          'Some Text',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),*/

          );
        },
      ),
    );
  }
}
