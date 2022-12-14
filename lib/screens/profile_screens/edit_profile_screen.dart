import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  TextEditingController _mobileNumber = TextEditingController();
  TextEditingController _mailid = TextEditingController();
  TextEditingController _height = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _region = TextEditingController();
  TextEditingController _lookingFor = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _college = TextEditingController();
  TextEditingController _school = TextEditingController();
  String dropdownvalue = 'Male';
  // List of items in our dropdown menu
  var items = [
    'Male',
    'Female',
    'Both',
  ];
  double km = 10;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _yourName.text = 'Mark Ruffalo';
      _mobileNumber.text = '+1 996 745 7890 ';
      _mailid.text = 'markruffalo@gmail.com';
      _location.text = "155 Queen St, Ottawa, ON K1P 6L1, Canada";
      _region.text = "Canada";
      _profession.text = "Canada";
      _college.text = "University Of British Columbia";
      _school.text = "Des Bâtisseurs";
    });
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
                            border: Border.all(color: Color(0xff757575))
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
                            border: Border.all(color: Color(0xff757575))
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
                            border: Border.all(color: Color(0xff757575))
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
                            border: Border.all(color: Color(0xff757575))
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
                            border: Border.all(color: Color(0xff757575))
                          ),
                          child:Icon(Icons.add,size:30),
                        ),),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30,),
              CustomText(text: 'Your Name',),
              SizedBox(height: 15,),
              CustomTextField(controller: _yourName,fontSize: 14,hintText: 'Your Name',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
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
              CustomTextField(controller: _dob,fontSize: 14,hintText: 'MM/DD/YYYY',borderRadius: 30,enabledBorder: true,focusedBorder: true,iconName: CupertinoIcons.calendar,iconColor: ColorResources.blackColor,onPressed:(){}),
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
                    value: dropdownvalue,
                    icon: const Icon(Icons.arrow_drop_down_sharp,size: 34,),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,overflow: TextOverflow.ellipsis,),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownvalue = newValue;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 30,),
              CustomText(text: 'Interests',),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff757575)),
                  borderRadius: BorderRadius.circular(10)
                ),
                child:  Wrap(

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
              ),
              SizedBox(height: 30,),
              CustomText(text: 'Video or Audio',),
              SizedBox(height: 15,),
              Row(
                children: [
                   Container(
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
                  
                  SizedBox(width: 15.0,),
                   Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset('assets/images/image_camera.png',fit: BoxFit.cover,height: 138,width: MediaQuery.of(context).size.width/3.2,),
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(onPressed: (){},icon: Icon(Icons.close),iconSize: 16,))
                        ],


                  ),
                  SizedBox(width: 15.0,),

                ],
              ),
              SizedBox(height: 30,),
              CustomText(text: 'Your Location',),
              SizedBox(height: 15,),
              CustomTextField(controller: _location,fontSize: 14,hintText: 'Choose Location',borderRadius: 30,enabledBorder: true,focusedBorder: true,iconName: Icons.location_on_outlined,iconColor: ColorResources.blackColor,onPressed:(){}),
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
                    value: dropdownvalue,
                    icon: const Icon(Icons.arrow_drop_down_sharp,size: 34,),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,overflow: TextOverflow.ellipsis,),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownvalue = newValue;
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
                    onPressed: (){},
                    backgroundColor: ColorResources.blackColor,
                    fontSize: 16,
                  ))
                ],
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
