import 'package:afropeep/models/user_models/call.dart';
import 'package:afropeep/provider/call_methods.dart';
import 'package:afropeep/screens/chat_screens/pickup/pickup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickupLayout extends StatefulWidget {
  final Widget scaffold;

  const PickupLayout({Key key, this.scaffold}) : super(key: key);

  @override
  _PickupLayoutState createState() => _PickupLayoutState();
}

class _PickupLayoutState extends State<PickupLayout> {
  final CallMethods callMethods = CallMethods();
  var senderid;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPref();
  }

  _loadPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      senderid = prefs.getInt("userid").toString();
    });
    print(senderid);
  }

  @override
  Widget build(BuildContext context) {
    return (senderid != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: senderid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                try{
                  Call call = Call.fromMap(snapshot.data.data());
                  if (!call.hasDialled) {
                    return PickupScreen(call: call);
                  }
                }catch(e){
                  FlutterRingtonePlayer.stop();
                  return widget.scaffold;
                }
                return Scaffold();
              }else{
                FlutterRingtonePlayer.stop();
                return widget.scaffold;
              }
            },
          )
        : Scaffold(
            body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(color: Color(0xffefefef), blurRadius: 8.0)
                ],
              ),
              alignment: Alignment.centerLeft,
              height: 65,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Please Wait...",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            )),
          ));
  }
}
