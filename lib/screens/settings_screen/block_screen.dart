import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/settings_models/BlockListModel.dart';
import '../../models/user_models/user_model.dart';
import '../../resouces/functions.dart';
import '../chat_screens/chat_details_screen.dart';

class BlockScreen extends StatefulWidget {
  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  Dio _dio = Dio();
  String userId;
  List<BlockListModel> arrAllBlockList = [];
  BuildContext _mainContex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    getUserid();
  }
  getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt("userid").toString();
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("Chats")
        .get()
        .then((value) => print(value.docs.first.id));
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
     body: StreamBuilder(
       stream: FirebaseFirestore.instance
           .collection("Users")
           .doc(userId)
           .collection("Chats")
           .orderBy("time_stamp", descending: true)
           .snapshots(),
       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
         if (snapshot.data == null) {
           return Center();
         }
         return ListView.builder(
           padding: EdgeInsets.all(10),
           itemCount: snapshot.data.docs.length,
           itemBuilder: (context, index) {
             // mention the arrow syntax if you get the time
             return snapshot.data.docs[index].get('is_block') == true? Column(
               children: [
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     CircleAvatar(
                       backgroundImage: NetworkImage(GET_IMAGES_LINK +
                           snapshot.data.docs[index].get("photo_url")),
                       radius: 25,
                     ),
                     SizedBox(width: 10,),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         CustomText(
                             text: snapshot.data.docs[index].get("name"),
                             color: Colors.black,
                             fontSize: 14),
                         CustomText(
                             text:snapshot.data.docs[index].get("bio")!=null? snapshot.data.docs[index].get("bio"):'',
                             color: Color(0xff707070),
                             fontSize: 10),
                       ],
                     ),
                     Spacer(),
                     CustomButton(
                       width:91,
                       height: 35,
                       fontSize: 14,
                       backgroundColor: ColorResources.blackColor,
                       onPressed: ()async{
                         var receiverid =snapshot.data.docs[index].id;
                         await FirebaseFirestore.instance
                             .collection("Users")
                             .doc(userId)
                             .collection("Chats")
                             .doc(receiverid.toString()).update({'is_block':false});
                         },
                       buttonText: 'Unblock',
                     ),
                   ],
                 ),
                 SizedBox(height: 10,),
                 /* Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(
                         children: [
                           Stack(
                             children: [
                               CircleAvatar(
                                 backgroundImage: NetworkImage(GET_IMAGES_LINK +
                                     snapshot.data.docs[index].get("photo_url")),
                                 radius: 25,
                               ),
                               StreamBuilder(
                                   stream: FirebaseFirestore.instance
                                       .collection("Users")
                                       .doc(snapshot.data.docs[index].id).snapshots(),
                                   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                     if (snapshot.connectionState ==
                                         ConnectionState.done) {
                                       return Center(
                                         child: CircularProgressIndicator(),);
                                     }else {
                                       if (snapshot.hasError) {
                                         return Positioned(
                                             right: 5.0,
                                             bottom: 1.0,
                                             child: Icon(
                                               Icons.circle,
                                               size: 10,
                                               color: Colors.red,
                                             ));
                                       }
                                       if (snapshot.hasData) {
                                         try {
                                           return Positioned(
                                               right: 5.0,
                                               bottom: 1.0,
                                               child: Icon(
                                                 Icons.circle,
                                                 size: 10,
                                                 color: snapshot.data.get(
                                                     "is_online")
                                                     ? Color(0xff39AF17)
                                                     : Colors.red,
                                               ));
                                         }catch(e){
                                           return Positioned(
                                               right: 5.0,
                                               bottom: 1.0,
                                               child: Icon(
                                                 Icons.circle,
                                                 size: 10,
                                                 color: Colors.red,
                                               ));
                                         }

                                       }
                                       return Positioned(
                                           right: 5.0,
                                           bottom: 1.0,
                                           child: Icon(
                                             Icons.circle,
                                             size: 10,
                                             color: Colors.red,
                                           ));
                                     }
                                   }),
                             ],
                           ),
                           SizedBox(
                             width: 10,
                           ),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               CustomText(
                                   text: snapshot.data.docs[index].get("name"),
                                   color: Colors.black,
                                   fontSize: 14),
                               CustomText(
                                   text:snapshot.data.docs[index].get("bio")!=null? snapshot.data.docs[index].get("bio"):'',
                                   color: Color(0xff707070),
                                   fontSize: 10),
                             ],
                           ),
                         ],
                       ),

                       PopupMenuButton(
                           child:  Icon(Icons.more_vert_outlined),
                           itemBuilder: (context) {
                             return List.generate(1, (index) {
                               return PopupMenuItem(
                                 value: index,
                                 child: Text('Block'),
                               );
                             });
                           },
                           onSelected: (int index) {
                             print('index is $index');
                           }
                       ),
                     ],
                   ),*/
                 Divider(),
               ],
             ):Container();
           },
         );
       },
     ),
     /* body: ListView.builder(
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
                     *//* var blockid = arrAllBlockList[index].blockId.toString();
                      await _dio.post(UNBLOCK_USER,data: {'blockid':blockid}).then((value) async{
                        print(value.toString());
                        if(value.statusCode == 200)
                        {
                          print("success");
                          await getBlockList();
                        }
                      });*//*
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
      }),*/
    );
  }
}
