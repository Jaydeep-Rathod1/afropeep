
import 'dart:convert';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/event_screens/add_event_screen.dart';
import 'package:afropeep/screens/profile_screens/edit_profile_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_models/single_user_model.dart';
import '../../models/user_models/user_model.dart';
import '../../resouces/constants.dart';
import '../../resouces/functions.dart';
class MyprofileScreen extends StatefulWidget {
  @override
  State<MyprofileScreen> createState() => _MyprofileScreenState();
}

class _MyprofileScreenState extends State<MyprofileScreen> {
  Dio _dio = Dio();
  SingleUserModel arrAllUser;
  BuildContext _mainContex;
  List<String> listofImages =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
        await getSingleUserDetails();
        await genrateListImages();
        genrateIntersts();
    });
  }
  genrateListImages(){

    if(arrAllUser.photoUrl1 != null)
      {
        listofImages.add(arrAllUser.photoUrl1);
      }
    if(arrAllUser.photoUrl2 != null)
    {
      listofImages.add(arrAllUser.photoUrl2);
    }
    if(arrAllUser.photoUrl3 != null)
    {
      listofImages.add(arrAllUser.photoUrl3);
    }
    if(arrAllUser.photoUrl4 != null)
    {
      listofImages.add(arrAllUser.photoUrl4);
    }
    if(arrAllUser.photoUrl5 != null)
    {
      listofImages.add(arrAllUser.photoUrl5);
    }
    if(arrAllUser.photoUrl6 != null)
    {
      listofImages.add(arrAllUser.photoUrl6);
    }
    print(listofImages);
  }
  getLocation(){
    // final coordinates = new Coordinates(
    //         myLocation.latitude, myLocation.longitude);
    //     var addresses = await Geocoder.local.findAddressesFromCoordinates(
    //         coordinates);
    //     var first = addresses.first;
    return "demo";
  }
  getSingleUserDetails()async{
    Apploader(_mainContex);
    Map params = Map();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid =prefs.getInt('userid');
    print(userid);
    params['userid'] = userid;
    await _dio.post(GET_USER_BY_ID,data: jsonEncode(params)).then((value) {
      print("value = ${value}");
      // final coordinates = new Coordinates(
      //     myLocation.latitude, myLocation.longitude);
      // var addresses = await Geocoder.local.findAddressesFromCoordinates(
      //     coordinates);
      // var first = addresses.first;

      if(value.statusCode == 200)
      {
        setState(() {
          arrAllUser =SingleUserModel.fromJson(value.data);
          RemoveAppLoader(_mainContex);
        });

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
          title: Row(
            children: [
              CustomText(
                text: 'My Profile',
                fontSize: 18,
              )
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),

        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 548,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(arrAllUser.photoUrl1 == null  ? 'assets/images/myprofile.png':'',width: MediaQuery.of(context).size.width,height:MediaQuery.of(context).size.height/1.2 ,fit: BoxFit.cover,),
                      // child:arrAllUser[0].photoUrl1 != null? NetworkImage(GET_IMAGES_LINK+arrAllUser[0].photoUrl1):AssetImage('assets/icons/img_user.png'),
                    ),
                    Positioned(
                        top: 20.0,
                        right: 20.0,
                        child: Column(
                          children: [
                            GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfileScreen()));
                                },
                                child:Container(
                                  height: 35,
                                  width: 35,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle
                                  ),
                                  child: Icon(Icons.edit),
                                )
                              //
                            ),
                            SizedBox(height: 10.0,),

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
                              CustomText(text:arrAllUser.firstname!=null && arrAllUser.firstname.isNotEmpty? '${arrAllUser.firstname} ${arrAllUser.lastname}, 24':"",fontSize: 18.0,color: ColorResources.whiteColor,),

                              SizedBox(height: 5.0,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on_outlined,size: 15.0,color: ColorResources.whiteColor,),
                                  SizedBox(width: 5.0,),
                                  CustomText(text: getLocation(),fontSize: 12.0,color: ColorResources.whiteColor,),
                                ],
                              )
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
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
                    CustomText(text: "5' 5''",),
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
                    CustomText(text: arrAllUser.region != null? arrAllUser.region:" ",),
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
                            Expanded(child: CustomText(text: arrAllUser.profession!=null?arrAllUser.profession:"",fontSize: 12,))
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
                                child:CustomText(text: arrAllUser.profession != null ?arrAllUser.profession:'',fontSize: 12,))
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
              SizedBox(height: 16.0,),
              Divider(),
              SizedBox(height: 17,),
              CustomText(text: 'About Me',fontSize: 14,),
              SizedBox(height: 10,),
              CustomText(text: arrAllUser.about != null ? arrAllUser.about :"",fontSize: 12,),
              SizedBox(height: 16,),
              Divider(),
              SizedBox(height: 17,),
              CustomText(text: 'Gallery',fontSize: 14,),
              SizedBox(height: 10,),
              /*GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
               *//* children: List.generate(5, (index) {
                  return  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:Image.asset('assets/images/myprofile.png',fit: BoxFit.cover,height: 138,width: 115,),
                  );
                },),*//*
                children: ListView.builder(
                    itemBuilder: (BuildContext context,int index){
                  return Container();
                }),
              ),*/
              listofImages.length>0 ? SizedBox(
                height: 150,
                child: GridView.builder(
                  gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    maxCrossAxisExtent: 5,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listofImages.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:Image.asset(listofImages[index].toString(),fit: BoxFit.cover,height: 138,width: 115,),
                      ),
                    );
                  }),
              ):Container(),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 17,),
              CustomText(text: 'Interests',fontSize: 14,),
              // genrateIntersts(),

              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 17,),
              CustomText(text: 'Contact details',fontSize: 12,),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(CupertinoIcons.phone_fill,size: 16,),
                  SizedBox(width: 8.0,),
                  CustomText(text: '+1 996 745 7890 ',fontSize: 10,),
                ],
              ),
              SizedBox(height: 18,),
              Row(
                children: [
                  Icon(CupertinoIcons.mail_solid,size: 16,),
                  SizedBox(width: 8.0,),
                  CustomText(text: 'scarlettjohansson@gmail.com',fontSize: 10,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  genrateIntersts(){
    // String intersts = arrAllUser.intrest;
    String intersts = arrAllUser.intrest;
    List<String> colors = intersts.split(',');
    print(colors);
    /*return Wrap(
      children: [
        CustomButton(
          fontSize: 12,
          backgroundColor: ColorResources.primaryColor,
          onPressed: (){},
          buttonText: 'Treking',
        ),
        SizedBox(width: 14,),
        CustomButton(
          fontSize: 12,
          backgroundColor: ColorResources.primaryColor,
          onPressed: (){},
          buttonText: 'Video Games',
        ),
        SizedBox(width: 14,),
        CustomButton(
          fontSize: 12,
          backgroundColor: ColorResources.primaryColor,
          onPressed: (){},
          buttonText: 'Dancing',
        ),
        SizedBox(width: 14,),
        CustomButton(
          fontSize: 12,
          backgroundColor: ColorResources.primaryColor,
          onPressed: (){},
          buttonText: 'Riding',
        ),
        SizedBox(width: 14,),
        CustomButton(
          fontSize: 12,
          backgroundColor: ColorResources.primaryColor,
          onPressed: (){},
          buttonText: 'Outdoor activites',
        ),
        SizedBox(width: 14,),
        CustomButton(
          fontSize: 12,
          backgroundColor: ColorResources.primaryColor,
          onPressed: (){},
          buttonText: 'Movies',
        ),

      ],
    );*/
  }
}
