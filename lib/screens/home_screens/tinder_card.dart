import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/card_provider.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
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
      getUserid();
      genrateListImages();
      // await getLocation();
      // await getAge();

    });
  }
  getAge()async {
    var dateCurrent = DateTime.now();
    var currentYear = dateCurrent.year;
    print("current year = ${currentYear}");
    //  var parsedDate = DateTime.parse(arrAllUser.birthDate);
    //  var formatDate = DateFormat("yyyy-MM-dd").format(parsedDate);
    // // var bithYear = formatDate;
    //  print("birthDate = ${formatDate}");
  }
  genrateListImages(){

    if(widget.userData.photoUrl1 != null)
    {
      listofImages.add(widget.userData.photoUrl1);
    }
    if(widget.userData.photoUrl2 != null)
    {
      listofImages.add(widget.userData.photoUrl2);
    }
    if(widget.userData.photoUrl3 != null)
    {
      listofImages.add(widget.userData.photoUrl3);
    }
    if(widget.userData.photoUrl4 != null)
    {
      listofImages.add(widget.userData.photoUrl4);
    }
    if(widget.userData.photoUrl5 != null)
    {
      listofImages.add(widget.userData.photoUrl5);
    }
    if(widget.userData.photoUrl6 != null)
    {
      listofImages.add(widget.userData.photoUrl6);
    }
    print(listofImages);
  }
  getLocation() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(widget.userData.lattitude), double.parse(widget.userData.longitude));
    print(placemarks);
    Placemark place = placemarks[0];
    var Address = '${place.subLocality}, ${place.locality}';
    setState(() {
      fullAddress = Address;
    });
  }
  getUserid()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     userid = prefs.getInt('userid');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // child:widget.isFront?  buildForntCard():scroll_visibility==false?Container():Container(),
      // child: widget.isFront ?buildForntCard():scroll_visibility?buildCard():Container(),
      // child: widget.isFront ? buildForntCard() :scroll_visibility == false ?buildCard():scroll_visibility==false?Text("if called"):buildCard(),
      // child: !widget.isFront?scroll_visibility!=true?Container():buildCard():buildForntCard(),
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
            child: Stack(
              children: [
                buildCard(),
                buildStamps()
              ],
            )
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
        provider.endPosition(widget.userData.userId);
      },
      onPanEnd: (details){
        print("on onPanEnd");
        final provider = Provider.of<CardProvider>(context,listen: false);
        provider.endPosition(widget.userData.userId);
      },
    );
  }
  Widget buildCard(){
        return  SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
               Container(
                height: MediaQuery.of(context).size.height/1.34,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              // image: AssetImage(widget.imageUrl),
                              //   image: NetworkImage("{URL::to('/')}}/uploads/userimages/16595199681789.jpg"),
                                image:widget.imageUrl !=null ?NetworkImage(GET_IMAGES_LINK+widget.imageUrl):NetworkImage(GET_IMAGES_LINK+"16595199681789.jpg"),
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
                                  provider.like(userid);
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
                                  provider.superlike(userid);
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
                                  provider.dislike(userid);
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
                                  CustomText(text: fullAddress != null ? fullAddress:"No Location",fontSize: 12.0,color: ColorResources.whiteColor,),
                                ],
                              )
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
              widget.isFront? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  CustomText(text: 'Basic',fontSize: 14,),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/stariaght_icon.png'),
                        SizedBox(width: 4,),
                        CustomText(text: 'Straight',),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.all(2),
                          child: VerticalDivider(
                            color: Color(0xff707070),
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            width: 10,
                          ),
                        ),
                        Image.asset('assets/icons/inch_icon.png',height: 16,width: 16,),
                        SizedBox(width: 4,),
                        CustomText(text: widget.userData.height != null ?widget.userData.height:"No Data",),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.all(2),
                          child: VerticalDivider(
                            color: Color(0xff707070),
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            width: 10,
                          ),
                        ),
                        Image.asset('assets/icons/world_icon.png',height: 16,width: 16,),
                        SizedBox(width: 4,),
                        CustomText(text: widget.userData.religion != null? widget.userData.religion:"No Data",),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: EdgeInsets.all(2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/bag_icon.png',height: 16,width: 16,fit: BoxFit.cover,color: ColorResources.primaryColor,),
                                SizedBox(width: 10.0,),
                                Expanded(child: CustomText(text: widget.userData.occupation!=null?widget.userData.occupation:"No Profession",fontSize: 12,))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          padding: const EdgeInsets.all(2),
                          child: VerticalDivider(
                            color: Color(0xff707070),
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            width: 10,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/education_icon.png',height: 16,width: 16,fit: BoxFit.cover,color: ColorResources.primaryColor,),
                                SizedBox(width: 10.0,),
                                Expanded(
                                    flex: 2,
                                    child:CustomText(text: widget.userData.occupation != null ?widget.userData.occupation:'No Education',fontSize: 12,))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          padding: const EdgeInsets.all(2),
                          child: VerticalDivider(
                            color: Color(0xff707070),
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            width: 10,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/book_icon.png',height: 16,width: 16,fit: BoxFit.cover,color: ColorResources.primaryColor,),
                                SizedBox(width: 10.0,),
                                Expanded(child: CustomText(text: 'Des Bâtisseurs',fontSize: 12,))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Divider(),
                  SizedBox(height: 17,),
                  CustomText(text: 'About Me',fontSize: 14,),
                  SizedBox(height: 10,),
                  CustomText(text: widget.userData.bio != null ? widget.userData.bio :"No About Details Found",fontSize: 12,),
                  SizedBox(height: 16,),
                  Divider(),
                  SizedBox(height: 17,),
                  CustomText(text: 'Gallery',fontSize: 14,),
                  SizedBox(height: 10,),
                  listofImages.length>0 ? Container(
                    height:listofImages.length>4? 300:100,
                    child: GridView.builder(
                        gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            maxCrossAxisExtent: 100,
                            mainAxisExtent: 100
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listofImages.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:Image.network(GET_IMAGES_LINK+listofImages[index].toString(),fit: BoxFit.fill,),
                          );

                        }),
                  ):Container(),
                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 17,),
                  CustomText(text: 'Interests',fontSize: 14,),
                  genrateIntersts(),




                ],
              ):Container(),
            ],
          ),
        );
  }
  /*Widget buildCard(){
    return Container(
      height: MediaQuery.of(context).size.height/1.34,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    // image: AssetImage(widget.imageUrl),
                    //   image: NetworkImage("{URL::to('/')}}/uploads/userimages/16595199681789.jpg"),
                      image:widget.imageUrl !=null ?NetworkImage(GET_IMAGES_LINK+widget.imageUrl):NetworkImage(GET_IMAGES_LINK+"16595199681789.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment(-0.3,0)
                  )
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height/5,
              right: 20.0,
              child: Column(
                children: [
                  GestureDetector(
                      onTap: (){
                        // Navigator.of(context).push(MaterialPageRoute(builder: (con)=>ItsMatchScreen()));
                        var provider = Provider.of<CardProvider>(context,listen: false);
                        provider.like(userid);
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
                        provider.superlike(userid);
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
                        provider.dislike(userid);
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
      ),
    );
  }*/
  /*Widget buildCard(){
    return  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height/1.34,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
               */
  /* ClipRRect(
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
                              // Navigator.of(context).push(MaterialPageRoute(builder: (con)=>ItsMatchScreen()));
                              var provider = Provider.of<CardProvider>(context,listen: false);
                              provider.like(userid);
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
                              provider.superlike(userid);
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
                              provider.dislike(userid);
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
                ),*/
  /*
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          // image: AssetImage(widget.imageUrl),
                          //   image: NetworkImage("{URL::to('/')}}/uploads/userimages/16595199681789.jpg"),
                            image:widget.imageUrl !=null ?NetworkImage(GET_IMAGES_LINK+widget.imageUrl):NetworkImage(GET_IMAGES_LINK+"16595199681789.jpg"),
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
                              provider.like(userid);
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
                              provider.superlike(userid);
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
                              provider.dislike(userid);
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
            ),
          ),
          SizedBox(height: 20,),
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                CustomText(text: 'Basic',fontSize: 14,),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/stariaght_icon.png'),
                      SizedBox(width: 4,),
                      CustomText(text: 'Straight',),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        child: VerticalDivider(
                          color: Color(0xff707070),
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          width: 10,
                        ),
                      ),
                      Image.asset('assets/icons/inch_icon.png',height: 16,width: 16,),
                      SizedBox(width: 4,),
                      CustomText(text: widget.userData.height ?? "",),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        child: VerticalDivider(
                          color: Color(0xff707070),
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          width: 10,
                        ),
                      ),
                      Image.asset('assets/icons/world_icon.png',height: 16,width: 16,),
                      SizedBox(width: 4,),
                      CustomText(text: widget.userData.countryName ?? "",),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/bag_icon.png',height: 16,width: 16,fit: BoxFit.cover,color: ColorResources.primaryColor,),
                              SizedBox(width: 10.0,),
                              Expanded(child: CustomText(text: widget.userData.profession ?? "None",fontSize: 12,))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.all(2),
                        child: VerticalDivider(
                          color: Color(0xff707070),
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          width: 10,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/education_icon.png',height: 16,width: 16,fit: BoxFit.cover,color: ColorResources.primaryColor,),
                              SizedBox(width: 10.0,),
                              Expanded(
                                  flex: 2,
                                  child:CustomText(text: 'University Of British Columbia',fontSize: 12,))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.all(2),
                        child: VerticalDivider(
                          color: Color(0xff707070),
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          width: 10,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/book_icon.png',height: 16,width: 16,fit: BoxFit.cover,color: ColorResources.primaryColor,),
                              SizedBox(width: 10.0,),
                              Expanded(child: CustomText(text: 'Des Bâtisseurs',fontSize: 12,))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Divider(),
                SizedBox(height: 17,),
                CustomText(text: 'About Me',fontSize: 14,),
                SizedBox(height: 10,),
                CustomText(text: widget.userData.about ?? "",fontSize: 12,),
                SizedBox(height: 16,),
                Divider(),
                SizedBox(height: 17,),
                CustomText(text: 'Gallery',fontSize: 14,),
                SizedBox(height: 10,),
                GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  shrinkWrap: true,
                  children: List.generate(5, (index) {
                    return  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:Image.asset('assets/images/gallery_1.png',fit: BoxFit.cover,height: 138,width: 115,),
                    );
                  },),
                ),
                SizedBox(height: 10,),
                Divider(),
                SizedBox(height: 17,),
                CustomText(text: 'Interests',fontSize: 14,),
                Wrap(
                  children: [
                    Row(
                      children: [

                        CustomButton(
                          fontSize: 12,
                          backgroundColor: ColorResources.primaryColor,

                          onPressed: (){},
                          buttonText: 'Treking',
                        ),
                        SizedBox(width: 14,),
                      ],
                    )

                  ],
                ),
                SizedBox(height: 10,),
               */
  /* Divider(),
                SizedBox(height: 17,),*/
  /*
               */
  /* Align(
                  alignment: Alignment.center,
                  child: CustomText(text: 'Check out my new activities on Instagram',fontSize: 12,),
                ),
                SizedBox(height: 10,),
                Align(
                    alignment: Alignment.center,
                    child:Container(
                      width: 89,
                      height: 38,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ColorResources.primaryColor,width: 2)
                      ),
                      child: CustomButton(
                        fontSize: 12,
                        backgroundColor: ColorResources.primaryColor,
                        onPressed: (){},
                        buttonText: 'Visit',
                      ),
                    )
                )*//*
              ],
            ),
          ),
        ],
      ),
    );
  }*/
  genrateIntersts(){
    if(widget.userData.intrest != null && widget.userData.intrest.isNotEmpty)
   {
     var intersts = widget.userData.intrest;
     var removedBrackets = intersts.substring(1, intersts.length - 1);
     print(removedBrackets);
     listofInterstes = removedBrackets.split(",");
     return listofInterstes.length>0?Wrap(
       spacing: 10.0,
       children: listofInterstes.map((e) {
         return CustomButton(
           fontSize: 12,
           backgroundColor: ColorResources.primaryColor,
           onPressed: (){},
           buttonText: e,
         );
       }).toList(),
     ):Text("No Interests");
   }else{
      return Text("No Interests");
    }



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




