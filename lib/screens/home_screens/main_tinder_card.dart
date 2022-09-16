import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/card_provider.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/functions.dart';
import 'package:afropeep/screens/home_screens/tinder_card.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../resouces/constants.dart';

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
  List<String> listofInterstes =[] ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        index =0;
      });
      // await getEventDetailsById();
    });
    }

  // final provider = Provider.of<CardProvider>(context);
  // final userListAll = provider.userAll;
  getAge()async {
    var dateCurrent = DateTime.now();
    var currentYear = dateCurrent.year;
    print("current year = ${currentYear}");
    //  var parsedDate = DateTime.parse(arrAllUser.birthDate);
    //  var formatDate = DateFormat("yyyy-MM-dd").format(parsedDate);
    // // var bithYear = formatDate;
    //  print("birthDate = ${formatDate}");
  }
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
    print(listofImages);
     return listofImages.length>0
         ? Container(
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
        ):Container();

  }
  var newListofInterstes = [];
  var alistofInterstes = [];
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

    return Wrap(
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
    );
  }
  genrateHeight(UserModel newUserData){
    print("height = ${newUserData.height}");
    return CustomText(text: newUserData.height != null ?newUserData.height:"No Data",);
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
                    Container(
                       height: MediaQuery.of(context).size.height/1.34,
                       width: MediaQuery.of(context).size.width,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Color(0xffffffff)
                       ),
                       child: buildCards(),
                     ),
                    // SizedBox(height: 20,),
                  ]
              ),

            )
          ),
    );
  }
  Widget buildCards(){
    final provider = Provider.of<CardProvider>(context);
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

                        Column(
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
                                  Expanded(child:Align(alignment: Alignment.center,child: CustomText(text: userSingle.height != null ?userSingle.height:"No Data",),),),
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
                                  Expanded(child:Align(alignment: Alignment.center,child: CustomText(text: userSingle.religion != null? userSingle.religion:"No Data",),),),
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
                                          Expanded(child: CustomText(text: userSingle.occupation!=null?userSingle.occupation:"No Profession",fontSize: 12,))
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
                                              child:CustomText(text: userSingle.college != null ?userSingle.college:'No Education',fontSize: 12,))
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
                                          Expanded(child: CustomText(text: userSingle.school != null ?userSingle.school:'No Data',fontSize: 12,))
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
                            CustomText(text: userSingle.bio != null ? userSingle.bio :"No About Details Found",fontSize: 12,),
                            SizedBox(height: 16,),
                            Divider(),
                            SizedBox(height: 17,),
                            CustomText(text: 'Gallery',fontSize: 14,),
                            SizedBox(height: 10,),
                            if(userSingle.photoUrl1 == null)
                              Container()
                            else
                              genrateListImages(userSingle),
                            SizedBox(height: 17,),
                            CustomText(text: 'Interests',fontSize: 14,),
                            if(userSingle.intrest != null)
                              genrateIntersts(userSingle)
                            else
                              Container()
                          ],
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );

  }

}
