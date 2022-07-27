import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BlockScreen extends StatefulWidget {

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Block',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Row(
                   children: [
                     CircleAvatar(
                         backgroundColor: Colors.transparent,
                         child: Image.asset('assets/images/block_1.png',height: 46,width: 46,)//Text
                     ),
                     SizedBox(width: 10,),
                     Column(

                       children: [
                         CustomText(text: "Brie Larson",fontSize: 14,),
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Icon(Icons.location_on_outlined,size: 14.7,),
                             CustomText(text: 'Ottawa, Canada',fontSize: 10.0,)
                           ],
                         ),
                       ],
                     ),
                   ],
                 ),
                  CustomButton(
                      width:91,
                      height: 29,
                      fontSize: 14,
                      backgroundColor: ColorResources.blackColor,
                      onPressed: (){},
                      buttonText: 'Block',
                    ),

                ],
              ),
              SizedBox(height: 10,),
              Divider(
                height: 2,
                color: Color(0xffF3F3F3),
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/images/block_2.png',height: 46,width: 46,)//Text
                      ),
                      SizedBox(width: 10,),
                      Column(

                        children: [
                          CustomText(text: "Brie Larson",fontSize: 14,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on_outlined,size: 14.7,),
                              CustomText(text: 'Ottawa, Canada',fontSize: 10.0,)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomButton(
                    width:91,
                    height: 29,
                    fontSize: 14,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: (){},
                    buttonText: 'Block',
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Divider(
                height: 2,
                color: Color(0xffF3F3F3),
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/images/block_3.png',height: 46,width: 46,)//Text
                      ),
                      SizedBox(width: 10,),
                      Column(

                        children: [
                          CustomText(text: "Brie Larson",fontSize: 14,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on_outlined,size: 14.7,),
                              CustomText(text: 'Ottawa, Canada',fontSize: 10.0,)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomButton(
                    width:91,
                    height: 29,
                    fontSize: 14,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: (){},
                    buttonText: 'Block',
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Divider(
                height: 2,
                color: Color(0xffF3F3F3),
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/images/block_4.png',height: 46,width: 46,)//Text
                      ),
                      SizedBox(width: 10,),
                      Column(

                        children: [
                          CustomText(text: "Brie Larson",fontSize: 14,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on_outlined,size: 14.7,),
                              CustomText(text: 'Ottawa, Canada',fontSize: 10.0,)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomButton(
                    width:91,
                    height: 29,
                    fontSize: 14,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: (){},
                    buttonText: 'Block',
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Divider(
                height: 2,
                color: Color(0xffF3F3F3),
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/images/block_5.png',height: 46,width: 46,)//Text
                      ),
                      SizedBox(width: 10,),
                      Column(

                        children: [
                          CustomText(text: "Brie Larson",fontSize: 14,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on_outlined,size: 14.7,),
                              CustomText(text: 'Ottawa, Canada',fontSize: 10.0,)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomButton(
                    width:91,
                    height: 29,
                    fontSize: 14,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: (){},
                    buttonText: 'Block',
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Divider(
                height: 2,
                color: Color(0xffF3F3F3),
              ),
              SizedBox(height: 10,),

            ],
          ),
        )
      ),
    );
  }
}
