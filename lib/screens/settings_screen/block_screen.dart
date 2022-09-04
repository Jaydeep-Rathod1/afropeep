import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/settings_models/BlockListModel.dart';
import '../../resouces/functions.dart';

class BlockScreen extends StatefulWidget {

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  Dio _dio = Dio();
  var userid;
  List<BlockListModel> arrAllBlockList = [];
  BuildContext _mainContex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getBlockList();

    });
  }
  getBlockList()async{
    Apploader(_mainContex);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid =prefs.getInt('userid');
    print(userid);
    await _dio.post(BLOCK_LIST,data: {'userid':userid.toString()}).then((value) {
      var varJson = value.data as List;

      if(value.statusCode == 200)
      {
        setState(() {
          arrAllBlockList =varJson.map((e) =>BlockListModel.fromJson(e)).toList();
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
          text: 'Block',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: arrAllBlockList.length,
          itemBuilder: (context,index){
        return Padding(padding: EdgeInsets.only(left:20.0,right: 20.0,top: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: arrAllBlockList[index].photoUrl1 != null ? NetworkImage(GET_IMAGES_LINK+arrAllBlockList[index].photoUrl1):AssetImage('assets/icons/img_user.png')//Text
                          // child:arrAllBlockList[index].photoUrl1 != null ? Image.network(GET_IMAGES_LINK+arrAllBlockList[index].photoUrl1,height: 46,width: 46,fit: BoxFit.fill,):Image.asset('assets/icons/img_user.png',height: 46,width: 46,)//Text
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(text:arrAllBlockList[index].firstname != null? arrAllBlockList[index].firstname:"User",fontSize: 14,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on_outlined,size: 14.7,),
                              CustomText(text: 'Ottawa, Canada',fontSize: 10.0,)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomButton(
                    width:91,
                    height: 35,
                    fontSize: 14,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: ()async{
                      var blockid = arrAllBlockList[index].blockId.toString();
                      await _dio.post(UNBLOCK_USER,data: {'blockid':blockid}).then((value) async{
                        print(value.toString());
                        if(value.statusCode == 200)
                        {
                          print("success");
                          await getBlockList();
                        }
                      });
                    },
                    buttonText: 'Unblock',
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Divider(
                height: 2,
                color: Color(0xffF3F3F3),
              ),




            ],
          ),
        );
      }),
    );
  }
}
