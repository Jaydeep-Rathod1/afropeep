import 'package:afropeep/provider/card_provider.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/home_screens/tinder_card.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemoMainTinderCard extends StatefulWidget {
  @override
  State<DemoMainTinderCard> createState() => _DemoMainTinderCardState();
}

class _DemoMainTinderCardState extends State<DemoMainTinderCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  /*  SizedBox(height: 20,),
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
                    )*/
                ]
            ),
          )
      ),
      /* floatingActionButton: Padding(padding: EdgeInsets.only(left:40,right:40),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        padding: EdgeInsets.only(left: 20,right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red,
        ),

      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/
    );
  }
  getAllUserData(){

  }
  Widget buildCards(){
    final provider = Provider.of<CardProvider>(context);
    final urlAllUser = provider.urlImages;
    return urlAllUser.isEmpty ?
    Center(child: Text("No Images Found"),):
    SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/1.34,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: urlAllUser.map((urlImage) {
                return TinderCard(
                  imageUrl: urlImage,
                  isFront: urlAllUser.last == urlImage,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20,),
          CustomText(text: 'Basic ${urlAllUser[0]}',fontSize: 14,),
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
    );
  }
/*Widget buildCards(){
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.urlImages;
    return urlImages.isEmpty ?
        Center(child: Text("No Images Found"),):
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
        );
  }*/
}

/*

import 'package:afropeep/models/user_models/user_model.dart';
import 'package:afropeep/provider/card_provider.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/match_screens/its_match_screen.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "dart:math" show pi;
class TinderCard extends StatefulWidget {
  var imageUrl;
  final bool isFront;
  UserModel userData;
  TinderCard({Key key, this.imageUrl,this.isFront,this.userData}) : super(key: key);

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context,listen: false);
      provider.setScreenSize(size);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: widget.isFront? buildForntCard():buildCard(),
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
              child: ?buildForntCard():buildCard(),
          );

        },
      ),
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
        final provider = Provider.of<CardProvider>(context,listen: false);
        provider.startPosition(details);
      },
      onHorizontalDragEnd: (details){
        final provider = Provider.of<CardProvider>(context,listen: false);
        provider.endPosition();
      },
      onPanEnd: (details){
        final provider = Provider.of<CardProvider>(context,listen: false);
        provider.endPosition();
      },


    );
  }
  Widget buildCard(){
    return Stack(
      children: [
        ClipRRect(
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (con)=>ItsMatchScreen()));
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
                    onTap: (){},
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
                    onTap: (){},
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
    );
  }
}*/
