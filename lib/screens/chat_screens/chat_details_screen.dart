import 'package:afropeep/screens/chat_screens/audio_call_screen.dart';
import 'package:afropeep/screens/chat_screens/video_call_screen.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatDetailsScreen extends StatefulWidget {
  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // connect();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    connect();
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

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    // socket.emit("message",
    //     {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: true,
        title:Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/circle_1.png'),
                  radius:20,
                ),
                Positioned(
                    right: 5.0,
                    bottom: 0.0,
                    child: Icon(Icons.circle,size: 10,color: Color(0xff39AF17),)
                )
              ],
            ),
            SizedBox(width: 5.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // CustomText(text: 'Scarlett Johansson',fontSize: 16,),
                Text('Scarlett Johansson',overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16),),
                SizedBox(height: 2.0,),
                CustomText(text: 'Online',fontSize: 8,),
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
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoCallScreen()));
            },
            child: Icon(CupertinoIcons.videocam_fill,size: 28,),
          ),
          SizedBox(width: 5.0,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AudioCallScreen()));
            },
            child: Icon(CupertinoIcons.phone_fill,size: 20,),
          ),
          GestureDetector(
            onTap: (){},
            child: Icon(Icons.more_vert,size: 28,),
          ),
          SizedBox(width: 4.0,),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          child: Column(
            children: [
              /*Expanded(
                // height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: messages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return Container(
                        height: 70,
                      );
                    }
                    // if (messages[index].type == "source") {
                    //   return OwnMessageCard(
                    //     message: messages[index].message,
                    //     time: messages[index].time,
                    //   );
                    // } else {
                    //   return ReplyCard(
                    //     message: messages[index].message,
                    //     time: messages[index].time,
                    //   );
                    // }
                  },
                ),
              ),*/
              Expanded(
                  child: Image.asset('assets/images/conversation.png',fit: BoxFit.fill,)),
              /*Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width ,
                            child: Card(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 8),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xff707070), width: 1.0),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                controller: _controller,
                                focusNode: focusNode,
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
                                  hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                                  prefixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      show
                                          ? Icons.keyboard
                                          : Icons.emoji_emotions_outlined,
                                    ),

                                    onPressed: () {
                                      if (!show) {
                                        focusNode.unfocus();
                                        focusNode.canRequestFocus = false;
                                      }
                                      setState(() {
                                        show = !show;
                                      });
                                    },
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        iconSize: 16,
                                        icon: Icon(Icons.attach_file),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              backgroundColor:
                                              Colors.transparent,
                                              context: context,
                                              builder: (builder) => Container()
                                                  // bottomSheet()
                                          );
                                        },
                                      ),
                                      SizedBox(width: 5,),
                                      IconButton(
                                        icon: Icon(Icons.mic),
                                        iconSize: 16,
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (builder) =>
                                          //             CameraApp()));
                                        },
                                      ),
                                      SizedBox(width: 5,),
                                      Padding(
                                        padding: const EdgeInsets.only(right:10),
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Color(0xFF128C7E),
                                          child: GestureDetector(
                                            child: Image.asset('assets/icons/send_icon.png',height: 15,width: 15,),
                                            onTap: () {
                                              // if (sendButton) {
                                              //   _scrollController.animateTo(
                                              //       _scrollController
                                              //           .position.maxScrollExtent,
                                              //       duration:
                                              //       Duration(milliseconds: 300),
                                              //       curve: Curves.easeOut);
                                              //   sendMessage(
                                              //       _controller.text,
                                              //       widget.sourchat.id,
                                              //       widget.chatModel.id);
                                              //   _controller.clear();
                                              //   setState(() {
                                              //     sendButton = false;
                                              //   });
                                              // }
                                            },
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
                      Container(),
                    ],
                  ),
                ),*/
                InputWidget()

            ],
          ),
          onWillPop: () {
            if (show) {
              setState(() {
                show = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        ),
      ),

    );
  }
}
