import 'package:afropeep/provider/card_provider.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/home_screens/tinder_card.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      // print(scrollController.position >576);
      _mainContext = this.context;
      if(scrollController.offset > 20.0)
        {
          setState(() {
            showdata = true;
          });
          print(scrollController.offset);
        }
    });
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
                       child: buildCards(),
                     ),
                    SizedBox(height: 20,),
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
          child: Stack(
            children: userListAll.map((userSingle) {
              return TinderCard(
                imageUrl: userSingle.photoUrl1,
                isFront: userListAll.last == userSingle,
                userData:userSingle,
              );
            }).toList(),
          ),
        );
        /*
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/1.34,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: urlImages.map((urlImage) {
                    return TinderCard(
                      imageUrl: urlImage,
                      isFront: urlImages.last == urlImage,
                    );
                  }).toList(),
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
                    CustomText(text: 'Canada',),
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
                            Expanded(child: CustomText(text: 'Fashion Designer',fontSize: 12,))
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
              CustomText(text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed  diam nonumy eirmod tempor invidunt ut labore et dolore  magna aliquyam erat.',fontSize: 12,),
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
              ),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 17,),
              Align(
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
              )
            ],
          ),
        );*/
  }
}
