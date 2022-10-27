import 'dart:async';

import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/card_provider.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/functions.dart';
import 'package:afropeep/screens/home_screens/tinder_card.dart';
import 'package:afropeep/screens/survey/questions_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../resouces/constants.dart';
import 'home_screen.dart';

class MainTinderCard extends StatefulWidget {
  @override
  State<MainTinderCard> createState() => _MainTinderCardState();
}

class _MainTinderCardState extends State<MainTinderCard> {
  bool _dragOverMap = false;
  GlobalKey _pointerKey = new GlobalKey();
  ScrollController scrollController = ScrollController();
  var showdata = false;
  BuildContext _mainContext;
  UserModel userSingle ;
  var index ;
  List<String> listofImages =[];
  String fullAddress;
  var isDisplaytooltip = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        index =0;
        // isDisplaytooltip = true;
      });
    });
    }

  // final provider = Provider.of<CardProvider>(context);
  // final userListAll = provider.userAll;
  genrateListImages(UserModel singleData){
    listofImages.clear();
    if(singleData.photoUrl1 != null)
    {
      listofImages.add(singleData.photoUrl1);
    }
    if(singleData.photoUrl2 != null)
    {
      listofImages.add(singleData.photoUrl2);
    }
    if(singleData.photoUrl3 != null)
    {
      listofImages.add(singleData.photoUrl3);
    }
    if(singleData.photoUrl4 != null)
    {
      listofImages.add(singleData.photoUrl4);
    }
    if(singleData.photoUrl5 != null)
    {
      listofImages.add(singleData.photoUrl5);
    }
    if(singleData.photoUrl6 != null)
    {
      listofImages.add(singleData.photoUrl6);
    }
    print("images = ${listofImages.length}");
    return Container(
      height:listofImages.length>4? 250:100,
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
            if(listofImages.asMap().containsKey(index))
              {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:Image.network(GET_IMAGES_LINK+listofImages[index].toString(),fit: BoxFit.fill,),
                );
              }else{
              return Container();
            }

          }),
    );

  }
  var newListofInterstes = [];
  var alistofInterstes = [];
  var listofInterstes =[];
  genrateIntersts(UserModel userSingle){
    setState(() {
      newListofInterstes =[];
      alistofInterstes =[];
      listofInterstes =[];
    });
    var interstsnew = userSingle.intrest;
    var removedBrackets;
    if(interstsnew != null)
    {
      removedBrackets = interstsnew.substring(1, interstsnew.length - 1);
      alistofInterstes = removedBrackets.split(",");
      print("get in= ${alistofInterstes}");
      for(int i =0; i<alistofInterstes.length;i++)
      {
        listofInterstes.add(alistofInterstes[i].replaceAll(RegExp('[^A-Za-z0-9]'), ''));
      }
    }

    for(int i = 0;i<listofInterstes.length;i++)
    {
      print(listofInterstes[i]);
      newListofInterstes.add(listofInterstes[i].trim());
    }
    setState(() {

    });

    return Container(

      child:  Wrap(
        spacing: 10.0,
        children: newListofInterstes.map((e) {
          return SizedBox(
            width: 100.0,
            child: CustomButton(
              fontSize: 12,
              backgroundColor: ColorResources.primaryColor,
              onPressed: (){},
              buttonText: e,
            ),
          );
        }).toList(),
      ),
    );
  }
  genrateHeight(UserModel newUserData){
    print("height = ${newUserData.height}");
    return CustomText(text: newUserData.height != null ?newUserData.height:"No Data",);
  }
  var bio;
  genrateBio(UserModel newUserData){
    print("bio = ${newUserData.bio}");
    bio ="";
    bio = newUserData.bio;
    if(newUserData.bio != null)
      return CustomText(text:  bio ,fontSize: 12,);
    else
      return Container();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding:EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                   /* isDisplaytooltip ==false ?GestureDetector(
                      onTap: (){

                        setState(() {
                          isDisplaytooltip = true;
                        });
                        Future.delayed(Duration(seconds: 5), (){
                          print("Executed after 5 seconds");
                          setState(() {
                            isDisplaytooltip = false;
                          });
                        });
                      },
                      child: Text("aaaa"),
                    ):Container(),
                    isDisplaytooltip ?
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 180,
                            height: 35,
                            padding: EdgeInsets.only(left: 5,right: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Row(
                              children: [
                                Text("Add Question ?"),
                                TextButton(onPressed: (){
                                  Navigator.pushReplacement(context,PageTransition(type: PageTransitionType.rightToLeft, child:  QuestionsScreen()));
                                }, child: Text("Tap"))
                              ],
                            ),
                          ),
                        )
                        :Container(),
                    isDisplaytooltip ? SizedBox(height: 20,):Container(),*/
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: MediaQuery.of(context).size.height/1.34,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Color(0xffffffff)
                        ),
                        child: buildCards(),
                      ),
                    )
                    // SizedBox(height: 20,),
                  ]
              ),

            )
          ),
    );
  }
  Widget buildCards(){
    final provider = Provider.of<CardProvider>(context);
    if(provider.isLoading == true)
      {
          return Align(
              alignment: Alignment.center,
              child: Card(
                child: Container(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: ColorResources.primaryColor,
                      ),
                      // SizedBox(height: 20,),
                      // Text("Please Wait...",style: TextStyle(color: ColorResources.primaryColor,fontSize: 10),),
                    ],
                  ),
                ),
              )
            );
      }
    final userListAll = provider.userAll;
    return userListAll.isEmpty ?
        Center(child: Text("No Images Found"),):
            Container(
          height: MediaQuery.of(context).size.height/1.34,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),

          ),
          child: ListView(
            children: [
              Stack(
             /*   children: userListAll.map((userSingle) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xfffffff)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TinderCard(
                          imageUrl: userSingle.photoUrl1,
                          isFront: userListAll.last == userSingle,
                          userData:userSingle,
                        ),

                        userListAll.last == userSingle? Column(
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
                                  userSingle.gender != null ?Expanded(child: Align(alignment: Alignment.center,child: CustomText(text: userSingle.gender,),)):Container(),
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
                                  userSingle.height != null ?Expanded(child: Align(alignment: Alignment.center,child: CustomText(text: userSingle.height,),)):Container(),
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
                                  userSingle.religion != null ?Expanded(child: Align(alignment: Alignment.center,child: CustomText(text: userSingle.religion,),)):Container(),
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
                                          Expanded(
                                              flex: 2,
                                              child:userSingle.occupation != null?CustomText(text: userSingle.occupation,fontSize: 12,):CustomText(text: "No Education",fontSize: 12,))
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
                                              child:userSingle.college != null?CustomText(text: userSingle.college,fontSize: 12,):CustomText(text: "No Education",fontSize: 12,))
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
                                          userSingle.school != null ?Expanded(child: CustomText(text: userSingle.school,fontSize: 12,)):Expanded(child: CustomText(text: 'No Data',fontSize: 12,)),
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
                            genrateBio(userSingle),
                            // userSingle.bio != null ?CustomText(text:  userSingle.bio ,fontSize: 12,):CustomText(text: "No About Details Found",fontSize: 12,),
                            SizedBox(height: 16,),
                            Divider(),
                            SizedBox(height: 17,),
                            CustomText(text: 'Gallery',fontSize: 14,),
                            SizedBox(height: 10,),
                            Container(
                              height:userSingle.photoUrl4 != null?210: 100,
                              color: Colors.white,
                              child:  genrateListImages(userSingle),
                            ),
                            SizedBox(height: 17,),
                           // genrateIntersts(userSingle)
                            CustomText(text: 'Interstes',fontSize: 14,),
                            if(userSingle.intrest!=null)
                              genrateIntersts(userSingle)
                            else
                              Container()
                          ],
                        ):Container()
                      ],
                    ),
                  );
                }).toList(),*/
                children: [
                  for(int i =0;i<userListAll.length;i++)
                    Container(
                      decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xfffffff)
                    ),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TinderCard(
                        imageUrl: userListAll[i].photoUrl1,
                        isFront: userListAll.last == userListAll[i],
                        userData:userListAll[i],
                        ),
                        userListAll.last == userListAll[i]? Column(
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
                            userListAll[i].gender != null ?Expanded(child: Align(alignment: Alignment.center,child: CustomText(text: userListAll[i].gender,),)):Container(),
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
                            userListAll[i].height != null ?Expanded(child: Align(alignment: Alignment.center,child: CustomText(text: userListAll[i].height,),)):Container(child: CustomText(text: "No data"),),
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
                            userListAll[i].religion != null ?Expanded(child: Align(alignment: Alignment.center,child: CustomText(text: userListAll[i].religion,),)):Container(child: CustomText(text: "No Data"),),
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
                                  Expanded(
                                  flex: 2,
                                     child:userListAll[i].occupation != null?CustomText(text: userListAll[i].occupation,fontSize: 12,):CustomText(text: "No Occupation",fontSize: 12,))
                                ],
                              ),
                            ),
                          ),
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
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset('assets/icons/education_icon.png',height: 16,width: 16,fit: BoxFit.cover,color: ColorResources.primaryColor,),
                              ),
                              SizedBox(width: 10.0,),
                              Align(
                                alignment: Alignment.center,
                                child: userListAll[i].college != null?CustomText(text: userListAll[i].college,fontSize: 12,):CustomText(text: "No Education",fontSize: 12,),
                              )
                              ],
                              ),
                            ),
                          ),
                         /* Container(
                          height: 100,
                          padding: const EdgeInsets.all(2),
                          child: VerticalDivider(
                          color: Color(0xff707070),
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          width: 10,
                          ),
                          ),*/
                         /* Expanded(
                          flex: 1,
                          child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Image.asset('assets/icons/book_icon.png',height: 16,width: 16,fit: BoxFit.cover,color: ColorResources.primaryColor,),
                          SizedBox(width: 10.0,),
                            userListAll[i].school != null ?Expanded(child: CustomText(text: userListAll[i].school,fontSize: 12,)):Expanded(child: CustomText(text: 'No Data',fontSize: 12,)),
                          ],
                          ),
                          ),
                          ),*/
                          ],
                          ),
                        ),
                        SizedBox(height: 16,),
                        Divider(),
                        SizedBox(height: 17,),
                        CustomText(text: 'About Me',fontSize: 14,),
                        SizedBox(height: 10,),
                        genrateBio(userListAll[i]),
                        // userSingle.bio != null ?CustomText(text:  userSingle.bio ,fontSize: 12,):CustomText(text: "No About Details Found",fontSize: 12,),
                        SizedBox(height: 16,),
                        Divider(),
                        SizedBox(height: 17,),
                        CustomText(text: 'Gallery',fontSize: 14,),
                        SizedBox(height: 10,),
                        Container(
                          height:userListAll[i].photoUrl4 != null?210: 100,
                          color: Colors.white,
                          child:  genrateListImages(userListAll[i]),
                        ),
                        SizedBox(height: 17,),
                        // genrateIntersts(userSingle)
                        CustomText(text: 'Interstes',fontSize: 14,),
                        if(userListAll[i].intrest!=null)
                        genrateIntersts(userListAll[i])
                        else
                        Container()
                        ],
                        ):Container()
                      ],
                    ),
                    )
                ],
              ),
            ],
          ),
        );
    /*        Container(
          height: MediaQuery.of(context).size.height/1.34,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),

          ),
          child: ListView(
            children: [
              Stack(
                children: userListAll.map((userSingle) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xfffffff)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TinderCard(
                          imageUrl: userSingle.photoUrl1,
                          isFront: userListAll.last == userSingle,
                          userData:userSingle,
                        ),

                        userListAll.last == userSingle? Column(
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
                                  userSingle.gender != null ?Expanded(child: Align(alignment: Alignment.center,child: CustomText(text: userSingle.gender,),)):Container(),
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
                                  userSingle.height != null ?Expanded(child: Align(alignment: Alignment.center,child: CustomText(text: userSingle.height,),)):Container(),
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
                                  userSingle.religion != null ?Expanded(child: Align(alignment: Alignment.center,child: CustomText(text: userSingle.religion,),)):Container(),
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
                                          Expanded(
                                              flex: 2,
                                              child:userSingle.occupation != null?CustomText(text: userSingle.occupation,fontSize: 12,):CustomText(text: "No Education",fontSize: 12,))
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
                                              child:userSingle.college != null?CustomText(text: userSingle.college,fontSize: 12,):CustomText(text: "No Education",fontSize: 12,))
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
                                          userSingle.school != null ?Expanded(child: CustomText(text: userSingle.school,fontSize: 12,)):Expanded(child: CustomText(text: 'No Data',fontSize: 12,)),
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
                            genrateBio(userSingle),
                            // userSingle.bio != null ?CustomText(text:  userSingle.bio ,fontSize: 12,):CustomText(text: "No About Details Found",fontSize: 12,),
                            SizedBox(height: 16,),
                            Divider(),
                            SizedBox(height: 17,),
                            CustomText(text: 'Gallery',fontSize: 14,),
                            SizedBox(height: 10,),
                            Container(
                              height:userSingle.photoUrl4 != null?210: 100,
                              color: Colors.white,
                              child:  genrateListImages(userSingle),
                            ),
                            SizedBox(height: 17,),
                           // genrateIntersts(userSingle)
                            CustomText(text: 'Interstes',fontSize: 14,),
                            if(userSingle.intrest!=null)
                              genrateIntersts(userSingle)
                            else
                              Container()
                          ],
                        ):Container()
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );*/


  }

}
