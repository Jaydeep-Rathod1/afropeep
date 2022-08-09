import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/event_screens/add_event_screen.dart';
import 'package:afropeep/screens/event_screens/all_event_screen.dart';
import 'package:afropeep/screens/event_screens/event_details_screen.dart';
import 'package:afropeep/screens/event_screens/my_event_screen.dart';
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
                            AllEventScreen(),
                             // my events tab
                            MyEventScreen(),
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
