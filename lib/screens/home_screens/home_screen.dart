import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/chat_screens/chat_screens.dart';
import 'package:afropeep/screens/event_screens/event_screen.dart';
import 'package:afropeep/screens/favourite_screens/favourite_screen.dart';
import 'package:afropeep/screens/home_screens/home_screen_details.dart';
import 'package:afropeep/screens/home_screens/main_tinder_card.dart';
import 'package:afropeep/screens/home_screens/tinder_card.dart';
import 'package:afropeep/screens/home_screens/update_choose_mode_to_start.dart';
import 'package:afropeep/screens/onboarding_screen/choose_mode_to_start_screen.dart';
import 'package:afropeep/screens/payment_screens/payment_screen.dart';
import 'package:afropeep/screens/profile_screens/myprofile_screen.dart';
import 'package:afropeep/screens/profile_screens/profile_details_screen.dart';
import 'package:afropeep/screens/match_screens/match_screen.dart';
import 'package:afropeep/screens/settings_screen/settings_main_screen.dart';
import 'package:afropeep/screens/survey/questions_screen.dart';
import 'package:afropeep/screens/user_screens/user_screen.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  String title;
  HomeScreen({this.title}) ;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _title;
  int bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: ImageIcon(
            AssetImage('assets/icons/union_icon.png'),
            size: 26
        ),

        label: '',
      ),
      BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/favourite_icon.png'),size: 26), label: ''),
      BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/chat_icon.png'),size: 26), label: ''),
      BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/rocketlunch_icon.png'),size: 26), label: ''),
      BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/person_icon.png'),size: 26), label: ''),
    ];
  }
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: [
        // HomeScreenDetails(),
        MainTinderCard(),
        MatchScreen(),
        ChatScreen(),
        PaymentScreen(),
        SettingsMainScreen()
      ],
    );
  }
  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }
  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = 'Swipe';

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setSharedValue();
    });
  }
  setSharedValue()async{
    print("called");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt('userid', 78);
    var userid =prefs.getInt('userid');
    // var userid =82;
    print("home user id = ${userid}");
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
            title: Row(
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventScreen()));
                    },
                    child:Container(
                      height: 24,
                      width: 24,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Image.asset('assets/icons/event_icon.png',height: 12,width: 12,fit: BoxFit.cover,),
                    )
                  //
                ),
                SizedBox(width: 10,),
                CustomText(
                  text: _title,
                  fontSize: 18,
                )
              ],
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            actions: [
             _title =='Swipe' ? Padding(
                padding:EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (con)=>UpdateChooseModeToStart()));
                  },
                  icon:Icon(Icons.layers)
                ),
              ):Container(),
            ],
          ),
        body: buildPageView(),
        bottomNavigationBar:Container(
          height:61,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75)
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child:  BottomNavigationBar(

              items:buildBottomNavBarItems(),
              iconSize: 40,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: ColorResources.primaryColor,
              elevation: 5.0,
              unselectedItemColor: Color(0xffACACAC),
              currentIndex: bottomSelectedIndex,
              backgroundColor: Colors.white,
              onTap: (index){
                onTabTapped(index);
                bottomTapped(index);
              },
            ),
          ),
        )
    );

  }
  void onTabTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      switch(index) {
        case 0: { _title = 'Swipe'; }
        break;
        case 1: { _title = 'Match'; }
        break;
        case 2: { _title = 'Chats'; }
        break;
        case 3: { _title = 'Payments'; }
        break;
        case 4: { _title = 'Settings'; }
        break;
      }
    });
  }
}

