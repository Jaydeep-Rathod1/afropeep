import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatefulWidget {
  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/event_4.png',
                      height: MediaQuery.of(context).size.height/3,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 50.0,
                    child:Padding(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
                      ),
                    ),
                  ),
                  Positioned(
                      top: 50.0,
                      right: 0.0,
                      child:Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: Icon(Icons.edit,size: 20,),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            height: 30,
                            width: 30,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: Icon(Icons.delete,size: 20,color: Color(0xffF92626),),
                          ),
                          SizedBox(width: 20,)
                        ],
                      )
                  ),


                ],
              ),

            ],
          )
          

        ],
      )*/
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              /*decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/event_4.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),*/
            ),
            Positioned(
                top: 0.0,
                child:Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/event_4.png',
                        height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 50.0,
                      child:Padding(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
                        ),
                      ),
                    ),
                    Positioned(
                        top: 50.0,
                        right: 0.0,
                        child:Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Icon(Icons.edit,size: 20,),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              height: 30,
                              width: 30,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Icon(Icons.delete,size: 20,color: Color(0xffF92626),),
                            ),
                            SizedBox(width: 20,)
                          ],
                        )
                    ),


                  ],
                ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height/3.5,
              left: 0.0,
              right: 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        DefaultTabController(
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
                                      unselectedLabelColor: ColorResources.blackColor,
                                      tabs: [
                                        Tab(
                                          text: "Details",
                                        ),
                                        Tab(text: "Joined"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SingleChildScrollView(
                                      child: Container(
                                        height: MediaQuery.of(context).size.height*1.3,
                                        child: TabBarView(children: <Widget>[
                                          //all event tab
                                          DetailsScreen(),
                                          // my events tab
                                          JoinedScreen(),

                                        ]),
                                      ),
                                    )



                                  ],
                                ),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),
              )
            ),
          ],
        ),
      )
    );
  }
}

class DetailsScreen extends StatefulWidget {

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(text: 'Razzle Dazzle',fontSize: 20,fontWeight: FontWeight.w700,color: ColorResources.blackColor,letterSpacing: true,),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorResources.primaryColor)
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Container(
                  padding:EdgeInsets.only(left:10,right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icons/calender_icon.png',color: ColorResources.primaryColor,width: 12,height: 12,),
                          SizedBox(width: 10,),
                          CustomText(text: 'Event Date',color: ColorResources.primaryColor,fontSize: 12,)
                        ],
                      ),
                      CustomText(text: '06-23-2022',fontSize: 14,)
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  padding: const EdgeInsets.all(10),
                  child: VerticalDivider(
                    color: ColorResources.blackColor,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                    width: 10,
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: ColorResources.primaryColor,size: 15),
                          SizedBox(width: 8,),
                          CustomText(text: 'Event Date',color: ColorResources.primaryColor,fontSize: 12,)
                        ],
                      ),

                      Text(
                        '155 Queen St, Ottawa,\n ON K1P 6L1, Canada',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Divider(),
          SizedBox(height: 10,),
          CustomText(text: 'About Event',fontSize: 16,fontWeight: FontWeight.w700,color: ColorResources.blackColor,letterSpacing: true,),
          SizedBox(height: 10,),
          Container(
            child: CustomText(text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed  diam nonumy eirmod tempor invidunt ut labore et dolore  magna aliquyam erat.Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed  diam nonumy eirmod tempor invidunt ut labore et dolore  magna aliquyam erat.',),
          ),
          SizedBox(height: 10,),
          Divider(),
          SizedBox(height: 10,),
          CustomText(text: 'Host By',fontSize: 16,fontWeight: FontWeight.w700,color: ColorResources.blackColor,letterSpacing: true,),
          SizedBox(height: 14,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xffF3F3F3))
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset('assets/images/myuser.png',height: 40,),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(text: 'You',fontSize: 14,),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,size: 10,),
                        CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Divider(),
          SizedBox(height: 10,),
          Image.asset('assets/images/map_2.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height/3.5,fit: BoxFit.cover,)
        ],
      ),
    );
  }
}


class JoinedScreen extends StatefulWidget {
  @override
  State<JoinedScreen> createState() => _JoinedScreenState();
}

class _JoinedScreenState extends State<JoinedScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(text: 'Joined : 26 ',),
          Divider(),
          Row(
              children: [
                Image.asset('assets/images/circle_1.png',height: 40,),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,size: 10,),
                        CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                      ],
                    )
                  ],
                )
              ],
            ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Image.asset('assets/images/circle_1.png',height: 40,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: 'Scarlett Johansson',fontSize: 14,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size: 10,),
                      CustomText(text: 'Ottawa, Canada',fontSize: 8,)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider()


        ],
      ),
    );
  }
}
