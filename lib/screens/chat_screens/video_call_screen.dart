import 'dart:async';
import 'dart:io';
import 'package:afropeep/models/user_models/call.dart';
import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/call_methods.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class VideoCallScreen extends StatefulWidget {
  final Call call;
  final UserModel receiver;

  VideoCallScreen({
    @required this.call,
    this.receiver,
  });

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final CallMethods callMethods = CallMethods();
  int selectedRadioTile;

  TextEditingController textFieldController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  ScrollController _listScrollController = ScrollController();

  UserModel sender;
  String _currentUserId,now;
  bool isWriting = false;
  bool isCallerFullScreen = false;
  bool isOnSpeakers = false;
  BuildContext context1;
  bool showEmojiPicker = false;
  SharedPreferences prefs;
  StreamSubscription callStreamSubscription;

  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false,fullscreen=false,iscallconnect=false;
  int coin=0;
  bool startduration=false,isnottolk=false,visiblechat=false;
  String receiverid;
  int _remoteUid;
  Timer _timer;
  bool _localUserJoined = false;
  RtcEngine _engine;
  DateTime _lastButtonPress;
  String _pressDuration;
  Timer _ticker;
  String inputMatchId;

  @override
  void initState() {
    super.initState();
    addPostFrameCallback();
    initAgora();
    fullscreen=false;
    coin=0;
    connectiontimeout();
  }
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    print("data");
    print(state);
    switch (state) {
      case AppLifecycleState.detached:
        endCall();
        break;
    }
  }

  connectiontimeout() async{
    var _duration = new Duration(seconds: 60);
    return new Timer(_duration, endCallconnection);
  }

  void endCallconnection(){
    if(iscallconnect) {
      print("must");
    } else {
      setState(() {
        callMethods.endCall(
          call: widget.call,
        );
      });
    }
  }
  void endCall(){
    setState(() {
      callMethods.endCall(
        call: widget.call,
      );
    });
  }
  void _updateTimer() {
    final duration = DateTime.now().difference(_lastButtonPress);
    final newDuration = _formatDuration(duration);
    setState(() {
      _pressDuration = newDuration;
      print(_pressDuration);
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
    await _engine.joinChannel(Token, "newvideocallchannel", null, 0);
  }

  addPostFrameCallback() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      var senderid = prefs.getInt("userid").toString();
      callStreamSubscription = callMethods
          .callStream(uid: senderid)
          .listen((DocumentSnapshot ds) {
            print("ds.id");
            print(ds.id);
            print(ds.data());
        // defining the logic
        switch (ds.data()) {
          case null:
          // snapshot is null which means that call is hanged and documents are deleted
          //Navigator.pop(context);
            Navigator.pop(context);
            break;

          default:
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    callStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        callMethods.endCall(
          call: widget.call,
        );
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Center(
                child: isCallerFullScreen?RtcLocalView.SurfaceView():_remoteVideo(),
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: (){
                    setState(() {
                      isCallerFullScreen = !isCallerFullScreen;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 150,
                    padding: EdgeInsets.only(right: 20,top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                          child: _localUserJoined?isCallerFullScreen?_remoteVideo():RtcLocalView.SurfaceView():Image.network(GET_IMAGES_LINK + widget.call.receiverPic,fit: BoxFit.fill)
                      ),
                    ),
                  ),
                ),
              ),
              _toolbar(),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: _onSwitchCamera,
                    icon: Icon(Icons.switch_camera_outlined,color: Colors.white),iconSize: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Image.network(GET_IMAGES_LINK + widget.call.receiverPic,height: double.infinity,width: double.infinity,fit: BoxFit.fill);
    }
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  void _onSpeakers() {
    setState(() {
      isOnSpeakers = !isOnSpeakers;
    });
    _engine.setEnableSpeakerphone(isOnSpeakers);
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: _onSpeakers,
              icon:isOnSpeakers ?Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                  ),child: Image.asset("assets/icons/speakers.png")):Image.asset("assets/icons/speakers.png"),iconSize: 40,
              // icon: isOnSpeakers ?Container(
              //     height: 40,
              //     width: 40,
              //     padding: EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(40)
              //     ),child: Image.asset("assets/icons/speakers.png",color: Colors.white)):Image.asset("assets/icons/speakers.png",color: Colors.white),iconSize: 40,color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffCC0101),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: IconButton(
                onPressed: () {
                  callMethods.endCall(
                    call: widget.call,
                  );
                },
                icon: Image.asset("assets/icons/endcall.png",color: Colors.white),iconSize: 40
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: _onToggleMute,
              icon: muted ?Container( padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                  ),child: Image.asset("assets/icons/mic-off.png")):Image.asset("assets/icons/mic-off.png"),iconSize: 40,
              // icon: muted ?Container( padding: EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(40)
              //     ),child: Image.asset("assets/icons/mic-off.png",color: Colors.white)):Image.asset("assets/icons/mic-off.png",color: Colors.white),iconSize: 40,
            ),
          ),
        ],
      ),
    );
  }

}
