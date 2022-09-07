
import 'dart:convert';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/event_screens/add_event_screen.dart';
import 'package:afropeep/screens/profile_screens/edit_profile_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
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
  String fullAddress;
  List<String> listofInterstes ;
  var photourlmain;
  var firstname ='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
        await getSingleUserDetails();
        await genrateListImages();


        // await genrateIntersts();
    });
  }
  getAge() {
     var dateCurrent = DateTime.now();
     var currentYear = dateCurrent.year;
     print("current year = ${currentYear}");
     return currentYear.toString();
    //  var parsedDate = DateTime.parse(arrAllUser.birthDate);
    //  var formatDate = DateFormat("yyyy-MM-dd").format(parsedDate);
    // // var bithYear = formatDate;
    //  print("birthDate = ${formatDate}");
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
  getLocation()async  {
    List<Placemark> placemarks = await placemarkFromCoordinates(arrAllUser.lattitude, arrAllUser.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    var Address = '${place.subLocality}, ${place.locality}';
    setState(() {
      fullAddress = Address;
    });
    return fullAddress;
  }
  getSingleUserDetails()async{
    Apploader(_mainContex);
    Map params = Map();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid =prefs.getInt('userid');
    print("userid = ${userid}");
    params['userid'] = userid;
    await _dio.post(GET_USER_BY_ID,data: jsonEncode(params)).then((value)async {
      print("value = ${value}");
      // final coordinates = new Coordinates(
      //     myLocation.latitude, myLocation.longitude);
      // var addresses = await Geocoder.local.findAddressesFromCoordinates(
      //     coordinates);
      // var first = addresses.first;

      if(value.statusCode == 200)
      {
        setState(() {
          arrAllUser =SingleUserModel.fromJson(value.data[0]);
          photourlmain = arrAllUser.photoUrl1;
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
                      child: Image.network(arrAllUser.photoUrl1 != null && arrAllUser.photoUrl1.isNotEmpty? GET_IMAGES_LINK+arrAllUser.photoUrl1:"",width: MediaQuery.of(context).size.width,height:MediaQuery.of(context).size.height/1.2 ,fit: BoxFit.cover,),
                      // child:photourlmain != null?CachedNetworkImage(
                      //   imageUrl: GET_IMAGES_LINK+photourlmain,
                      //   imageBuilder: (context, imageProvider) => Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   height:MediaQuery.of(context).size.height/1.2 ,
                      //     decoration: BoxDecoration(
                      //       image: DecorationImage( //image size fill
                      //         image: imageProvider,
                      //         fit: BoxFit.cover,
                      //       ),
                      //     ),
                      //   ),
                      //   placeholder: (context, url) => Container(
                      //     alignment: Alignment.center,
                      //     padding: EdgeInsets.all(10),
                      //     child: CircularProgressIndicator(
                      //       color: ColorResources.primaryColor,
                      //     ), // you can add pre loader iamge as well to show loading.
                      //   ), //show progress  while loading image
                      //   errorWidget: (context, url, error) => Image.asset("assets/images/noimage.png"),
                      //   //show no iamge availalbe image on error laoding
                      // ):Container(),

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
                              CustomText(text:arrAllUser.firstname.isNotEmpty? '${arrAllUser.firstname} ${arrAllUser.lastname}, ${getAge()}':"",fontSize: 18.0,color: ColorResources.whiteColor,),
                              SizedBox(height: 5.0,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on_outlined,size: 15.0,color: ColorResources.whiteColor,),
                                  SizedBox(width: 5.0,),
                                  CustomText(text: fullAddress != null ?getLocation():"",fontSize: 12.0,color: ColorResources.whiteColor,),
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
                    CustomText(text: arrAllUser.height != null ?arrAllUser.height:"No Data",),
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
                    CustomText(text: arrAllUser.religion != null? arrAllUser.religion:"No Data",),
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
                            Expanded(child: CustomText(text: arrAllUser.occupation!=null?arrAllUser.occupation:"No Profession",fontSize: 12,))
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
                                child:CustomText(text: arrAllUser.occupation != null ?arrAllUser.occupation:'No Education',fontSize: 12,))
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
              CustomText(text: arrAllUser.bio != null ? arrAllUser.bio :"No About Details Found",fontSize: 12,),
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

              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 17,),
              CustomText(text: 'Contact details',fontSize: 12,),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(CupertinoIcons.phone_fill,size: 16,),
                  SizedBox(width: 8.0,),
                  CustomText(text: '+${arrAllUser.countryCode!= null ? arrAllUser.countryCode:''} ${arrAllUser.mobileNumber!= null ?arrAllUser.mobileNumber:''}',fontSize: 10,),
                ],
              ),
              SizedBox(height: 18,),
              Row(
                children: [
                  Icon(CupertinoIcons.mail_solid,size: 16,),
                  SizedBox(width: 8.0,),
                  CustomText(text: '${arrAllUser.emailId != null ? arrAllUser.emailId:"No Emailid Found"}',fontSize: 10,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  genrateIntersts(){
    var intersts = arrAllUser.intrest;
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
  }
}
