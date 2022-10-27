import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/log_repository.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/chat_screens/chat_details_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  var is_block =false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (con) => ChatDetailsScreen(
                      userData: UserModel(
                        firstname: snapshot.data.docs[index].get("name"),
                        bio: snapshot.data.docs[index].get("bio"),
                        photoUrl1: snapshot.data.docs[index].get("photo_url"),
                        uerId: int.parse(snapshot.data.docs[index].id)
                      ),
                    ),
                  ),
                );
              },
              child:snapshot.data.docs[index].get('is_block') == false? Column(
                children: [
                  Row(
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
                            snapshot.data.docs[index].id;
                            var myTimeStamp = DateTime
                                .now()
                                .millisecondsSinceEpoch;
                          }
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ):Container(),
            );
          },
        );
      },
    );
  }
}
