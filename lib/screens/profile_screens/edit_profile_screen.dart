import 'dart:convert';
import 'dart:io';


import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/screens/settings_screen/settings_main_screen.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import '../../models/user_models/interestes_model.dart';
import '../../models/user_models/single_user_model.dart';
import '../../resouces/constants.dart';
import '../../resouces/functions.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _eventName = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _about = TextEditingController();

  TextEditingController _yourName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _mobileNumber = TextEditingController();
  TextEditingController _mailid = TextEditingController();
  TextEditingController _height = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _region = TextEditingController();
  TextEditingController _lookingFor = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _college = TextEditingController();
  TextEditingController _school = TextEditingController();
  String dropdownvalueGender ;
  String dropdownvalueLookingFor;
  var pickedFile ;
  var pickedVideoFile;
  List<File> imageList = [];
  List<String> imageStringList = [];
  File imageFile;
  File videoFile;

  // List of items in our dropdown menu
  var lookingFor = [
    'Male',
    'Female',
    'Both',
  ];
  var myGender = [
    'Male',
    'Female',
    'Other',
  ];
  var photoErrorValidation = false;
  double km = 10;
  Dio _dio = Dio();
  SingleUserModel arrAllUser;
  BuildContext _mainContex;

  var listofImages =[];
  var oldListofImages = [];
  String fullAddress;
  List<String> listofInterstes =[];
  List selectedChoices = [];
  List<InterestModel> arrAllChoices = [];
  List<String> allChoicesget =[];
  var photourlmain;
  VideoPlayerController _videoPlayerController;
  File _video;
  var uuid = Uuid();
  String _sessionToken = "122344";
  var latitude;
  var longitude;
  bool displayAddressCard =false;
  List<Location> locations;
  void onChange(){
    if(_sessionToken == null)
    {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestions(_location.text);
  }
  List _placesList =[];
  getSuggestions(String input)async{
    String kPLACES_API_KEY = "AIzaSyAj1U4NV784fzjvERjGzevCpjKzeJQkQyk";
    String base_url = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$base_url?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken";
    var response = await _dio.get(request);
    print(response.data['predictions']);

    if(response.statusCode == 200)
    {
      setState(() {
        _placesList = response.data['predictions'];
      });
    }
    else{
      throw Exception("Failed");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      displayAddressCard = false;
    });
    _location.addListener(() {
      onChange();
    });
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getSingleUserDetails();
      genrateListImages();
      oldgenrateListImages();
      // await getLocation();
      await getAge();
      await genrateIntersts();
      await getChoiceData();
      await setEventDate();
    });
  }
  var getBirthDate;
  var newlistofInterstes;
  genrateIntersts()async{
    var interstsnew = arrAllUser.intrest;
    var removedBrackets;
    if(interstsnew != null)
    {
      removedBrackets = interstsnew.substring(1, interstsnew.length - 1);
      newlistofInterstes = removedBrackets.split(",");
      print("get in= ${newlistofInterstes}");
      for(int i =0; i<newlistofInterstes.length;i++)
        {
          listofInterstes.add(newlistofInterstes[i].replaceAll(RegExp('[^A-Za-z0-9]'), ''));

        }
    }

    for(int i = 0;i<listofInterstes.length;i++)
      {
        print(listofInterstes[i]);
        selectedChoices.add(listofInterstes[i].trim());
      }
    setState(() {

    });
  }
  setEventDate(){
    var date = arrAllUser.birthDate;
    String out = date.replaceAll("/","-");
    // DateTime newDate = DateFormat('dd-MM-yyyy - HH:mm').parse(dt);
    var format = DateFormat("dd-MM-yyyy").parse(out);
    setState(() {
      getBirthDate = format;
    });
  }
  getChoiceData()async {
    Apploader(context);
    await _dio.get(GET_INTERSET).then((value) {
      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrAllChoices =varJson.map((e) =>InterestModel.fromJson(e)).toList();
          arrAllChoices.map((e) {
            allChoicesget.add(e.intrestName);
          });
          RemoveAppLoader(context);
        });
      }
    });
  }
  _buildChoiceList() {
    List<Widget> choices = [];
    int maxSelection;
    arrAllChoices.forEach((InterestModel item) {
      choices.add(
          Container(
            height: 41,
            padding: const EdgeInsets.all(2.0),
            child: ChoiceChip(
              backgroundColor: ColorResources.primaryColor,
              label: Text(item.intrestName,style: TextStyle(color: selectedChoices.contains(item.intrestName)?ColorResources.whiteColor:ColorResources.whiteColor),),
              selected: selectedChoices.contains(item.intrestName),
              selectedColor: ColorResources.blackColor,
              onSelected: (selected) {
                if(selectedChoices.length == (maxSelection  ?? -1) && !selectedChoices.contains(item)) {
                  // onMaxSelected?.call(selectedChoices);
                } else {
                  setState(() {
                    selectedChoices.contains(item.intrestName)
                        ? selectedChoices.remove(item.intrestName)
                        : selectedChoices.add(item.intrestName);
                    // onSelectionChanged?.call(selectedChoices);
                  });
                }
              },
            ),
          ));
    });
    return choices;
  }
  getAge()async {
    var dateCurrent = DateTime.now();
    var currentYear = dateCurrent.year;
    print("current year = ${currentYear}");
    //  var parsedDate = DateTime.parse(arrAllUser.birthDate);
    //  var formatDate = DateFormat("yyyy-MM-dd").format(parsedDate);
    // // var bithYear = formatDate;
    //  print("birthDate = ${formatDate}");
  }
  oldgenrateListImages(){
    if(arrAllUser.photoUrl1 != null)
    {
      oldListofImages.add(arrAllUser.photoUrl1);
    }
    if(arrAllUser.photoUrl2 != null)
    {
      oldListofImages.add(arrAllUser.photoUrl2);
    }
    if(arrAllUser.photoUrl3 != null)
    {
      oldListofImages.add(arrAllUser.photoUrl3);
    }
    if(arrAllUser.photoUrl4 != null)
    {
      oldListofImages.add(arrAllUser.photoUrl4);
    }
    if(arrAllUser.photoUrl5 != null)
    {
      oldListofImages.add(arrAllUser.photoUrl5);
    }
    if(arrAllUser.photoUrl6 != null)
    {
      oldListofImages.add(arrAllUser.photoUrl6);
    }
    print(listofImages);
  }
  genrateListImages(){

    if(arrAllUser.photoUrl1 != null)
    {
      listofImages.add(arrAllUser.photoUrl1);
    }
    if(arrAllUser.photoUrl2 != null)
    {
      listofImages.add(arrAllUser.photoUrl2);
    }
    if(arrAllUser.photoUrl3 != null)
    {
      listofImages.add(arrAllUser.photoUrl3);
    }
    if(arrAllUser.photoUrl4 != null)
    {
      listofImages.add(arrAllUser.photoUrl4);
    }
    if(arrAllUser.photoUrl5 != null)
    {
      listofImages.add(arrAllUser.photoUrl5);
    }
    if(arrAllUser.photoUrl6 != null)
    {
      listofImages.add(arrAllUser.photoUrl6);
    }
    print(listofImages);
  }

  getSingleUserDetails()async{
    Apploader(_mainContex);
    Map params = Map();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid =prefs.getInt('userid');
    print("userid = ${userid}");
    params['userid'] = userid;
    await _dio.post(GET_USER_BY_ID,data: jsonEncode(params)).then((value)async {
      print("value = ${value}");
      // final coordinates = new Coordinates(
      //     myLocation.latitude, myLocation.longitude);
      // var addresses = await Geocoder.local.findAddressesFromCoordinates(
      //     coordinates);
      // var first = addresses.first;

      if(value.statusCode == 200)
      {
        setState(() {
          arrAllUser =SingleUserModel.fromJson(value.data[0]);
          photourlmain = arrAllUser.photoUrl1;
           setUserValues();
          RemoveAppLoader(_mainContex);
        });

      }
    });
  }
  setUserValues(){

    _yourName.text = arrAllUser.firstname!=null? arrAllUser.firstname:"";
    _lastName.text = arrAllUser.lastname!=null? arrAllUser.lastname:"";
    _mobileNumber.text = arrAllUser.mobileNumber;
    _mailid.text = arrAllUser.emailId != null ?arrAllUser.emailId:"";
    _about.text = arrAllUser.bio != null ?arrAllUser.bio:"";
    _height.text = arrAllUser.height != null ? arrAllUser.height :"";
    _dob.text = arrAllUser.birthDate != null ? arrAllUser.birthDate:"";
    _region.text = arrAllUser.religion != null ? arrAllUser.religion:"";
    dropdownvalueGender = arrAllUser.gender != null? arrAllUser.gender:"Male";
    dropdownvalueLookingFor= arrAllUser.lookingFor != null ? arrAllUser.lookingFor :"Male";
    _profession.text = arrAllUser.occupation != null? arrAllUser.occupation:"Male";
    _college.text = arrAllUser.college != null ? arrAllUser.college: "";
    _school.text = arrAllUser.school != null ? arrAllUser.school :"";
    _location.text = arrAllUser.address!= null ? arrAllUser.address:"";
    _lookingFor.text = arrAllUser.lookingFor != null?arrAllUser.lookingFor:"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Edit Profile',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24,),
              CustomText(text: 'Add Your Photos',),
              SizedBox(height: 18,),
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
                          border: Border.all(color: Colors.black)
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
              photoErrorValidation == true? CustomText(text: 'Please Choose 3 Images',):Container(),
              SizedBox(height: 30,),
              CustomText(text: 'Your Name',),
              SizedBox(height: 15,),
              CustomTextField(controller: _yourName,fontSize: 14,hintText: 'Your Name',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              SizedBox(height: 30,),
              CustomText(text: 'Last Name',),
              SizedBox(height: 15,),
              CustomTextField(controller: _lastName,fontSize: 14,hintText: 'Last Name',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              SizedBox(height: 30,),
              CustomText(text: 'Mobile Number',),
              SizedBox(height: 15,),
              CustomTextField(controller: _mobileNumber,fontSize: 14,hintText: 'Mobile Number',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              SizedBox(height: 30,),
              CustomText(text: 'Mail id',),
              SizedBox(height: 15,),
              CustomTextField(controller: _mailid,fontSize: 14,hintText: 'Mail id',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              SizedBox(height: 30,),
              CustomText(text: 'About Me',),
              SizedBox(height: 15,),
              CustomTextField(controller: _about,fontSize: 14,hintText: 'Write here',borderRadius: 30,enabledBorder: true,focusedBorder: true,onPressed:(){},maxLines: 5,),
              SizedBox(height: 30,),
              CustomText(text: 'Height',),
              SizedBox(height: 15,),
              CustomTextField(controller: _height,fontSize: 14,hintText: "Ex: 5' 5\"",borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              SizedBox(height: 30,),
              CustomText(text: 'Date of Birth',),
              SizedBox(height: 15,),
              CustomTextField(
                  controller: _dob,
                  fontSize: 14,
                  hintText: 'MM/DD/YYYY',
                  borderRadius: 30,
                  enabledBorder: true,
                  focusedBorder: true,
                  iconName: CupertinoIcons.calendar,
                  iconColor: ColorResources.blackColor,
                  onPressed:(){

                    CustomDateTimePicker();
                    FocusScope.of(context).requestFocus(new FocusNode());
                  }),
              SizedBox(height: 30,),
              CustomText(text: 'Choose your gender',),
              SizedBox(height: 15,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20,right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff757575)),
                    borderRadius: BorderRadius.circular(29)
                ),
                child: DropdownButtonHideUnderline(
                  child:  DropdownButton(
                    style: TextStyle(fontSize: 14.0,color: ColorResources.blackColor ),
                    value: dropdownvalueGender,
                    icon: const Icon(Icons.arrow_drop_down_sharp,size: 34,),
                    items: lookingFor.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,overflow: TextOverflow.ellipsis,),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownvalueGender = newValue;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 30,),
              CustomText(text: 'Interests',),
              SizedBox(height: 15,),
              Wrap(
                children: _buildChoiceList(),
              ),
              SizedBox(height: 30,),
              CustomText(text: 'Video or Audio',),
              SizedBox(height: 15,),
              Row(
                children: [
                   GestureDetector(
                     onTap: (){
                       _pickVideo();
                     },
                     child: Container(
                         width: MediaQuery.of(context).size.width/3.2,
                         height: 138,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                             color:ColorResources.whiteColor,
                             borderRadius: BorderRadius.circular(10),
                             border: Border.all(color: Color(0xff757575))
                         ),
                         child: Icon(Icons.add,size: 35,)
                     ),
                   ),
                  
                  SizedBox(width: 15.0,),
                  if (_video != null)
                    _videoPlayerController.value.isInitialized
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width:  MediaQuery.of(context).size.width/3.2,
                            height: 138,
                            child: AspectRatio(
                              aspectRatio: _videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController),
                            ),
                        )
                        : Container(),
                  SizedBox(width: 15.0,),

                ],
              ),
              SizedBox(height: 30,),
              CustomText(text: 'Your Location',),
              SizedBox(height: 15,),
              CustomTextField(controller: _location,fontSize: 14,hintText: 'Choose Location',borderRadius: 30,enabledBorder: true,focusedBorder: true,iconName: Icons.location_on_outlined,iconColor: ColorResources.blackColor,onPressed:(){
               setState(() {
                 displayAddressCard = true;
               });
              }),
              Visibility(
                  visible: displayAddressCard,
                  child: Container(
                    height: 150,
                    width: 300,
                    child: Card(
                        child: ListView.builder(
                            itemCount: _placesList.length,
                            padding: EdgeInsets.all(10),
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: ()async{
                                  // List<Location> locations = await
                                  locations = await locationFromAddress(_placesList[index]['description']);
                                  print(locations.last.longitude);
                                  print(locations.last.latitude);
                                  print(locations.toString());
                                  setState(() {
                                    getAddressFromLatLng();
                                    _location.text = _placesList[index]['description'].toString();
                                    displayAddressCard = false;

                                  });
                                  /* List<Placemark> placemarks = await placemarkFromCoordinates(
                                        locations.last.longitude,
                                        locations.last.latitude
                                    ).then((value) {

                                    });*/
                                  // Placemark place = placemarks[0];


                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(_placesList[index]['description']),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              );
                            })

                    ),
                  )),
              SizedBox(height: 30,),
              CustomText(text: 'Region',),
              SizedBox(height: 15,),
              CustomTextField(controller: _region,fontSize: 14,hintText: 'Choose Region',borderRadius: 30,enabledBorder: true,focusedBorder: true,onPressed:(){}),
              SizedBox(height: 30,),
              CustomText(text: 'Looking For',),
              SizedBox(height: 15,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20,right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff757575)),
                    borderRadius: BorderRadius.circular(29)
                ),
                child: DropdownButtonHideUnderline(
                  child:  DropdownButton(
                    style: TextStyle(fontSize: 14.0,color: ColorResources.blackColor ),
                    value: dropdownvalueLookingFor,
                    icon: const Icon(Icons.arrow_drop_down_sharp,size: 34,),
                    items: myGender.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,overflow: TextOverflow.ellipsis,),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      print(newValue);
                      setState(() {
                        dropdownvalueLookingFor = newValue;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 30,),
              CustomText(text: 'Distance',fontSize: 12,),
              SizedBox(height: 17,),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1,color: Color(0xffABABAB)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left:10),
                          child:CustomText(text: 'Up to 26Km ',fontSize: 12,),),
                        Slider(
                          label: "Select Age",
                          value: km,
                          onChanged: (value) {
                            setState(() {
                              km = value;
                            });
                          },
                          min: 5,
                          max: 100,
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 30,),
              CustomText(text: 'Your Profession',),
              SizedBox(height: 15,),
              CustomTextField(controller: _profession,fontSize: 14,hintText: 'Your Profession',borderRadius: 30,enabledBorder: true,focusedBorder: true,onPressed:(){}),
              SizedBox(height: 30,),
              CustomText(text: 'College',),
              SizedBox(height: 15,),
              CustomTextField(controller: _college,fontSize: 14,hintText: 'Choose College',borderRadius: 30,enabledBorder: true,focusedBorder: true,onPressed:(){}),
              SizedBox(height: 30,),
              CustomText(text: 'School',),
              SizedBox(height: 15,),
              CustomTextField(controller: _school,fontSize: 14,hintText: 'Choose School',borderRadius: 30,enabledBorder: true,focusedBorder: true,onPressed:(){}),
              SizedBox(height: 26,),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                    height: 45,
                    buttonText: 'Cancel',
                    onPressed: (){},
                    backgroundColor: Color(0xffEFEFEF),
                    textColor: ColorResources.blackColor,
                      fontSize: 16,
                  ),),
                  SizedBox(width: 14,),
                  Expanded(child:
                  CustomButton(
                    buttonText: 'Submit',
                    height: 45,
                    onPressed: (){
                      updateUserData();
                    },
                    backgroundColor: ColorResources.blackColor,
                    fontSize: 16,
                  ))
                ],
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
  DateTime newpickedDate;
  CustomDateTimePicker()async{
    print("called");
    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate:newpickedDate != null? newpickedDate:DateTime.now().subtract(Duration(days: 1)),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().subtract(Duration(days: 1)));
    if (pickedDate != null) {
      setState(() {
        newpickedDate = pickedDate;
      });
      String date =
      DateFormat('dd').format(pickedDate);
      String month =
      DateFormat('MM').format(pickedDate);
      String year =
      DateFormat('yyyy').format(pickedDate);
      // 10/08/2022

      setState(() {
        _dob.text = "${date}/${month}/${year}";//set output date to TextField value.
      });
    } else {}
  }
  GenrateImageCell(index){
    print(index);
    print("called here");
    if(index>=1)
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
                border: Border.all(color: Colors.black),
              ),
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: listofImages.asMap().containsKey(index-1)
                ?
                // listofImages[index-1].runtimeType.toString() == "String"? Text("STRING"):Text("File")
                listofImages[index-1].runtimeType.toString() == "String"? Image.network(GET_IMAGES_LINK+listofImages[index-1],fit: BoxFit.cover,height: 138,width: MediaQuery.of(context).size.width/3.2,): Image.file(listofImages[index-1],fit: BoxFit.cover,height: 138,width: MediaQuery.of(context).size.width/3.2,)

                :Icon(Icons.add,size:30),
              ),
            ),
            Positioned(
                top: 7,
                right: 8,
                child: InkWell(
                  onTap: (){
                    // print(imageList.removeAt(index));
                    listofImages.removeAt(index-1);
                    setState((){});
                  },
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // Button color
                      child: Container(
                        child:listofImages.asMap().containsKey(index-1) ? Icon(Icons.close,size: 16,):null,),
                    ),
                  ),
                )
            )
          ],
        );

      }
  }
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
  _pickVideo()async{
    pickedVideoFile = await ImagePicker.pickVideo(
        source: ImageSource.gallery
    );
    _video = File(pickedVideoFile.path);

    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        // _videoPlayerController.play();
      });

    // _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
    //   setState(() { });
    //   _videoPlayerController.play();
    // });
  }
  void _upload(File file) async {
    print(file.runtimeType);
    listofImages.add(file);

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
  var newlatitude;
  var newlongitude;
  String currentAddress;
  getAddressFromLatLng() async {
    try {
      setState(() {
        newlatitude = locations.last.latitude;
        newlongitude = locations.last.longitude;
      });
      List<Placemark> placemarks = await placemarkFromCoordinates(
          newlatitude,
          newlongitude
      );

      Placemark place = placemarks[0];


      setState(() {
        currentAddress = "${place.locality}, ${place.subLocality}";
      });
      print("current address = ${currentAddress}");
      // return CustomText(text:currentAddress,fontSize: 10,color: ColorResources.whiteColor,);

    } catch (e) {
      print(e);
    }
  }
  updateUserData()async{

    await seprateImageAndString();

    SharedPreferences pres = await SharedPreferences.getInstance();
    var userid =pres.getInt('userid');
    FormData data = FormData.fromMap({
    'username':_yourName.text.toString(),
    'lastname':_lastName.text.toString(),
    'number': _mobileNumber.text.toString(),
    'mail': _mailid.text.toString(),
    'aboutme': _about.text.toString(),
    'height': int.parse(_height.text.toString()),
    'bdate': _dob.text.toString(),
    'gender': dropdownvalueGender,
    'intrest': selectedChoices,
    'latitude':newlatitude != null ? newlatitude.toString():arrAllUser.lattitude,
    'longitude':newlongitude != null ? newlongitude.toString():arrAllUser.longitude,
    'address':currentAddress != null?currentAddress: _location.text.toString(),
    'region': _region.text.toString(),
    'lookingfor ': dropdownvalueLookingFor,
    'distance': km,
    'profession': _profession.text.toString(),
    'college': _college.text.toString(),
    'school': _school.text.toString(),
    'userid': userid,
    if(oldListofImages.isNotEmpty)
      for(int i= 0;i<oldListofImages.length;i++)
        "photo_url${i+1}":oldListofImages[i],

    if(listofImages.isNotEmpty)
      for(int i= 0;i<listofImages.length;i++)

         if(listofImages[i].runtimeType.toString() != 'String')
          'nphoto_url${i+1}' : await MultipartFile.fromFile(
            listofImages[i].path,
              filename: listofImages[i].path.split('/').last,
          ),



 /*   if(listofStringImages.isNotEmpty)
      for(int i=0;i<listofStringImages.length;i++)
        "photo_url${i+1}":listofStringImages[i],
    if(listofFileImages.isNotEmpty)
      for(int i =0;i<listofFileImages.length;i++)
        'nphoto_url${i+1}' : await MultipartFile.fromFile(
          listofFileImages[i].path,
          filename: listofFileImages[i].path.split('/').last,
        ),*/
    });
    print(data.fields);
    print(data.files);
   /* if(imageList.length>=3)
      {
        setState(() {
          photoErrorValidation = false;
        });*/
        await _dio.post(EDIT_USER_BY_ID,data: data).then((value)async {
          print("value = ${value}");
          if(value.statusCode == 200)
          {
            setState(() {
              RemoveAppLoader(_mainContex);
              Navigator.of(context).pop();
              // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SettingsMainScreen()));

            });

          }
        });
     /* }
    else{
      setState(() {
        photoErrorValidation = true;
      });
    }*/
  }
  List<String> listofStringImages =[];
  List<File> listofFileImages =[];
  seprateImageAndString()async{
    listofStringImages=[];
    listofFileImages=[];
    for(int i =0; i<listofImages.length;i++)
      {
        print("called = ${i}");
        if(listofImages[i].runtimeType.toString() == "String")
          {
            print(i);
            listofStringImages.add(listofImages[i]);
          }
        else{
          listofFileImages.add(listofImages[i]);
        }

      }
    print(listofStringImages.length);
    print(listofFileImages.length);
  }
}
