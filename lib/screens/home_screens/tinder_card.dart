import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/card_provider.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/chat_screens/chat_details_screen.dart';
import 'package:afropeep/screens/match_screens/its_match_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import "dart:math" show pi;

import 'package:shared_preferences/shared_preferences.dart';
class TinderCard extends StatefulWidget {
  var imageUrl;
  bool isFront;
  UserModel userData;
  TinderCard({Key key, this.imageUrl,this.isFront,this.userData}) : super(key: key);
  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  bool isDisplay = false;
  ScrollController scrollController = new ScrollController() ;
  bool scroll_visibility ;
  var userid;
  var displayScroll = false;
  var photourlmain;
  var display_backCard = false;
  List<String> listofImages =[];
  String fullAddress;
  List<String> listofInterstes ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    photourlmain = widget.imageUrl;
    scroll_visibility = true;
    scrollController.addListener(() {
      if(scrollController.offset>1.0)
      {
        scroll_visibility = false;
        print("if called = ${scroll_visibility}");
      }
      else if(scrollController.offset<1.0)
       {
         scroll_visibility = true;
         print("else called = ${scroll_visibility}");
       }
      setState(() {});
    });
      WidgetsBinding.instance.addPostFrameCallback((_) async{
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context,listen: false);
      provider.setScreenSize(size);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.isFront?buildForntCard():buildCard(),
    );
  }
  Widget buildForntCard(){
    return GestureDetector(
      child: LayoutBuilder(
        builder: (context,constraints){
          final provider = Provider.of<CardProvider>(context,listen: true);
          final position = provider.position;
          final milliseconds =provider.isDragging ? 0 :100;
          final angle = provider.angle * pi /180;
          final center = constraints.smallest.center(Offset.zero);
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx,center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx,-center.dy);
          return AnimatedContainer(
            duration: Duration(
              milliseconds:milliseconds,
            ),
            transform: rotatedMatrix..translate(position.dx,position.dy),
            curve: Curves.easeInOut,
            child:  buildCard(),
          );
        },
      ),
      onTap: (){
        print("in tap ${widget.userData.userId}");
      },
      onPanStart: (details){
        print("om pan start");
        final provider = Provider.of<CardProvider>(context,listen: false);
        provider.startPosition(details);
      },
      onPanUpdate:(details){
        print("om pan update");
        final provider = Provider.of<CardProvider>(context,listen: false);
        provider.updatePosition(details);
      },
      onHorizontalDragUpdate: (details){
        print("on onHorizontalDragUpdate");
        setState(() {
          display_backCard = true;
        });
        if (details.delta.direction > 0) {
          final provider = Provider.of<CardProvider>(context,listen: false);
          provider.updatePosition(details);
        }

        else  {
          final provider = Provider.of<CardProvider>(context,listen: false);
          provider.updatePosition(details);
        }
      },
      onHorizontalDragStart: (details){
        print("on onHorizontalDragStart");
        final provider = Provider.of<CardProvider>(context,listen: false);
        provider.startPosition(details);
      },
      onHorizontalDragEnd: (details){
        print("on onHorizontalDragEnd");
        setState(() {
          display_backCard = false;
        });
        final provider = Provider.of<CardProvider>(context,listen: false);
        // provider.endPosition(widget.userData.userId);
        provider.endPosition(widget.userData);
      },
      onPanEnd: (details){
        print("on onPanEnd");
        final provider = Provider.of<CardProvider>(context,listen: false);
        // provider.endPosition(widget.userData.userId);
        provider.endPosition(widget.userData);
      },
    );
  }
  Widget buildCard(){
    return   Container(
      height: MediaQuery.of(context).size.height/1.34,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          widget.userData.photoUrl1!=null? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    // image: AssetImage(widget.imageUrl),
                    //   image: NetworkImage("{URL::to('/')}}/uploads/userimages/16595199681789.jpg"),
                      image:NetworkImage(GET_IMAGES_LINK+widget.imageUrl),
                      fit: BoxFit.cover,
                      alignment: Alignment(-0.3,0)
                  )
              ),
            ),
          ):
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
            decoration: BoxDecoration(
            image: DecorationImage(
            // image: AssetImage(widget.imageUrl),
            //   image: NetworkImage("{URL::to('/')}}/uploads/userimages/16595199681789.jpg"),
            image: NetworkImage(GET_IMAGES_LINK+"16595199681789.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment(-0.3,0)
            )
            ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height/5,
              left: 20.0,
              child: Column(
                children: [
                  GestureDetector(
                      onTap: (){
                        // Navigator.of(context).push(MaterialPageRoute(builder: (con)=>ItsMatchScreen()));
                        var provider = Provider.of<CardProvider>(context,listen: false);
                        provider.like(userid,widget.userData);
                      },
                      child:Container(
                        height: 35,
                        width: 35,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                        ),
                        child: Image.asset('assets/icons/like_icon.png',height: 27,width: 22,fit: BoxFit.cover,),
                      )
                    //
                  ),
                  SizedBox(height: 10.0,),
                  GestureDetector(
                      onTap: (){
                        var provider = Provider.of<CardProvider>(context,listen: false);
                        provider.superlike(userid,widget.userData);
                      },
                      child:Container(
                          height: 35,
                          width: 35,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                          ),
                          child: Icon(Icons.star,color: ColorResources.primaryColor,)
                      )
                    //
                  ),
                  SizedBox(height: 10.0,),
                  GestureDetector(
                      onTap: (){
                        var provider = Provider.of<CardProvider>(context,listen: false);
                        provider.dislike(userid,widget.userData);
                      },
                      child:Container(
                          height: 35,
                          width: 35,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                          ),
                          child: Icon(Icons.close,color: ColorResources.primaryColor,)
                      )
                    //
                  ),
                  SizedBox(height: 10.0,),
                  GestureDetector(
                      onTap: (){
                        print("Tapped");
                        Navigator.of(context).push(MaterialPageRoute(builder: (con)=>ChatDetailsScreen(userData: widget.userData,)));
                      },
                      child:Container(
                        height: 35,
                        width: 35,
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                        ),
                        child: Image.asset('assets/icons/chat_icon.png',fit: BoxFit.cover,color: ColorResources.primaryColor,),
                      )
                    //
                  ),
                  SizedBox(height: 10.0,),
                  GestureDetector(
                      onTap: (){
                        var provider = Provider.of<CardProvider>(context,listen: false);
                        provider.reversePost();
                      },
                      child:Container(
                        height: 35,
                        width: 35,
                        padding: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                        ),
                        child: Image.asset('assets/icons/metro_undo_icon.png',height:30,width:20,fit: BoxFit.fill,color: ColorResources.primaryColor,),
                      )
                    //
                  ),
                ],
              )
          ),
          Positioned(
              bottom: 30.0,
              child: Padding(
                padding:EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(text:widget.userData.lastname != null && widget.userData.firstname!=null? "${widget.userData.firstname} ${widget.userData.lastname}, ${widget.userData.age}" :"User${widget.userData.uerId}",fontSize: 18.0,color: ColorResources.whiteColor,),
                    SizedBox(height: 5.0,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined,size: 15.0,color: ColorResources.whiteColor,),
                        SizedBox(width: 5.0,),
                        CustomText(text: widget.userData.address != null ? widget.userData.address:"No Location",fontSize: 12.0,color: ColorResources.whiteColor,),
                      ],
                    )
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
  Widget buildStamps(){
    var provider = Provider.of<CardProvider>(context);
    var status = provider.getStatus();
    var opacity = provider.getStatusOpacity();
    switch (status){
      case CardStatus.like:

        return Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
          alignment: Alignment.center,
          children: [
              Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
              ),
              child: Image.asset('assets/icons/like_icon.png',height: 27,width: 22,fit: BoxFit.cover,),),
          ],
        ));
      case CardStatus.dislike:
        return Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: Icon(Icons.close,color: ColorResources.primaryColor,size: 30,)),
              ],
            ));
      case CardStatus.superlike:

        return Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: Icon(Icons.star,color: ColorResources.primaryColor,size: 30,)),
              ],
            ));
      default:
        return Container();
    }
  }
  Widget buildStamp({double angle=0, Color color,String text,double opacity}){
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
      angle: angle,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color,width: 4)
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    );
  }
}




