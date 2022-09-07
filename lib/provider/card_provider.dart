import 'dart:convert';
import 'dart:math';

import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CardStatus{ like ,dislike,superlike}

class CardProvider extends ChangeNotifier{
  Dio _dio = Dio();
  List<String> _urlImages = [];
  List<UserModel> _urlAllList = [];
  bool _isDragging = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  double _angle = 0;

  List<String> get urlImages => _urlImages;
  List<UserModel> get userAll => _urlAllList;
  Offset get position => _position;
  bool get isDragging => _isDragging;
  double get angle => _angle;

  CardProvider(){
    resetUsers();
  }

  void setScreenSize(Size screenSize){
    _screenSize = screenSize;
  }
  void startPosition(DragStartDetails details){
    _isDragging = true;
    notifyListeners();
  }
  void updatePosition(DragUpdateDetails details){
    _position += details.delta;
    // _position += details.localPosition;
    final x = _position.dx;
    if(_position.dx >0)
    {
      print("right side");
    }
    _angle = 45 * x /_screenSize.width;
    notifyListeners();

  }
  double getStatusOpacity(){
    final delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos/delta;
    return min(opacity, 1);
  }


  void endPosition(int userid){
    _isDragging = false;
    notifyListeners();
    final status = getStatus(force: true);
    switch(status){
      case CardStatus.like:
        like(userid);
        break;
      case CardStatus.dislike:
        dislike(userid);
        break;
      case CardStatus.superlike:
        superlike(userid);
        break;
      default:
        resetPosition();
    }

  }
  void resetPosition(){
    _isDragging = false;
    _position = Offset.zero;
    _angle =0 ;
    notifyListeners();
  }

  CardStatus getStatus({bool force = false}){
    final x = _position.dx;
    final y = _position.dy;

    final forceSuperLike = x.abs() <20;
    if(force)
    {
      final delta = 100;
      if(x>= delta)
      {
        return CardStatus.like;
      }
      else if(x<= -delta)
      {
        return CardStatus.dislike;
      }
      else if(y<= -delta/2 && forceSuperLike)
      {
        return CardStatus.superlike;
      }
    }
    else{
      final delta = 20;
      if(x>= delta)
      {
        return CardStatus.like;
      }
      else if(x<= -delta)
      {
        return CardStatus.dislike;
      }
      else if(y<= -delta/2 && forceSuperLike)
      {
        return CardStatus.superlike;
      }
    }
  }

  void like(int userid){
    _angle = 20;
    _position += Offset(2*_screenSize.width/2,0);
    _nextCard();
    reuqestSendlike(userid);
    notifyListeners();
  }
  reuqestSendlike(int userid)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderid =prefs.getInt('userid');
    var receiverid = userid;
    var type = 'like';
    await requestSend(senderid,receiverid,type);
  }
  void dislike(int userid){
    _angle = -20;
    _position -= Offset(2*_screenSize.width/2,0);
    reuqestSendDislike(userid);
    _nextCard();
    notifyListeners();
  }
  reuqestSendDislike(int userid)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderid =prefs.getInt('userid');
    var receiverid = userid;
    var type = 'dislike';
    await requestSend(senderid,receiverid,type);
  }
  void superlike(int userid){
    _angle = 0;
    _position -= Offset(_screenSize.height/2,1);
    requestSendSuperLike(userid);
    _nextCard();
    notifyListeners();
  }
  requestSendSuperLike(int userid)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderid =prefs.getInt('userid');
    var receiverid = userid;
    var type = 'superlike';
    await requestSend(senderid,receiverid,type);
  }

  requestSend(senderid,receiverid,type)async{
    print("sender id = ${senderid}");
    print("reciver id = ${receiverid}");
    print("type = ${type}");
    Map<String, String> params = Map();
    params['sender_id'] = senderid.toString();
    params['receive_id'] = receiverid.toString();
    params['type'] = type.toString();
    await _dio.post(REQUEST_SEND_MATCH,data:jsonEncode(params)).then((value)async {
      if(value.statusCode == 200)
      {
        print("value = ${value.data}");
      }
    });
  }
  Future _nextCard() async{
    if(_urlAllList.isEmpty) return;
    await Future.delayed(Duration(milliseconds: 200));
    _urlAllList.removeLast();
    resetPosition();
  }
  getCardImages([String datewho,int kmnew,int minAge,int maxAge,String nationality,bool isfilter])async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var userid = prefs.getInt('userid');
    if(isfilter == true)
    {
      print("if called");
      Map params = Map();
      params['userid'] =userid;
      params["lookingfor"] =datewho;
      params['country'] = '';
      params['distance'] = '';
      await _dio.post(ALL_USER,data: jsonEncode(params)).then((value) {
        var varJson = value.data as List;
        print("All Length if called = ${varJson.length}");
        if(value.statusCode == 200)
        {
          _urlAllList =varJson.map((e) =>UserModel.fromJson(e)).toList();
          notifyListeners();
        }

      });
    }else{
      print("else called");

        await _dio.post(ALL_USER,data: {"userid":userid}).then((value) {
          var varJson = value.data as List;
          print("All Length else called= ${varJson.length}");
          if(value.statusCode == 200)
          {
            _urlAllList =varJson.map((e) =>UserModel.fromJson(e)).toList();
            notifyListeners();
          }

        });
    }

  }
  // [String datewho,int kmnew,int minAge,int maxAge,String nationality]

  void resetUsers(){
    getCardImages();
    // _urlAllList = [];
    // _urlImages = [
    //   'assets/images/user_1.png',
    //   'assets/images/myprofile.png',
    //   'assets/images/user_1.png',
    //   'assets/images/myprofile.png',
    //   'assets/images/user_1.png',
    //   'assets/images/myprofile.png',
    //   'assets/images/user_1.png',
    //   'assets/images/myprofile.png',
    //   'assets/images/user_1.png',
    // ].toList();
    notifyListeners();
  }
}