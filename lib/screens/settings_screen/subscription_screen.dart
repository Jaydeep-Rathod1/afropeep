import 'package:afropeep/models/settings_models/SubscriptionModel.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../resouces/constants.dart';
import '../../resouces/functions.dart';

class SubscriptionScreen extends StatefulWidget {


  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String selectedvalue;
  Dio _dio = Dio();
  var privacyData ;
  BuildContext _mainContex;
  List<SubscritionModel> arrSubscriptionList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getSubscriptiondata();

    });
  }
  getSubscriptiondata()async{
    Apploader(_mainContex);
    await _dio.get(SUBSCRITION_URL).then((value) {
      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrSubscriptionList =varJson.map((e) =>SubscritionModel.fromJson(e)).toList();
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
          text: 'Subscription',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: Padding(
            padding:EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                   alignment: Alignment.center,
                   child: CustomText(
                       text:'choose subscription'.toUpperCase(),
                       fontSize: 22,
                   ),
                 ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. ',
                    style: TextStyle(fontSize: 12,),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(child: Container(
                      height: 1,
                      color: Color(0xff707070),),),
                    OutlinedButton(
                      onPressed: (){},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffF5F5F5),
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(29.0)),
                        side: BorderSide(width: 1.0, color: Color(0xff707070)),
                      ),
                      child: Container(
                        width: 106,
                        height: 38,
                        alignment: Alignment.center,
                        child: CustomText(text: 'Plans'.toUpperCase(),color: ColorResources.blackColor,fontSize: 16,),
                      ),
                    ),
                    Expanded(child: Container(
                      height: 1,
                        color: Color(0xff707070)),)
                  ],
                ),
                SizedBox(height: 20.0,),

                Expanded(
                   child:  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                       padding: EdgeInsets.zero,
                       shrinkWrap: true,
                       itemCount: arrSubscriptionList.length,
                       itemBuilder: (BuildContext context, int index) {
                         return GestureDetector(
                           onTap: (){
                             setState(() {
                               // isSelected = !isSelected;
                               selectedvalue = arrSubscriptionList[index].subId.toString();
                             });
                           },
                           child:Expanded(
                             child:  Container(
                               width: MediaQuery.of(context).size.width,
                               margin: EdgeInsets.only(top:10,bottom: 10),
                               alignment: Alignment.center,
                               padding: EdgeInsets.only(left:30),
                               decoration: BoxDecoration(
                                   color: ColorResources.whiteColor,
                                   borderRadius: BorderRadius.circular(8)
                               ),
                               child:  Container(
                                 width: 500,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color: selectedvalue == arrSubscriptionList[index].subId.toString()? Color(0xffD8FFF9): Color(0xffF5F5F5),
                                   border: Border.all(
                                     color: selectedvalue == arrSubscriptionList[index].subId.toString()? Color(0xff097969): Color(0xff707070),
                                   ),
                                 ),
                                 padding: EdgeInsets.all(15.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     CustomText(text: "${arrSubscriptionList[index].price}/${arrSubscriptionList[index].duration}",fontSize: 20,),
                                     SizedBox(height: 5,),
                                     CustomText(text: arrSubscriptionList[index].discription,fontSize: 12,),
                                   ],
                                 ),
                               ),
                             ),
                           )
                         );
                       }),
                 ),

               /* GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedvalue = 'weekly';
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selectedvalue == 'weekly'? Color(0xffD8FFF9): Color(0xffF5F5F5),
                      border: Border.all(
                        color:selectedvalue == 'weekly'? Color(0xff097969): Color(0xff707070),
                      ),
                    ),
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(text: "\$20/ Weekly",fontSize: 20,),
                        SizedBox(height: 5,),
                        CustomText(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.",fontSize: 12,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                 GestureDetector(
                   onTap: (){
                     setState(() {
                       selectedvalue = 'month';
                     });
                   },
                   child:  Container(
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: selectedvalue == 'month'? Color(0xffD8FFF9): Color(0xffF5F5F5),
                       border: Border.all(
                         color: selectedvalue == 'month'? Color(0xff097969): Color(0xff707070),
                       ),
                     ),
                     padding: EdgeInsets.all(15.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         CustomText(text: "\$60/1 Month",fontSize: 20,),
                         SizedBox(height: 5,),
                         CustomText(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.",fontSize: 12,),
                       ],
                     ),
                   ),
                 ),
                SizedBox(height: 15.0,),
                GestureDetector(
                  onTap: (){

                    setState(() {
                      selectedvalue = 'year';
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selectedvalue == 'year'? Color(0xffD8FFF9): Color(0xffF5F5F5),
                      border: Border.all(
                        color: selectedvalue == 'year'? Color(0xff097969): Color(0xff707070),
                      ),
                    ),
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(text: "\$120/1 Year",fontSize: 20,),
                        SizedBox(height: 5,),
                        CustomText(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.",fontSize: 12,),
                      ],
                    ),
                  ),
                ),*/
                SizedBox(height: 20.0,),
                CustomButton(
                  height: 45,
                  fontSize: 16,
                  width: MediaQuery.of(context).size.width,
                  backgroundColor: ColorResources.blackColor,
                  onPressed: (){},
                  buttonText: 'Buy Now',
                ),
                TextButton(onPressed: (){}, child: CustomText(text: 'Skip',fontSize: 12,color: ColorResources.blackColor,))
              ],
            ),
        ),

    );
  }
}
