import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/event_screens/add_event_screen.dart';
import 'package:afropeep/screens/event_screens/event_details_screen.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  TabBar get _tabBar => TabBar(
    tabs: [
      Tab(icon: Icon(Icons.flight)),
      Tab(icon: Icon(Icons.directions_transit)),
      Tab(icon: Icon(Icons.directions_car)),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child:Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title:CustomText(
              text: 'Events',
              fontSize: 18,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddEventScreen()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 18,
                  width: 18,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.whiteColor,
                  ),
                  child: Icon(
                    Icons.add,
                    color: ColorResources.primaryColor,
                    size: 18,

                  ),
                ),

                //
              ),
              SizedBox(width: 20,)
            ],

          ),
          body: SingleChildScrollView(
            child:DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Padding(
              padding: EdgeInsets.only(left:20,right: 20),
              child:Column(
                children: [
                  Column(
                    children: [
                       TabBar(
                        labelColor: ColorResources.primaryColor,

                        tabs: [
                          Tab(
                            text: "All Events",
                          ),
                          Tab(text: "My Events"),
                        ],
                      ),
                       SizedBox(
                         height: 10,
                       ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(children: <Widget>[
                            //all event tab
                            Container(
                          height: MediaQuery.of(context).size.height, //height of TabBarView
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventDetailsScreen()));
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Container(
                                          child: Image.asset(
                                            'assets/images/event_4.png',
                                            height: MediaQuery.of(context).size.height/4.5,
                                            width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                    ),
                                    Positioned(
                                      bottom: 0.0,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 25,),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CustomText(text:'Razzle Dazzle',fontSize: 14,color: ColorResources.whiteColor,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Image.asset('assets/icons/calender_icon.png',color: ColorResources.whiteColor,width: 11, fit: BoxFit.cover,),
                                                SizedBox(width: 4.0,),
                                                CustomText(text:'06-23-2022',fontSize: 10,color: ColorResources.whiteColor,),
                                                SizedBox(width: 22.0,),
                                                Icon(Icons.location_on_outlined,color: ColorResources.whiteColor,size: 11,),
                                                SizedBox(width: 4.0,),
                                                CustomText(text:'Razzle Dazzle',fontSize: 10,color: ColorResources.whiteColor,),
                                              ],
                                            ),
                                            SizedBox(height: 13.0,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15.0,),
                              GestureDetector(
                                onTap: (){},
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Container(
                                          child: Image.asset(
                                            'assets/images/event_2.png',
                                            height: MediaQuery.of(context).size.height/4.5,
                                            width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                    ),
                                    Positioned(
                                      bottom: 0.0,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 25,),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CustomText(text:'Razzle Dazzle',fontSize: 14,color: ColorResources.whiteColor,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Image.asset('assets/icons/calender_icon.png',color: ColorResources.whiteColor,width: 11, fit: BoxFit.cover,),
                                                SizedBox(width: 4.0,),
                                                CustomText(text:'06-23-2022',fontSize: 10,color: ColorResources.whiteColor,),
                                                SizedBox(width: 22.0,),
                                                Icon(Icons.location_on_outlined,color: ColorResources.whiteColor,size: 11,),
                                                SizedBox(width: 4.0,),
                                                CustomText(text:'Razzle Dazzle',fontSize: 10,color: ColorResources.whiteColor,),
                                              ],
                                            ),
                                            SizedBox(height: 13.0,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15.0,),
                              GestureDetector(
                                onTap: (){},
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Container(
                                          child: Image.asset(
                                            'assets/images/event_3.png',
                                            height: MediaQuery.of(context).size.height/4.5,
                                            width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                    ),
                                    Positioned(
                                      bottom: 0.0,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 25,),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CustomText(text:'Razzle Dazzle',fontSize: 14,color: ColorResources.whiteColor,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Image.asset('assets/icons/calender_icon.png',color: ColorResources.whiteColor,width: 11, fit: BoxFit.cover,),
                                                SizedBox(width: 4.0,),
                                                CustomText(text:'06-23-2022',fontSize: 10,color: ColorResources.whiteColor,),
                                                SizedBox(width: 22.0,),
                                                Icon(Icons.location_on_outlined,color: ColorResources.whiteColor,size: 11,),
                                                SizedBox(width: 4.0,),
                                                CustomText(text:'Razzle Dazzle',fontSize: 10,color: ColorResources.whiteColor,),
                                              ],
                                            ),
                                            SizedBox(height: 13.0,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15.0,),
                              GestureDetector(
                                onTap: (){},
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Container(
                                          child: Image.asset(
                                            'assets/images/event_1.png',
                                            height: MediaQuery.of(context).size.height/4.5,
                                            width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                    ),
                                    Positioned(
                                      bottom: 0.0,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 25,),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CustomText(text:'Razzle Dazzle',fontSize: 14,color: ColorResources.whiteColor,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Image.asset('assets/icons/calender_icon.png',color: ColorResources.whiteColor,width: 11, fit: BoxFit.cover,),
                                                SizedBox(width: 4.0,),
                                                CustomText(text:'06-23-2022',fontSize: 10,color: ColorResources.whiteColor,),
                                                SizedBox(width: 22.0,),
                                                Icon(Icons.location_on_outlined,color: ColorResources.whiteColor,size: 11,),
                                                SizedBox(width: 4.0,),
                                                CustomText(text:'Razzle Dazzle',fontSize: 10,color: ColorResources.whiteColor,),
                                              ],
                                            ),
                                            SizedBox(height: 13.0,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                       ),
                             // my events tab
                            Container(
                              height: MediaQuery.of(context).size.height, //height of TabBarView
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){},
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Container(
                                              child: Image.asset(
                                                'assets/images/event_4.png',
                                                height: MediaQuery.of(context).size.height/4.5,
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                        ),
                                        Positioned(
                                          bottom: 0.0,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 25,),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                CustomText(text:'Razzle Dazzle',fontSize: 14,color: ColorResources.whiteColor,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset('assets/icons/calender_icon.png',color: ColorResources.whiteColor,width: 11, fit: BoxFit.cover,),
                                                    SizedBox(width: 4.0,),
                                                    CustomText(text:'06-23-2022',fontSize: 10,color: ColorResources.whiteColor,),
                                                    SizedBox(width: 22.0,),
                                                    Icon(Icons.location_on_outlined,color: ColorResources.whiteColor,size: 11,),
                                                    SizedBox(width: 4.0,),
                                                    CustomText(text:'Razzle Dazzle',fontSize: 10,color: ColorResources.whiteColor,),
                                                  ],
                                                ),
                                                SizedBox(height: 13.0,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15.0,),
                                  GestureDetector(
                                    onTap: (){},
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Container(
                                              child: Image.asset(
                                                'assets/images/event_2.png',
                                                height: MediaQuery.of(context).size.height/4.5,
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                        ),
                                        Positioned(
                                          bottom: 0.0,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 25,),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                CustomText(text:'Razzle Dazzle',fontSize: 14,color: ColorResources.whiteColor,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset('assets/icons/calender_icon.png',color: ColorResources.whiteColor,width: 11, fit: BoxFit.cover,),
                                                    SizedBox(width: 4.0,),
                                                    CustomText(text:'06-23-2022',fontSize: 10,color: ColorResources.whiteColor,),
                                                    SizedBox(width: 22.0,),
                                                    Icon(Icons.location_on_outlined,color: ColorResources.whiteColor,size: 11,),
                                                    SizedBox(width: 4.0,),
                                                    CustomText(text:'Razzle Dazzle',fontSize: 10,color: ColorResources.whiteColor,),
                                                  ],
                                                ),
                                                SizedBox(height: 13.0,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15.0,),
                                  GestureDetector(
                                    onTap: (){},
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Container(
                                              child: Image.asset(
                                                'assets/images/event_3.png',
                                                height: MediaQuery.of(context).size.height/4.5,
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                        ),
                                        Positioned(
                                          bottom: 0.0,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 25,),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                CustomText(text:'Razzle Dazzle',fontSize: 14,color: ColorResources.whiteColor,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset('assets/icons/calender_icon.png',color: ColorResources.whiteColor,width: 11, fit: BoxFit.cover,),
                                                    SizedBox(width: 4.0,),
                                                    CustomText(text:'06-23-2022',fontSize: 10,color: ColorResources.whiteColor,),
                                                    SizedBox(width: 22.0,),
                                                    Icon(Icons.location_on_outlined,color: ColorResources.whiteColor,size: 11,),
                                                    SizedBox(width: 4.0,),
                                                    CustomText(text:'Razzle Dazzle',fontSize: 10,color: ColorResources.whiteColor,),
                                                  ],
                                                ),
                                                SizedBox(height: 13.0,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15.0,),
                                  GestureDetector(
                                    onTap: (){},
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Container(
                                              child: Image.asset(
                                                'assets/images/event_1.png',
                                                height: MediaQuery.of(context).size.height/4.5,
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                        ),
                                        Positioned(
                                          bottom: 0.0,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 25,),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                CustomText(text:'Razzle Dazzle',fontSize: 14,color: ColorResources.whiteColor,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset('assets/icons/calender_icon.png',color: ColorResources.whiteColor,width: 11, fit: BoxFit.cover,),
                                                    SizedBox(width: 4.0,),
                                                    CustomText(text:'06-23-2022',fontSize: 10,color: ColorResources.whiteColor,),
                                                    SizedBox(width: 22.0,),
                                                    Icon(Icons.location_on_outlined,color: ColorResources.whiteColor,size: 11,),
                                                    SizedBox(width: 4.0,),
                                                    CustomText(text:'Razzle Dazzle',fontSize: 10,color: ColorResources.whiteColor,),
                                                  ],
                                                ),
                                                SizedBox(height: 13.0,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ]),
                        ),

            

                    ],
                  ),

                ],
              ),
            ),
          )
          )
        )
    );
  }
}
