import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/card_provider.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/match_screens/its_match_screen.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "dart:math" show pi;
class TinderCard extends StatefulWidget {
  var imageUrl;
  bool isFront;
  UserModel userData;
  TinderCard({Key key, this.imageUrl,this.isFront,this.userData}) : super(key: key);

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context,listen: false);
      provider.setScreenSize(size);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: widget.isFront? buildForntCard():buildCard(),
      // child: widget.isFront? Text("called build card fornt"):Text("called build main")
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
            child: buildCard(),
          );
        },
      ),
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
        final provider = Provider.of<CardProvider>(context,listen: false);
        provider.startPosition(details);
      },
      onHorizontalDragEnd: (details){
        final provider = Provider.of<CardProvider>(context,listen: false);
        provider.endPosition();
      },
      onPanEnd: (details){
        final provider = Provider.of<CardProvider>(context,listen: false);
        provider.endPosition();
      },


    );
  }
  Widget buildCard(){
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  // image: AssetImage(widget.imageUrl),
                    image: AssetImage('assets/images/user_1.png'),
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (con)=>ItsMatchScreen()));
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
                    onTap: (){},
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
                    onTap: (){},
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
                    onTap: (){},
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
                    onTap: (){},
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
                  CustomText(text:widget.userData.lastname != null && widget.userData.lastname.isNotEmpty ?widget.userData.lastname: "User${widget.userData.userId}",fontSize: 18.0,color: ColorResources.whiteColor,),
                  SizedBox(height: 5.0,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined,size: 15.0,color: ColorResources.whiteColor,),
                      SizedBox(width: 5.0,),
                      CustomText(text: 'Ottawa, Canada ',fontSize: 12.0,color: ColorResources.whiteColor,),
                    ],
                  )
                ],
              ),
            )
        ),

      ],
    );
  }
}




