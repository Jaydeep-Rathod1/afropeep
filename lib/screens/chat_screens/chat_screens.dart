import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/chat_screens/chat_details_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (con)=>ChatDetailsScreen()));
              },
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/circle_1.png'),
                        radius:25,
                      ),
                      Positioned(
                          right: 5.0,
                          bottom: 1.0,
                          child: Icon(Icons.circle,size: 10,color: Color(0xff39AF17),)
                      )
                    ],
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Scarlett Johansson',
                              style: TextStyle(
                                color: Colors.black,

                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: '.20m ',
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 5,),
                      CustomText(text: "Yes, That's gonna work, hopefully.",color: Color(0xff707070),fontSize: 10),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.more_vert_outlined)
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/circle_2.png'),
                      radius:25,
                    ),
                    Positioned(
                        right: 5.0,
                        bottom: 1.0,
                        child: Icon(Icons.circle,size: 10,color: Color(0xff39AF17),)
                    )
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Scarlett Johansson',
                            style: TextStyle(
                              color: Colors.black,

                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: '.20m ',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomText(text: "Yes, That's gonna work, hopefully.",color: Color(0xff707070),fontSize: 10),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_vert_outlined)
              ],
            ),
            Divider(),
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/circle_3.png'),
                      radius:25,
                    ),
                    Positioned(
                        right: 5.0,
                        bottom: 1.0,
                        child: Icon(Icons.circle,size: 10,color: Color(0xff39AF17),)
                    )
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Scarlett Johansson',
                            style: TextStyle(
                              color: Colors.black,

                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: '.20m ',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomText(text: "Yes, That's gonna work, hopefully.",color: Color(0xff707070),fontSize: 10),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_vert_outlined)
              ],
            ),
            Divider(),
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/circle_4.png'),
                      radius:25,
                    ),
                    Positioned(
                        right: 5.0,
                        bottom: 1.0,
                        child: Icon(Icons.circle,size: 10,color: Color(0xff39AF17),)
                    )
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Scarlett Johansson',
                            style: TextStyle(
                              color: Colors.black,

                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: '.20m ',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomText(text: "Yes, That's gonna work, hopefully.",color: Color(0xff707070),fontSize: 10),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_vert_outlined)
              ],
            ),
            Divider(),
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/circle_5.png'),
                      radius:25,
                    ),
                    Positioned(
                        right: 5.0,
                        bottom: 1.0,
                        child: Icon(Icons.circle,size: 10,color: Color(0xff39AF17),)
                    )
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Scarlett Johansson',
                            style: TextStyle(
                              color: Colors.black,

                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: '.20m ',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomText(text: "Yes, That's gonna work, hopefully.",color: Color(0xff707070),fontSize: 10),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_vert_outlined)
              ],
            ),
            Divider(),
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/circle_6.png'),
                      radius:25,
                    ),
                    Positioned(
                        right: 5.0,
                        bottom: 1.0,
                        child: Icon(Icons.circle,size: 10,color: Color(0xffFF5D15),)
                    )
                  ],
                ),
                SizedBox(width: 10,),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Scarlett Johansson',
                            style: TextStyle(
                              color: Colors.black,

                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: '.20m ',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomText(text: "Yes, That's gonna work, hopefully.",color: Color(0xff707070),fontSize: 10),
                  ],
                ),),
                CustomButton(
                  height: 20,
                  fontSize: 12,
                  backgroundColor: ColorResources.primaryColor,
                  onPressed: (){},
                  buttonText: 'Say "Hi 👋"',
                ),

                Icon(Icons.more_vert_outlined)
              ],
            ),
            Divider(),
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/circle_6.png'),
                      radius:25,
                    ),
                    Positioned(
                        right: 5.0,
                        bottom: 1.0,
                        child: Icon(Icons.circle,size: 10,color: Color(0xffFF5D15),)
                    )
                  ],
                ),
                SizedBox(width: 10,),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Scarlett Johansson',
                            style: TextStyle(
                              color: Colors.black,

                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: '.20m ',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomText(text: "start chat with Danai Gurira.",color: ColorResources.primaryColor,fontSize: 10),
                  ],
                ),),
                CustomButton(
                  height: 20,
                  fontSize: 12,
                  backgroundColor: ColorResources.primaryColor,
                  onPressed: (){},
                  buttonText: 'New Chat',
                ),

                Icon(Icons.more_vert_outlined)
              ],
            ),
            Divider(),
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/circle_2.png'),
                      radius:25,
                    ),
                    Positioned(
                        right: 5.0,
                        bottom: 1.0,
                        child: Icon(Icons.circle,size: 10,color: Color(0xff39AF17),)
                    )
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Scarlett Johansson',
                            style: TextStyle(
                              color: Colors.black,

                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: '.20m ',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5,),
                    CustomText(text: "Yes, That's gonna work, hopefully.",color: Color(0xff707070),fontSize: 10),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_vert_outlined)
              ],
            ),
            Divider(),

          ],
        ),
      ),
    );
  }
}
