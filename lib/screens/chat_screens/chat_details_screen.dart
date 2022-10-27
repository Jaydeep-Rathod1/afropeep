import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:afropeep/models/user_models/single_user_model.dart';
import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/log_repository.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/chat_screens/audio_call_screen.dart';
import 'package:afropeep/screens/chat_screens/audio_screen.dart';
import 'package:afropeep/screens/chat_screens/video_call_screen.dart';
import 'package:afropeep/screens/chat_screens/video_player_screen.dart';
import 'package:afropeep/screens/chat_screens/video_thumbnail.dart';
import 'package:afropeep/widgets/call_utilities.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:audioplayers/audioplayers.dart' as a;
import 'package:audioplayers/audioplayers.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as f;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resouces/color_resources.dart';

class ChatDetailsScreen extends StatefulWidget {
  UserModel userData;

  ChatDetailsScreen({this.userData});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List messages = [];
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;
  TextEditingController _controller = TextEditingController();
  //ScrollController _scrollController = ScrollController();
  var receiverid;
  var senderid = "";
  final _audioRecorder = Record();
  bool emojiShowing = false;
  bool isRecordingStart = false;
  TextEditingController _inputKeyboradController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // connect();
    getSenderid();
    // getUserisBlockOrNot();
    KeyboardVisibility.onChange.listen((bool isKeyboardVisible) {
      setState(() {
        this.isKeyboardVisible = isKeyboardVisible;
      });

      if (isKeyboardVisible && isEmojiVisible) {
        setState(() {
          isEmojiVisible = false;
        });
      }
    });
    connect();
    // Timer(Duration(milliseconds: 500), (){
    //   _scrollController.animateTo(
    //     _scrollController.position.maxScrollExtent,
    //     duration: Duration(milliseconds: 100),
    //     curve: Curves.easeInOut
    //   );
    // });
  }

  getSenderid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      senderid = prefs.getInt("userid").toString();
      LogRepository.init(
        isHive: false,
        dbName: senderid,
      );
      receiverid = widget.userData.uerId;
    });
    // await getUserisBlockOrNot();
  }
  var is_block =false;

   getUserisBlockOrNot()async{
    print("senderid = ${senderid}");
    print("receiverid = ${receiverid}");
     await FirebaseFirestore.instance
        .collection("Users")
        .doc(senderid)
        .collection("Chats")
        .doc(receiverid.toString()).get().then((snapshot) {
        print(snapshot.exists);
       if(snapshot.data().isNotEmpty)
         {
           Map<dynamic, dynamic> map = snapshot.data();
           map.forEach((key, value) {
             if(key == "is_block")
             {
               if(value == true)
               {
                 print("value = ${value}");
                 setState((){
                   is_block = true;
                 });
               }


             }

           });
         }


    });

  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    // socket = IO.io("http://192.168.0.106:5000", <String, dynamic>{
    //   "transports": ["websocket"],
    //   "autoConnect": false,
    // });
    // socket.connect();
    // socket.emit("signin", widget.sourchat.id);
    // socket.onConnect((data) {
    //   print("Connected");
    //   socket.on("message", (msg) {
    //     print(msg);
    //     setMessage("destination", msg["message"]);
    //     _scrollController.animateTo(_scrollController.position.maxScrollExtent,
    //         duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    //   });
    // });
    // print(socket.connected);
  }

  // void sendMessage(String message, int sourceId, int targetId) {
  //   setMessage("source", message);
  //   // socket.emit("message",
  //   //     {"message": message, "sourceId": sourceId, "targetId": targetId});
  // }

  void setMessage(String type, String message) {
    // MessageModel messageModel = MessageModel(
    //     type: type,
    //     message: message,
    //     time: DateTime.now().toString().substring(10, 16));
    print(messages);

    // setState(() {
    //   messages.add(messageModel);
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(GET_IMAGES_LINK + widget.userData.photoUrl1),
                  radius: 20,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(widget.userData.uerId.toString())
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
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
                                  color: snapshot.data.get("is_online")
                                      ? Color(0xff39AF17)
                                      : Colors.red,
                                ));
                          } catch (e) {
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
              width: 5.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // CustomText(text: 'Scarlett Johansson',fontSize: 16,),
                Text(
                  (widget.userData.firstname ?? "") +
                      (widget.userData.lastname ?? ""),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 2.0,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(widget.userData.uerId.toString())
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.hasError) {
                          return CustomText(
                            text: 'Offline',
                            fontSize: 8,
                          );
                        }
                        if (snapshot.hasData) {
                          try {
                            return CustomText(
                              text: snapshot.data.get("is_online")
                                  ? "Online"
                                  : 'Offline',
                              fontSize: 8,
                            );
                          } catch (e) {
                            return CustomText(
                              text: 'Offline',
                              fontSize: 8,
                            );
                          }
                        }
                        return CustomText(
                          text: 'Offline',
                          fontSize: 8,
                        );
                      }
                    }),
              ],
            )
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async{
              var status = await Permission.camera.status;
              if (status.isDenied) {
                await Permission.camera.request();
                if(status.isGranted){
                  var status = await Permission.camera.status;
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  var senderid = prefs.getInt("userid").toString();
                  Dio _dio = Dio();
                  SingleUserModel senderUserModel;
                  await _dio
                      .post(GET_USER_BY_ID,
                      data: jsonEncode({"userid": senderid}))
                      .then((value) async {
                    print("value = ${value}");
                    // final coordinates = new Coordinates(
                    //     myLocation.latitude, myLocation.longitude);
                    // var addresses = await Geocoder.local.findAddressesFromCoordinates(
                    //     coordinates);
                    // var first = addresses.first;

                    if (value.statusCode == 200) {
                      setState(() {
                        senderUserModel = SingleUserModel.fromJson(value.data[0]);
                      });
                    }
                  });
                  UserModel recieverUserModel = widget.userData;
                  CallUtils.dialVideo(
                    from: senderUserModel,
                    to: recieverUserModel,
                    context: context,
                  );
                  sendAudioVideoNotification(widget.userData.firstname,"video");
                }
              } else{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var senderid = prefs.getInt("userid").toString();
                Dio _dio = Dio();
                SingleUserModel senderUserModel;
                await _dio
                    .post(GET_USER_BY_ID,
                    data: jsonEncode({"userid": senderid}))
                    .then((value) async {
                  print("value = ${value}");
                  // final coordinates = new Coordinates(
                  //     myLocation.latitude, myLocation.longitude);
                  // var addresses = await Geocoder.local.findAddressesFromCoordinates(
                  //     coordinates);
                  // var first = addresses.first;

                  if (value.statusCode == 200) {
                    setState(() {
                      senderUserModel =
                          SingleUserModel.fromJson(value.data[0]);
                    });
                  }
                });
                UserModel recieverUserModel = widget.userData;
                CallUtils.dialVideo(
                  from: senderUserModel,
                  to: recieverUserModel,
                  context: context,
                );
                sendAudioVideoNotification(widget.userData.firstname,"video");
              }
            },
            child: Icon(
              CupertinoIcons.videocam_fill,
              size: 28,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          GestureDetector(
            onTap: () async {
              var status = await Permission.microphone.status;
              if (status.isDenied) {
                await Permission.microphone.request();
                if(status.isGranted) {
                  var status = await Permission.camera.status;
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  var senderid = prefs.getInt("userid").toString();
                  Dio _dio = Dio();
                  SingleUserModel senderUserModel;
                  await _dio
                      .post(GET_USER_BY_ID,
                      data: jsonEncode({"userid": senderid}))
                      .then((value) async {
                    print("value = ${value}");
                    // final coordinates = new Coordinates(
                    //     myLocation.latitude, myLocation.longitude);
                    // var addresses = await Geocoder.local.findAddressesFromCoordinates(
                    //     coordinates);
                    // var first = addresses.first;
                    if (value.statusCode == 200) {
                      setState(() {
                        senderUserModel = SingleUserModel.fromJson(value.data[0]);
                      });
                    }
                  });
                  UserModel recieverUserModel = widget.userData;
                  CallUtils.dialAudio(
                    from: senderUserModel,
                    to: recieverUserModel,
                    context: context,
                  );
                  sendAudioVideoNotification(widget.userData.firstname,"audio");
                }
              }
              else{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var senderid = prefs.getInt("userid").toString();
                Dio _dio = Dio();
                SingleUserModel senderUserModel;
                await _dio
                    .post(GET_USER_BY_ID,
                    data: jsonEncode({"userid": senderid}))
                    .then((value) async {
                  print("value = ${value}");
                  // final coordinates = new Coordinates(
                  //     myLocation.latitude, myLocation.longitude);
                  // var addresses = await Geocoder.local.findAddressesFromCoordinates(
                  //     coordinates);
                  // var first = addresses.first;

                  if (value.statusCode == 200) {
                    setState(() {
                      senderUserModel =
                          SingleUserModel.fromJson(value.data[0]);
                    });
                  }
                });
                UserModel recieverUserModel = widget.userData;
                CallUtils.dialAudio(
                  from: senderUserModel,
                  to: recieverUserModel,
                  context: context,
                );
                sendAudioVideoNotification(widget.userData.firstname,"audio");
              }
            },
            child: Icon(
              CupertinoIcons.phone_fill,
              size: 20,
            ),
          ),
          PopupMenuButton(
              child:  Icon(Icons.more_vert_outlined),
              itemBuilder: (context) {
                return List.generate(1, (index) {
                  return PopupMenuItem(
                    value: index,
                    child: is_block==false? Text('Block'):Text('Unblock'),
                  );
                });
              },
              onSelected: (int index) async{
                print('index is $index');
                print(senderid);
                print(receiverid);
                var myTimeStamp = DateTime.now().millisecondsSinceEpoch;
                if(is_block == false)
                  {
                    print("block");
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .doc(senderid)
                        .collection("Chats")
                        .doc(receiverid.toString())
                        .set({
                      "bio": widget.userData.bio,
                      "name": widget.userData.firstname,
                      "photo_url": widget.userData.photoUrl1,
                      "is_block" :true,
                      "time_stamp": myTimeStamp,
                    }).then((value)async {
                      setState(() {
                        is_block = true;
                      });
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(receiverid.toString())
                          .collection("Chats")
                          .doc(senderid)
                          .set({
                        "bio": widget.userData.bio,
                        "name": widget.userData.firstname,
                        "photo_url": widget.userData.photoUrl1,
                        "is_block" :false,
                        "time_stamp": myTimeStamp,
                      }).then((value) {
                      });
                    });
                  }else{
                  print("Unblock");
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(senderid)
                      .collection("Chats")
                      .doc(receiverid.toString()).update({"is_block":false}).then((value) {
                    print("sucess");
                    setState(() {
                      is_block = false;
                    });
                  }).then((value)async {
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .doc(receiverid.toString())
                        .collection("Chats")
                        .doc(senderid).update({"is_block":false}).then((value) {
                      print("sucess");
                      setState(() {
                        is_block = false;
                      });
                    });
                  });
                }

              }
          ),
          SizedBox(
            width: 4.0,
          ),
        ],
      ),
      body: (senderid != "")
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(senderid)
                          .collection("Chats")
                          .doc(receiverid.toString())
                          .collection("Messages")
                          .orderBy('timestamp',descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.size <= 0) {
                            return Expanded(
                                child: Center(child: Text("No Messages yet!")));
                          } else {
                            return Expanded(
                              child: ListView(
                                //controller: _scrollController,
                                reverse: true,
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                children: snapshot.data.docs.map((document) {
                                  var dt = DateTime.fromMillisecondsSinceEpoch(
                                      document["timestamp"]);
                                  var d12 = DateFormat('h:mm a').format(dt);
                                  if (senderid ==
                                      document['senderid'].toString()) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 14,
                                              right: 14,
                                              top: 10,
                                              bottom: 5),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10)),
                                                color:
                                                    ColorResources.primaryColor,
                                              ),
                                              padding:
                                                  (document["messagetype"] ==
                                                          "image")
                                                      ? EdgeInsets.zero
                                                      : EdgeInsets.all(8),
                                              child: (document["messagetype"] ==
                                                      "image")
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10)),
                                                      child: CachedNetworkImage(
                                                        height: 250,
                                                        width: 200,
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            document['message'],
                                                        placeholder: (context,
                                                                url) =>
                                                            Container(
                                                                height: 250,
                                                                width: 200,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                    )
                                                  : document["messagetype"] ==
                                                          "video"
                                                      ? InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                    child: VideoPlayerScreen(
                                                                        url: document[
                                                                            "message"]),
                                                                    type: PageTransitionType
                                                                        .leftToRight));
                                                          },
                                                          child: Container(
                                                              height: 250,
                                                              width: 200,
                                                              child:
                                                                  VideoDesignScreen(
                                                                url: document[
                                                                    "message"],
                                                              )),
                                                        )
                                                      : document["messagetype"] ==
                                                              "audio"
                                                          ? Container(
                                                              width: 200,
                                                              child:
                                                                  PlayerWidget(
                                                                url: document[
                                                                    "message"],
                                                              ))
                                                          : Text(
                                                              document[
                                                                  "message"],
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: ColorResources
                                                                      .whiteColor),
                                                            ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 14),
                                          child: Text(
                                            d12.toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                    ColorResources.blackColor),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  else {
                                    return Row(
                                      children: [
                                        Container(
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                GET_IMAGES_LINK +
                                                    widget.userData.photoUrl1),
                                            radius: 20,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 14,
                                                    right: 14,
                                                    top: 10,
                                                    bottom: 5),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                          topLeft:
                                                          Radius.circular(10),
                                                          topRight:
                                                          Radius.circular(10),
                                                          bottomRight:
                                                          Radius.circular(10)),
                                                      color:
                                                      ColorResources.primaryColor,
                                                    ),
                                                    padding:
                                                    (document["messagetype"] ==
                                                        "image")
                                                        ? EdgeInsets.zero
                                                        : EdgeInsets.all(8),
                                                    child: (document["messagetype"] ==
                                                        "image")
                                                        ? ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(10),
                                                          topRight: Radius
                                                              .circular(10),
                                                          bottomRight: Radius
                                                              .circular(
                                                              10)),
                                                      child: CachedNetworkImage(
                                                        height: 250,
                                                        width: 200,
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                        document['message'],
                                                        placeholder: (context,
                                                            url) =>
                                                            Container(
                                                                height: 250,
                                                                width: 200,
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                child:
                                                                CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                            url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                    )
                                                        : document["messagetype"] ==
                                                        "video"
                                                        ? InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                child: VideoPlayerScreen(
                                                                    url: document[
                                                                    "message"]),
                                                                type: PageTransitionType
                                                                    .leftToRight));
                                                      },
                                                      child: Container(
                                                          height: 250,
                                                          width: 200,
                                                          child:
                                                          VideoDesignScreen(
                                                            url: document[
                                                            "message"],
                                                          )),
                                                    )
                                                        : document["messagetype"] ==
                                                        "audio"
                                                        ? Container(
                                                        width: 200,
                                                        child:
                                                        PlayerWidget(
                                                          url: document[
                                                          "message"],
                                                        ))
                                                        : Text(
                                                      document[
                                                      "message"],
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: ColorResources
                                                              .whiteColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(right: 14),
                                                child: Text(
                                                  d12.toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                      ColorResources.blackColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                }).toList(),
                              ),
                            );
                          }
                        } else {
                          return Expanded(
                              child: Center(
                            child: CircularProgressIndicator(),
                          ));
                        }
                      }),


                  is_block == false
                      ?Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 8),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xff707070), width: 1.0),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TextFormField(
                                  controller: _inputKeyboradController,
                                  focusNode: focusNode,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  onChanged: (value) {
                                    if (value.length > 0) {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type a message",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                    prefixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        isEmojiVisible
                                            ? Icons.keyboard
                                            : Icons.emoji_emotions_outlined,
                                      ),
                                      onPressed: onClickedEmoji,
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          iconSize: 22,
                                          icon: Icon(Icons.attach_file),
                                          onPressed: () async {
                                            FilePickerResult result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                              allowMultiple: false,
                                              type: FileType.custom,
                                              allowedExtensions: [
                                                'jpg',
                                                'mp4',
                                                'jpeg',
                                                'png',
                                                'mp3'
                                              ],
                                              allowCompression: true,
                                            );
                                            String extension = result
                                                .files.single.path
                                                .split(".")
                                                .last;
                                            if (result != null) {
                                              File file = File(
                                                  result.files.single.path);
                                              int sizeInBytes =
                                                  file.lengthSync();
                                              double sizeInMb =
                                                  sizeInBytes / (1024 * 1024);
                                              if (sizeInMb < 10.0) {
                                                UploadTask _uploadImage;
                                                try {
                                                  var myTimeStamp = DateTime.now().millisecondsSinceEpoch;
                                                  var sendingId = "";
                                                  await FirebaseFirestore.instance
                                                      .collection("Users")
                                                      .doc(senderid)
                                                      .collection("Chats")
                                                      .doc(receiverid.toString())
                                                      .collection("Messages")
                                                      .add({
                                                    "senderid": senderid,
                                                    "receiverid": receiverid,
                                                    "message": extension == "mp4"?"Sending video...":"Sending audio...",
                                                    "messagetype": "text",
                                                    "timestamp": myTimeStamp
                                                  }).then((value) => sendingId = value.id);
                                                  // _scrollController.animateTo(
                                                  //     _scrollController.position.maxScrollExtent,
                                                  //     duration: Duration(milliseconds: 300),
                                                  //     curve: Curves.easeOut);
                                                  _uploadImage = FirebaseStorage
                                                      .instance
                                                      .ref()
                                                      .child(
                                                          '${DateTime.now().millisecondsSinceEpoch}')
                                                      .putFile(file);

                                                  var url =
                                                      await (await _uploadImage)
                                                          .ref
                                                          .getDownloadURL();
                                                  print(url);
                                                  sendFileMessage(
                                                      url,
                                                      extension == "mp4"
                                                          ? "video":extension == "mp3"?"audio"
                                                          : "image",sendingId);
                                                  //Future.value(_uploadImage).then((value) => print(value));
                                                  //return url;
                                                } catch (e) {
                                                  return null;
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "send media lessthen 5.0 MB");
                                              }
                                            } else {
                                              // User canceled the picker
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        if (sendButton)
                                          GestureDetector(
                                            onTap: () {
                                              sendMessage();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: CircleAvatar(
                                                radius: 16,
                                                backgroundColor:
                                                    Color(0xFF128C7E),
                                                child: Image.asset(
                                                  'assets/icons/send_icon.png',
                                                  height: 15,
                                                  width: 15,
                                                ),
                                              ),
                                            ),
                                          )
                                        else
                                          GestureDetector(
                                            onTap: (){
                                              Fluttertoast.showToast(msg: "Hold to record, release to send");
                                            },
                                            onLongPress: () async {
                                              print("onLongPress");
                                              _start();
                                            },
                                            onLongPressEnd: (LongPressEnd) {
                                              print("onLongPressEnd");
                                              _stop();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: CircleAvatar(
                                                radius: 16,
                                                backgroundColor:
                                                Color(0xFF128C7E),
                                                child: Icon(Icons.mic,size: 20,color: Colors.white,),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // show ? emojiSelect() :
                      ],
                    ),
                  )
                      :GestureDetector(
                    onTap: ()async{
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(senderid)
                          .collection("Chats")
                          .doc(receiverid.toString()).update({"is_block":false}).then((value) {
                            print("sucess");
                            setState(() {
                              is_block = false;
                            });
                      }).then((value)async {
                        await FirebaseFirestore.instance
                            .collection("Users")
                            .doc(receiverid.toString())
                            .collection("Chats")
                            .doc(senderid).update({"is_block":false}).then((value) {
                          print("sucess");
                          setState(() {
                            is_block = false;

                          });
                        });
                      });
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      color: Colors.red.shade500,
                      child: CustomText(
                        text: "Unblock ${widget.userData.firstname}",
                        color: ColorResources.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !isEmojiVisible,
                    child: Container(
                      height: 250,
                      child: EmojiPicker(
                        onEmojiSelected: (category, emoji) {
                          // Do something when emoji is tapped (optional)
                          //_inputKeyboradController.text = _inputKeyboradController.text + emoji.emoji;
                        },
                        onBackspacePressed: () {
                          //_inputKeyboradController.text = _inputKeyboradController.text.substring(0,_inputKeyboradController.text.length-1);
                        },
                        textEditingController: _inputKeyboradController,
                        config: Config(
                          columns: 7,
                          emojiSizeMax: 24 * (Platform.isIOS ? 1.30 : 1.0),
                          // Issue: https://github.com/flutter/flutter/issues/28894
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          gridPadding: EdgeInsets.zero,
                          initCategory: Category.RECENT,
                          bgColor: Color(0xFFF2F2F2),
                          indicatorColor: Colors.blue,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.blue,
                          // progressIndicatorColor: Colors.blue,
                          backspaceColor: Colors.blue,
                          skinToneDialogBgColor: Colors.white,
                          skinToneIndicatorColor: Colors.grey,
                          enableSkinTones: true,
                          showRecentsTab: true,
                          recentsLimit: 28,
                          noRecents: const Text(
                            'No Recents',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black26),
                            textAlign: TextAlign.center,
                          ),
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : CircularProgressIndicator(),
    );
  }

  void onClickedEmoji() async {
    if (isEmojiVisible) {
      focusNode.requestFocus();
    } else if (isKeyboardVisible) {
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await Future.delayed(Duration(milliseconds: 100));
    }
    toggleEmojiKeyboard();
  }

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }
    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  Future<void> _start() async {
    try {
      setState(() {
        isRecordingStart = true;
        _inputKeyboradController.text = "Start Recording....";
      });
      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (f.kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }

        // final devs = await _audioRecorder.listInputDevices();
        // final isRecording = await _audioRecorder.isRecording();
        final directory = await getExternalStorageDirectory();
        print(directory.path);
        await _audioRecorder.start(
          path: directory.path + "new1.m4a",
          encoder: AudioEncoder.aacLc, // by default
          bitRate: 128000, // by default
          samplingRate: 44100, // by default
        );
        // _recordDuration = 0;
        //
        // _startTimer();
      }
    } catch (e) {
      if (f.kDebugMode) {
        print(e);
      }
      setState(() {
        isRecordingStart =false;
        _inputKeyboradController.clear();
      });
    }
  }

  Future<void> _stop() async {
    // _timer?.cancel();
    // _recordDuration = 0;
    setState(() {
      isRecordingStart =false;
      _inputKeyboradController.clear();
    });
    final path = await _audioRecorder.stop();
    print(path);
    print("completed");
    UploadTask _uploadImage;
    try {
      var myTimeStamp = DateTime.now().millisecondsSinceEpoch;
      var sendingId = "";
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(senderid)
          .collection("Chats")
          .doc(receiverid.toString())
          .collection("Messages")
          .add({
        "senderid": senderid,
        "receiverid": receiverid,
        "message": "Sending audio...",
        "messagetype": "text",
        "timestamp": myTimeStamp
      }).then((value) => sendingId = value.id);
      // _scrollController.animateTo(
      //     _scrollController.position.maxScrollExtent,
      //     duration: Duration(milliseconds: 300),
      //     curve: Curves.easeOut);
      _uploadImage = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}')
          .putFile(File(path));

      var url = await (await _uploadImage).ref.getDownloadURL();
      print(url);
      sendFileMessage(url, "audio",sendingId);
      //Future.value(_uploadImage).then((value) => print(value));
      //return url;
    } catch (e) {
      return null;
    }
    // if (path != null) {
    //   widget.onStop(path);
    // }
  }

  sendMessage() async {
    var message = _inputKeyboradController.text.toString().trim();
    setState(() {
      _inputKeyboradController.clear();
      setState(() {
        sendButton = false;
      });
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderid = prefs.getInt("userid").toString();
    var receiverid = widget.userData.uerId;
    Dio _dio = Dio();
    SingleUserModel senderUserModel;
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    var myTimeStamp = DateTime.now().millisecondsSinceEpoch;
    var sendingId = "";

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(senderid)
        .collection("Chats")
        .doc(receiverid.toString())
        .collection("Messages")
        .add({
      "senderid": senderid,
      "receiverid": receiverid,
      "message": "Sending Message...",
      "messagetype": "text",
      "timestamp": myTimeStamp
    }).then((value) => sendingId = value.id);

    // _scrollController.animateTo(
    //     _scrollController.position.maxScrollExtent,
    //     duration: Duration(milliseconds: 300),
    //     curve: Curves.easeOut);
    if (message.isNotEmpty) {
      print(message);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(senderid)
          .collection("Chats")
          .doc(receiverid.toString())
          .set({
        "bio": widget.userData.bio,
        "name": widget.userData.firstname,
        "photo_url": widget.userData.photoUrl1,
        "is_block":false,
        "time_stamp": myTimeStamp,
      }).whenComplete(() => {
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(senderid)
                    .collection("Chats")
                    .doc(receiverid.toString())
                    .collection("Messages")
                    .add({
                  "senderid": senderid,
                  "receiverid": receiverid,
                  "message": message,
                  "messagetype": "text",
                  "timestamp": myTimeStamp
                }).then((value) async {
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(senderid)
                      .collection("Chats")
                      .doc(receiverid.toString())
                      .collection("Messages").doc(sendingId).delete();
                  setState(() {
                    _inputKeyboradController.text = '';
                    // _scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                    // _scrollController.animateTo(
                    //     _scrollController.position.maxScrollExtent,
                    //     duration: Duration(milliseconds: 300),
                    //     curve: Curves.easeOut);
                  });
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(senderid)
                      .get()
                      .then((value) {
                    if (!value.exists) {
                      value.reference.set({"is_online": true});
                    }
                  });
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(receiverid.toString())
                      .get()
                      .then((value) {
                    if (!value.exists) {
                      value.reference.set({"is_online": false});
                    }
                  });
                  await _dio
                      .post(GET_USER_BY_ID,
                          data: jsonEncode({"userid": senderid}))
                      .then((value) async {
                    print("value = ${value}");
                    // final coordinates = new Coordinates(
                    //     myLocation.latitude, myLocation.longitude);
                    // var addresses = await Geocoder.local.findAddressesFromCoordinates(
                    //     coordinates);
                    // var first = addresses.first;

                    if (value.statusCode == 200) {
                      setState(() {
                        senderUserModel =
                            SingleUserModel.fromJson(value.data[0]);
                      });
                    }
                  });
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(receiverid.toString())
                      .collection("Chats")
                      .doc(senderid)
                      .set({
                    "bio": senderUserModel.bio,
                    "name": senderUserModel.firstname,
                    "photo_url": senderUserModel.photoUrl1,
                    "is_block":false,
                    "time_stamp": myTimeStamp,
                  }).whenComplete(() => {
                            FirebaseFirestore.instance
                                .collection("Users")
                                .doc(receiverid.toString())
                                .collection("Chats")
                                .doc(senderid)
                                .collection("Messages")
                                .add({
                              "senderid": senderid,
                              "receiverid": receiverid,
                              "message": message,
                              "messagetype": "text",
                              "timestamp": myTimeStamp
                            }).whenComplete(() => sendNotification(
                                    senderUserModel.firstname, message, "text"))
                          });
                })
              });
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  sendFileMessage(url, messageType,sendingId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderid = prefs.getInt("userid").toString();
    var receiverid = widget.userData.uerId;
    Dio _dio = Dio();
    SingleUserModel senderUserModel;
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    var myTimeStamp = DateTime.now().millisecondsSinceEpoch;
    //var message = _inputKeyboradController.text.toString().trim();
    if (url.isNotEmpty) {
      print(url);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(senderid)
          .collection("Chats")
          .doc(receiverid.toString())
          .set({
        "bio": widget.userData.bio,
        "name": widget.userData.firstname,
        "photo_url": widget.userData.photoUrl1,
        "time_stamp": myTimeStamp,
      }).whenComplete(() => {
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(senderid)
                    .collection("Chats")
                    .doc(receiverid.toString())
                    .collection("Messages")
                    .add({
                  "senderid": senderid,
                  "receiverid": receiverid,
                  "message": url,
                  "messagetype": messageType,
                  "timestamp": myTimeStamp
                }).then((value) async {
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(senderid)
                      .collection("Chats")
                      .doc(receiverid.toString())
                      .collection("Messages").doc(sendingId).delete();
                    // _scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                    // _scrollController.animateTo(
                    //     _scrollController.position.maxScrollExtent,
                    //     duration: Duration(milliseconds: 300),
                    //     curve: Curves.easeOut);
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(senderid)
                      .get()
                      .then((value) {
                    if (!value.exists) {
                      value.reference.set({"is_online": true});
                    }
                  });
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(receiverid.toString())
                      .get()
                      .then((value) {
                    if (!value.exists) {
                      value.reference.set({"is_online": false});
                    }
                  });
                  await _dio
                      .post(GET_USER_BY_ID,
                          data: jsonEncode({"userid": senderid}))
                      .then((value) async {
                    print("value = ${value}");
                    // final coordinates = new Coordinates(
                    //     myLocation.latitude, myLocation.longitude);
                    // var addresses = await Geocoder.local.findAddressesFromCoordinates(
                    //     coordinates);
                    // var first = addresses.first;

                    if (value.statusCode == 200) {
                      setState(() {
                        senderUserModel =
                            SingleUserModel.fromJson(value.data[0]);
                      });
                    }
                  });
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(receiverid.toString())
                      .collection("Chats")
                      .doc(senderid)
                      .set({
                    "bio": senderUserModel.bio,
                    "name": senderUserModel.firstname,
                    "photo_url": senderUserModel.photoUrl1,
                    "time_stamp": myTimeStamp,
                  }).whenComplete(() => {
                            FirebaseFirestore.instance
                                .collection("Users")
                                .doc(receiverid.toString())
                                .collection("Chats")
                                .doc(senderid)
                                .collection("Messages")
                                .add({
                              "senderid": senderid,
                              "receiverid": receiverid,
                              "message": url,
                              "messagetype": messageType,
                              "timestamp": myTimeStamp
                            }).whenComplete(() => sendNotification(
                                    senderUserModel.firstname, url, messageType))
                          });
                })
              });
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
    print("Message Sent");
  }

  Future<void> sendNotification(name, msg, type) async {
    var postUrl = "https://fcm.googleapis.com/fcm/send";
    DocumentSnapshot ref = await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.userData.uerId.toString())
        .get();
    print('token : ${ref.get("noti_token")}');
    String token = ref.get("noti_token");
    var sendmsg = type == "text" ? msg : "Image";
    if (type == "text") {
      print("text");
      final data = {
        "notification": {"body": sendmsg, "title": name.toString()},
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done"
        },
        "to": "$token"
      };
      final headers = {
        'content-type': 'application/json',
        'Authorization':
            'key=AAAAH8s6tEo:APA91bFaAQJuBuMC8BTF04UWCu7HGkEKzxCa7SIqTwB3LmwIIWCapnRmEIlcpSrheN41mleoUuvnO0E8CgtjL7jDRrR9P3YxZac5UABgQyFqWjsz22P0m9PrB5QQ8YAaevySlWxXVC0-'
      };

      BaseOptions options = new BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: headers,
      );

      try {
        final response = await Dio(options).post(postUrl, data: data);

        if (response.statusCode == 200) {
          print('notification sended');
        } else {
          print('notification sending failed');
// on failure do sth
        }
      } catch (e) {
        print('exception $e');
      }
    }
    else if (type == "image") {
      print("image");
      final data = {
        "notification": {
          "body": sendmsg,
          "title": name.toString(),
          "image": msg
        },
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done"
        },
        "to": "$token"
      };
      final headers = {
        'content-type': 'application/json',
        'Authorization':
            'key=AAAAH8s6tEo:APA91bFaAQJuBuMC8BTF04UWCu7HGkEKzxCa7SIqTwB3LmwIIWCapnRmEIlcpSrheN41mleoUuvnO0E8CgtjL7jDRrR9P3YxZac5UABgQyFqWjsz22P0m9PrB5QQ8YAaevySlWxXVC0-'
      };

      BaseOptions options = new BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: headers,
      );

      try {
        final response = await Dio(options).post(postUrl, data: data);

        if (response.statusCode == 200) {
          //Fluttertoast.showToast(msg: 'Request Sent To Driver');
        } else {
          print('notification sending failed');
// on failure do sth
        }
      } catch (e) {
        print('exception $e');
      }
    }
    else if (type == "audio") {
      print("image");
      final data = {
        "notification": {
          "body": sendmsg,
          "title": name.toString(),
          "image": "Sending a audio"
        },
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done"
        },
        "to": "$token"
      };
      final headers = {
        'content-type': 'application/json',
        'Authorization':
        'key=AAAAH8s6tEo:APA91bFaAQJuBuMC8BTF04UWCu7HGkEKzxCa7SIqTwB3LmwIIWCapnRmEIlcpSrheN41mleoUuvnO0E8CgtjL7jDRrR9P3YxZac5UABgQyFqWjsz22P0m9PrB5QQ8YAaevySlWxXVC0-'
      };

      BaseOptions options = new BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: headers,
      );

      try {
        final response = await Dio(options).post(postUrl, data: data);

        if (response.statusCode == 200) {
          //Fluttertoast.showToast(msg: 'Request Sent To Driver');
        } else {
          print('notification sending failed');
// on failure do sth
        }
      } catch (e) {
        print('exception $e');
      }
    }
    else if (type == "video") {
      print("image");
      final data = {
        "notification": {
          "body": sendmsg,
          "title": name.toString(),
          "image": "Sending a video"
        },
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done"
        },
        "to": "$token"
      };
      final headers = {
        'content-type': 'application/json',
        'Authorization':
        'key=AAAAH8s6tEo:APA91bFaAQJuBuMC8BTF04UWCu7HGkEKzxCa7SIqTwB3LmwIIWCapnRmEIlcpSrheN41mleoUuvnO0E8CgtjL7jDRrR9P3YxZac5UABgQyFqWjsz22P0m9PrB5QQ8YAaevySlWxXVC0-'
      };

      BaseOptions options = new BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: headers,
      );

      try {
        final response = await Dio(options).post(postUrl, data: data);

        if (response.statusCode == 200) {
          //Fluttertoast.showToast(msg: 'Request Sent To Driver');
        } else {
          print('notification sending failed');
// on failure do sth
        }
      } catch (e) {
        print('exception $e');
      }
    }
  }

  Future<void> sendAudioVideoNotification(name,type) async {
    var postUrl = "https://fcm.googleapis.com/fcm/send";
    DocumentSnapshot ref = await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.userData.uerId.toString())
        .get();
    print('token : ${ref.get("noti_token")}');
    String token = ref.get("noti_token");
    if (type == "audio") {
      final data = {
        "notification": {
          "body": "audio",
          "title": name.toString(),
          "image": "Sending a audio"
        },
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done"
        },
        "to": "$token"
      };
      final headers = {
        'content-type': 'application/json',
        'Authorization':
        'key=AAAAH8s6tEo:APA91bFaAQJuBuMC8BTF04UWCu7HGkEKzxCa7SIqTwB3LmwIIWCapnRmEIlcpSrheN41mleoUuvnO0E8CgtjL7jDRrR9P3YxZac5UABgQyFqWjsz22P0m9PrB5QQ8YAaevySlWxXVC0-'
      };

      BaseOptions options = new BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: headers,
      );

      try {
        final response = await Dio(options).post(postUrl, data: data);

        if (response.statusCode == 200) {
          //Fluttertoast.showToast(msg: 'Request Sent To Driver');
        } else {
          print('notification sending failed');
// on failure do sth
        }
      } catch (e) {
        print('exception $e');
      }
    }
    else if (type == "video") {
      print("image");
      final data = {
        "notification": {
          "body": "video",
          "title": name.toString(),
          "image": "Sending a video"
        },
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done"
        },
        "to": "$token"
      };
      final headers = {
        'content-type': 'application/json',
        'Authorization':
        'key=AAAAH8s6tEo:APA91bFaAQJuBuMC8BTF04UWCu7HGkEKzxCa7SIqTwB3LmwIIWCapnRmEIlcpSrheN41mleoUuvnO0E8CgtjL7jDRrR9P3YxZac5UABgQyFqWjsz22P0m9PrB5QQ8YAaevySlWxXVC0-'
      };

      BaseOptions options = new BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: headers,
      );

      try {
        final response = await Dio(options).post(postUrl, data: data);

        if (response.statusCode == 200) {
          //Fluttertoast.showToast(msg: 'Request Sent To Driver');
        } else {
          print('notification sending failed');
// on failure do sth
        }
      } catch (e) {
        print('exception $e');
      }
    }
  }
}
