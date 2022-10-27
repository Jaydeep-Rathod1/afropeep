import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/chat_screens/chat_details_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HomeScreenDetails extends StatefulWidget {
  @override
  State<HomeScreenDetails> createState() => _HomeScreenDetailsState();
}

class _HomeScreenDetailsState extends State<HomeScreenDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all( 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Container(
               child: Stack(
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(15),
                     child: Image.asset('assets/images/user_1.png',width: MediaQuery.of(context).size.width,height:MediaQuery.of(context).size.height/1.2 ,fit: BoxFit.cover,),
                   ),
                   Positioned(
                     top: MediaQuery.of(context).size.width/2.5,
                     right: 20.0,
                     child: Column(
                       children: [
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
                             onTap: (){
                               print("Tapped");
                               Navigator.of(context).push(MaterialPageRoute(builder: (con)=>ChatDetailsScreen()));
                             },
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
                             CustomText(text: 'Scarlett Johansson, 24',fontSize: 18.0,color: ColorResources.whiteColor,),
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
                   CustomText(text: 'Canada',),
                 ],
               ),
             ),
             SizedBox(height: 20,),
             Row(
               children: [
                 Image.asset('assets/icons/bag_icon.png',height: 16,width: 16,fit: BoxFit.cover,color: ColorResources.primaryColor,),
                 SizedBox(width: 10.0,),
                 CustomText(text: 'Fashion Designer',fontSize: 12,)
               ],
             ),
            SizedBox(height: 16.0,),
            Row(
              children: [
                Image.asset('assets/icons/education_icon.png',height: 16,width: 16,fit: BoxFit.cover,color: ColorResources.primaryColor,),
                SizedBox(width: 10.0,),
                CustomText(text: 'University Of British Columbia',fontSize: 12,)
              ],
            ),
            SizedBox(height: 16.0,),
            Row(
              children: [
                Image.asset('assets/icons/book_icon.png',height: 16,width: 16,fit: BoxFit.cover,color: ColorResources.primaryColor,),
                SizedBox(width: 10.0,),
                CustomText(text: 'Des Bâtisseurs',fontSize: 12,)
              ],
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
      )
    );
  }
}

