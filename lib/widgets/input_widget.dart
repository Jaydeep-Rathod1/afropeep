import 'package:afropeep/resouces/color_resources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputWidget extends StatefulWidget {
  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List messages = [];
  TextEditingController _inputKeyboradController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool emojiShowing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
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
                    controller: _inputKeyboradController,
                    focusNode: focusNode,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    minLines: 1,
                    onTap: (){
                      setState(() {
                       if( emojiShowing == true ){
                         emojiShowing != emojiShowing;
                       }
                      });
                    },
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
                            // focusNode.unfocus();
                            FocusManager.instance.primaryFocus.unfocus();
                            focusNode.canRequestFocus = false;
                              emojiShowing = !emojiShowing;

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
                            iconSize: 22,
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
                            iconSize: 24,
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
                                 // sendMessage();
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

        ],
      ),
    );
  }
  _showEmoji()async{
    return Offstage(
      offstage: !emojiShowing,
      child: SizedBox(
        height: 250,
        child: EmojiPicker(
            onEmojiSelected: (Category category, Emoji emoji) {
              _onEmojiSelected(emoji);
            },
            onBackspacePressed: _onBackspacePressed,
            config: Config(
                columns: 7,
                // Issue: https://github.com/flutter/flutter/issues/28894
                emojiSizeMax: 32 /** (Platform.isIOS ? 1.30 : 1.0)*/,
                verticalSpacing: 0,
                horizontalSpacing: 0,
                gridPadding: EdgeInsets.zero,
                initCategory: Category.RECENT,
                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: ColorResources.primaryColor,
                iconColor: Colors.grey,
                iconColorSelected: ColorResources.primaryColor,
                progressIndicatorColor: ColorResources.primaryColor,
                backspaceColor: ColorResources.primaryColor,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                showRecentsTab: true,
                recentsLimit: 28,
                replaceEmojiOnLimitExceed: false,

                noRecents: const Text(
                  'No Recents',
                  style: TextStyle(fontSize: 20, color: Colors.black26),
                  textAlign: TextAlign.center,
                ),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.CUPERTINO)),
      ),
    );
  }
  /*sendMessage()async{
    SharedPreferences prefs =
        await SharedPreferences.getInstance();
    var senderid = prefs.getInt("userid").toString();
    var receiverid = "55";
    print("senderid : ${senderid}");
    print("receiverid : ${receiverid}");

    DateTime currentPhoneDate = DateTime.now(); //DateTime
    var myTimeStamp= DateTime.now().millisecondsSinceEpoch;
    var message = _inputKeyboradController.text.toString().trim();
    if(message.isNotEmpty)
    {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(senderid)
          .collection("Chats")
          .doc(receiverid)
          .collection("Messages").add({
        "senderid":senderid,
        "receiverid":receiverid,
        "message":message,
        "messagetype":"text",
        "timestamp":myTimeStamp
      }).then((value)async{
        await FirebaseFirestore.instance.collection("Users")
            .doc(receiverid)
            .collection("Chats")
            .doc(senderid)
            .collection("Messages")
            .add({
          "senderid":senderid,
          "receiverid":receiverid,
          "message":message,
          "messagetype":"text",
          "timestamp":myTimeStamp
        }).then((value){
          _inputKeyboradController.text ='';
          // _scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
          _scrollController.animateTo(
              _scrollController
                  .position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut);
        });
      });


    }else{
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
    print("Message Sent");
  }*/
  _onEmojiSelected(Emoji emoji) {
    _inputKeyboradController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _inputKeyboradController.text.length));
  }
  _onBackspacePressed() {
    _inputKeyboradController
      ..text = _inputKeyboradController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _inputKeyboradController.text.length));
  }
}




/*
import 'package:flutter/material.dart';
import 'package:messio/config/Palette.dart';

class InputWidget extends StatelessWidget {

  final TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.face),
                color: Palette.primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Text input
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: Palette.primaryTextColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Palette.greyColor),
                ),
              ),
            ),
          ),

          // Send Message Button
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => {},
                color: Palette.primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(color: Palette.greyColor, width: 0.5)),
          color: Colors.white),
    );
  }
}*/
