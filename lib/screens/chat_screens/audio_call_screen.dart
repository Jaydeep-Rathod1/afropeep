import 'package:flutter/material.dart';

class AudioCallScreen extends StatefulWidget {
  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //  body:  Stack(
    //    children: [
    //      Image.asset('assets/images/user_1.png',width: MediaQuery.of(context).size.width ,
    //        height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
    //      Positioned(
    //          child: Container(
    //            width: MediaQuery.of(context).size.width ,
    //              height: MediaQuery.of(context).size.height,
    //              decoration: BoxDecoration(
    //                boxShadow: [
    //                  BoxShadow(
    //                    color: Colors.grey.withOpacity(0.5),
    //                    spreadRadius: 10,
    //                    blurRadius: 5,
    //                    offset: Offset(0, 0), // changes position of shadow
    //                  ),
    //                ],
    //              ),
    //          )
    //      )
    //    ],
    //  )
    // );
    return Image.asset(
      'assets/images/Audio_Call.png',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
    );
  }
}
