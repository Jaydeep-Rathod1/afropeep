
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ChoosePhotosScreen extends StatefulWidget {

  @override
  State<ChoosePhotosScreen> createState() => _ChoosePhotosScreenState();
}

class _ChoosePhotosScreenState extends State<ChoosePhotosScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "Add Your Photos",fontSize: 22.0,color: ColorResources.whiteColor,),
        SizedBox(height: 18.0,),
        CustomText(text: "Upload 3 photos at least ",fontSize: 18.0,color: ColorResources.whiteColor,),
        SizedBox(height: 28.0,),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width/3.2,
                    height: 138,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:ColorResources.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Icon(Icons.camera_alt_rounded,color: ColorResources.primaryColor,size: 25,),
                        ),
                        CustomText(text: "Take Photo",fontSize: 10.0,color: ColorResources.primaryColor,)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15.0,),
                Expanded(
                  child: Stack(
                      children: [
                         ClipRRect(
                           borderRadius: BorderRadius.circular(10.0),
                           child: Image.asset('assets/images/image_camera.png',fit: BoxFit.cover,height: 138,width: MediaQuery.of(context).size.width/3.2,),
                         ),
                        Positioned(
                            top: -10,
                            right: -10,
                            child: IconButton(onPressed: (){},icon: Icon(Icons.close),iconSize: 16,))
                      ],
                    )

                ),
                SizedBox(width: 15.0,),
                Expanded(
                  child: Container(
                  width: MediaQuery.of(context).size.width/3.2,
                  height: 138,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:ColorResources.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:Icon(Icons.add,size:30),
                ),)
              ],
            ),
            SizedBox(height: 14.0,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width/3.2,
                    height: 138,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:ColorResources.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Icon(Icons.add,size:30),
                  ),),
                SizedBox(width: 15.0,),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width/3.2,
                    height: 138,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:ColorResources.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Icon(Icons.add,size:30),
                  ),),
                SizedBox(width: 15.0,),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width/3.2,
                    height: 138,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:ColorResources.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Icon(Icons.add,size:30),
                  ),),
              ],
            )
          ],
        ),
       /* Expanded(
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: CustomButton(
                height: 45,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChooseInterestesScreen()));
                },
                buttonText: 'Next',
                fontSize: 16.0,
                textColor: ColorResources.whiteColor,
                width:MediaQuery.of(context).size.width,
              )
          ),
        ),*/
      ],
    );
  }
}

