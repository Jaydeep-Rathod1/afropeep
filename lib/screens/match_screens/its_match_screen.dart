import 'package:afropeep/resouces/color_resources.dart';
import 'package:flutter/material.dart';

class ItsMatchScreen extends StatefulWidget {
  @override
  State<ItsMatchScreen> createState() => _ItsMatchScreenState();
}

class _ItsMatchScreenState extends State<ItsMatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/ItsaMatch.png',fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,);
  }
}
