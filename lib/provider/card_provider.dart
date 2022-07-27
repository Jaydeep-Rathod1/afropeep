import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum CardStatus{ like ,dislike,superlike}

class CardProvider extends ChangeNotifier{
  List<String> _urlImages = [];
  bool _isDragging = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  double _angle = 0;

  List<String> get urlImages => _urlImages;
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
  void endPosition(){
    _isDragging = false;
    notifyListeners();
    final status = getStatus();
    switch(status){
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superlike:
        superlike();
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

  CardStatus getStatus(){
    final x = _position.dx;
    final y = _position.dy;
    final delta = 100;
    final forceSuperLike = x.abs() <20;
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

  void like(){
    _angle = 20;
    _position += Offset(2*_screenSize.width/2,0);
    _nextCard();
    notifyListeners();
  }
  void dislike(){
    _angle = -20;
    _position -= Offset(2*_screenSize.width/2,0);
    _nextCard();
    notifyListeners();
  }
  void superlike(){
    _angle = 0;
    _position -= Offset(_screenSize.height/2,0);
    _nextCard();
    notifyListeners();
  }
  Future _nextCard() async{
    if(_urlImages.isEmpty) return;
    await Future.delayed(Duration(milliseconds: 200));
    _urlImages.removeLast();
    resetPosition();
  }

  void resetUsers(){
    _urlImages = <String>[
      'assets/images/user_1.png',
      'assets/images/myprofile.png',
      'assets/images/user_1.png',
      'assets/images/myprofile.png',
      'assets/images/user_1.png',
      'assets/images/myprofile.png',
      'assets/images/user_1.png',
      'assets/images/myprofile.png',
      'assets/images/user_1.png',

    ].reversed.toList();
    notifyListeners();
  }
}