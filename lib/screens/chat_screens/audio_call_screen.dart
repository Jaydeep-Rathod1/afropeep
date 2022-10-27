import 'dart:async';
import 'dart:io';
import 'package:afropeep/models/user_models/call.dart';
import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/call_methods.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class AudioCallScreen extends StatefulWidget {
  final Call call;
  final UserModel receiver;

  AudioCallScreen({
    @required this.call,
    this.receiver,
  });

  @override
  _AudioCallScreenState createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  final CallMethods callMethods = CallMethods();
  int selectedRadioTile;
  static const countdownDuration = Duration(minutes: 10);
  Duration duration = Duration();
  Timer timer;

  bool countDown =true;
  TextEditingController textFieldController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  ScrollController _listScrollController = ScrollController();

  UserModel sender;
  String _currentUserId,now;
  bool isWriting = false;
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
    reset();
    startTimer();
  }
  void reset(){
    if (countDown){
      setState(() =>
      duration = countdownDuration);
    } else{
      setState(() =>
      duration = Duration());
    }
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1),(_) => addTime());
  }

  void addTime(){
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0){
        timer?.cancel();
      } else{
        duration = Duration(seconds: seconds);

      }
    });
  }

  void stopTimer({bool resets = true}){
    if (resets){
      reset();
    }
    setState(() => timer.cancel());
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
    await [Permission.microphone].request();

    //create the engine
    _engine = await RtcEngine.create(APP_ID);
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

    await _engine.disableVideo();
    await _engine.enableAudio();
    await _engine.joinChannel(Token, "afropeep08", null, 0);
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
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final hours =twoDigits(duration.inHours);
    final minutes =twoDigits(duration.inMinutes.remainder(60));
    final seconds =twoDigits(duration.inSeconds.remainder(60));
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
              Image.network(GET_IMAGES_LINK + widget.call.receiverPic,height: double.infinity,width: double.infinity,fit: BoxFit.fill),
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xffEEEBEB).withOpacity(0.5),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                        NetworkImage(GET_IMAGES_LINK + widget.call.receiverPic),
                        radius: 100,
                      ),
                      SizedBox(height: 10,),
                      Text("calling"),
                      SizedBox(height: 5,),
                      Text(widget.call.receiverName.toUpperCase(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                      SizedBox(height: 5,),
                      Text("${hours} : ${minutes} : ${seconds}",),
                    ],
                  ),
                ),
              ),
              _toolbar()
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
      return Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
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
              icon: isOnSpeakers ?Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                  ),child: Image.asset("assets/icons/speakers.png")):Image.asset("assets/icons/speakers.png"),iconSize: 40,
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
                icon: Image.asset("assets/icons/endcall.png"),iconSize: 40,
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
            ),
          ),
        ],
      ),
    );
  }

}
