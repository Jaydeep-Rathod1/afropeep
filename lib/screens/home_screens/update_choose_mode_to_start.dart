import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UpdateChooseModeToStart extends StatefulWidget {
  @override
  State<UpdateChooseModeToStart> createState() => _UpdateChooseModeToStartState();
}

class _UpdateChooseModeToStartState extends State<UpdateChooseModeToStart> {
  String value ;
  bool isSelected = false;
  String selectedvalue ='modetostart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Choose Mode To Start',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: 'Choose a mode to start',fontSize: 22,color: ColorResources.blackColor,),
          SizedBox(height: 30.0,),
          GestureDetector(
            onTap: (){
              setState(() {
                // isSelected = !isSelected;
                value = "Friends";
              });
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 61,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left:30),
                decoration: BoxDecoration(
                    color: ColorResources.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xff757575))
                ),
                child: ListTile(
                  title: Text('Friends'),
                  trailing: value == 'Friends'? Icon(Icons.check_circle ,color: Colors.black,):Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
                )
            ),
          ),
          SizedBox(height: 14.0,),
          GestureDetector(
            onTap: (){
              setState(() {
                // isSelected = !isSelected;
                value = "Business";
              });
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 61,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left:30),
                decoration: BoxDecoration(
                    color: ColorResources.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xff757575))
                ),
                child: ListTile(
                  title: Text('Business'),
                  trailing: value == "Business"? Icon(Icons.check_circle ,color: Colors.black,):Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
                )
            ),
          ),
          SizedBox(height: 14.0,),
          GestureDetector(
            onTap: (){
              setState(() {
                // isSelected = !isSelected;
                value = "Dating";
              });
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 61,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left:30),
                decoration: BoxDecoration(
                    color: ColorResources.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xff757575))
                ),
                child: ListTile(
                  title: Text('Dating'),
                  trailing: value == 'Dating'? Icon(Icons.check_circle ,color: Colors.black,):Icon(Icons.check_circle_outline_rounded ,color: Colors.black,),
                )
            ),
          ),

          const SizedBox(
            height: 34,
          )
        ],
      ),
      )
    );
  }
}
