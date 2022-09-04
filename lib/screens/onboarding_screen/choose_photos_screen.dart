
import 'dart:io';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/constants.dart';
import 'package:afropeep/screens/onboarding_screen/choose_interestes_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resouces/functions.dart';
class ChoosePhotosScreen extends StatefulWidget {

  @override
  State<ChoosePhotosScreen> createState() => _ChoosePhotosScreenState();
}

class _ChoosePhotosScreenState extends State<ChoosePhotosScreen> {
  File imageFile;
  List<File> imageList = [];
  Dio _dio = Dio();
  var pickedFile ;
  bool isLoading = false;
  void _pickedImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
          content: Text("Choose image source"),
          actions: [
            CustomButton(
              height: 40,
              width:100,
              backgroundColor: ColorResources.blackColor,
              onPressed: (){
               _getFromCamera();
              },
              buttonText: 'Camera',
              fontSize: 16.0,
              textColor: ColorResources.whiteColor,
              // width:MediaQuery.of(context).size.width,
            ),
            CustomButton(
              height: 40,
              width:100,
              backgroundColor: ColorResources.blackColor,
              onPressed: (){
                _getFromGallery();
              },
              buttonText: 'Gallery',
              fontSize: 16.0,
              textColor: ColorResources.whiteColor,
              // width:MediaQuery.of(context).size.width,
            ),
          ]
      ),
    ).then((ImageSource source) async {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           /* Visibility(visible: isLoading,
                child:Expanded(
                    child:Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor:AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    )
                ) ),*/
            const SizedBox(
              height: 47.0,
            ),
            InkWell(
                onTap: (){
                  Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight, child: null,));
                },
                child: Icon(Icons.arrow_back,color: ColorResources.whiteColor,)
            ),
            const SizedBox(
              height: 32.0,
            ),
            CustomText(text: "Add Your Photos",fontSize: 22.0,color: ColorResources.whiteColor,),
            SizedBox(height: 18.0,),
            CustomText(text: "Upload 3 photos at least ",fontSize: 18.0,color: ColorResources.whiteColor,),
            SizedBox(height: 28.0,),
            GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.5),
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                if(index == 0)
                  {
                    return GestureDetector(
                      onTap: (){
                        _pickedImage();
                      },
                      child:  Container(
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
                              Icon(Icons.camera_alt_rounded,color: ColorResources.primaryColor,size: 25,),
                              CustomText(text: "Take Photo",fontSize: 10.0,color: ColorResources.primaryColor,)
                            ],
                          ),
                        ),
                    );
                  }
                else{
                  return GenrateImageCell(index);
                }

              },
            ),


            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CustomButton(
                    height: 45,
                    backgroundColor: ColorResources.blackColor,
                    onPressed: (){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> ChoosePhotosScreen()));
                      // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChooseInterestesScreen()));

                      insertImages();
                    },
                    buttonText: 'Next',
                    fontSize: 16.0,
                    textColor: ColorResources.whiteColor,
                    width:MediaQuery.of(context).size.width,
                  )
              ),
            ),
            const SizedBox(
              height: 34,
            ),
          ],
        ),
      )
    );
  }
  insertImages()async{
    Apploader(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');

    if(imageList.length >= 3)
      {
        // _dio.options.headers = {
        //   'Content-type': 'multipart/form-data',
        // };
        FormData data = FormData.fromMap({
          "user_id":userid.toString(),
          // "user_id":"77",
          'filecount':imageList.length.toString(),
          for(int i=0;i<imageList.length;i++)
            "photo_url${i+1}": await MultipartFile.fromFile(
            imageList[i].path,
            filename: imageList[i].path.split('/').last,
            ),
          });
        print(data.fields);
         await _dio.post(ADD_IMAGE,data: data,options: Options(contentType: 'multipart/form-data')).then((value)async {
              print("called here= ${value}");
              RemoveAppLoader(context);
              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChooseInterestesScreen()));
              // Navigator.pop(context);
            });
        // imageList.forEach((element) {
        //   "photo_url${i}"
        //
        // });
      }
  }
  GenrateImageCell(index){
    print(index);
    if(index >= 1)
      {
        return Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/3.2,
              height: 138,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:ColorResources.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: imageList.asMap().containsKey(index-1) ? Image.file(imageList[index-1],fit: BoxFit.cover,height: 138,width: MediaQuery.of(context).size.width/3.2,):Icon(Icons.add,size:30),
              ),
            ),
            Positioned(
                top: 7,
                right: 8,
                child: InkWell(
                  onTap: (){
                    // print(imageList.removeAt(index));
                    imageList.removeAt(index-1);
                    setState((){});
                  },
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // Button color
                      child: Container(
                        child:imageList.asMap().containsKey(index-1) ? Icon(Icons.close,size: 16,):null,),
                    ),
                  ),
                )
            )
          ],
        );
      }



  }
  var futureImg;
  FormData formData;
  var multipartFile;
  String fileName;
/*  _getFromGallery() async {
     pickedFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
      _upload(imageFile);
    }
     Navigator.pop(context);
  }*/
  _getFromGallery() async {
    pickedFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 60,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
      _upload(imageFile);
    }
    Navigator.pop(context);
    // params['ptaskattachment'] = await MultipartFile.fromFile(arrImageList[0].path, filename:
  }

  _getFromCamera() async {
    pickedFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 60,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
      _upload(imageFile);
    }
    Navigator.pop(context);
    // params['ptaskattachment'] = await MultipartFile.fromFile(arrImageList[0].path, filename:
  }
  void _upload(File file) async {
    imageList.add(file);
   /* FormData data = FormData.fromMap({
      "user_id":userid.toString(),
      "photo_url1": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "photo_url2": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "photo_url3": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "photo_url4": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "photo_url5": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "photo_url6": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });*/

   /* await _dio.post(ADD_IMAGE,data: data).then((value)async {
      print("called = ${value}");
      Navigator.pop(context);
    });*/
  }
}

