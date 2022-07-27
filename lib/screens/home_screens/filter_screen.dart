import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String value;
  static const min = 18.0;
  static const max = 26.0;
  double low = 18.0;
  double high = 18.0;
  double km = 10;
  String dropdownvalue = 'Choose Natonality';
  // List of items in our dropdown menu
  var items = [
    'Choose Natonality',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Filters',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        actions: [
          Padding(
            padding:EdgeInsets.only(top:20,right: 20),
            child: Text('Reset',style: TextStyle(fontSize: 14, decoration: TextDecoration.underline,),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(text: 'Who you want to date',fontSize: 12,),
              SizedBox(height: 17,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1,color: Color(0xffABABAB)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            value = 'Men';
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left:10,right: 10,top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'Men',fontSize: 14,),
                              value == 'Men'? Icon(Icons.check_circle ,color: Colors.black,) :Icon(Icons.circle_outlined ,color: Colors.black,),
                            ],
                          ),
                        )
                        // child: ListTile(
                        //   title: Text('Men'),
                        //   trailing:
                        //   value == 'Men'? Icon(Icons.check_circle ,color: Colors.black,) :Icon(Icons.circle_outlined ,color: Colors.black,),
                        // ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:10,right: 10),
                        child:Divider()
                      ),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              value = 'Women';
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left:10,right: 10,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: 'Women',fontSize: 14,),
                                value == 'Women'? Icon(Icons.check_circle ,color: Colors.black,) :Icon(Icons.circle_outlined ,color: Colors.black,),
                              ],
                            ),
                          )
                        // child: ListTile(
                        //   title: Text('Men'),
                        //   trailing:
                        //   value == 'Men'? Icon(Icons.check_circle ,color: Colors.black,) :Icon(Icons.circle_outlined ,color: Colors.black,),
                        // ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left:10,right: 10),
                          child:Divider()
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            value = 'Both';
                          });
                        },
                            child: Padding(
                              padding: EdgeInsets.only(left:10,right: 10,bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(text: 'Both',fontSize: 14,),
                                  value == 'Both'? Icon(Icons.check_circle ,color: Colors.black,) :Icon(Icons.circle_outlined ,color: Colors.black,),
                                ],
                              ),
                            )
                      ),
                    ],
                  ),
                )
              ),
              SizedBox(height: 20,),
              CustomText(text: 'Age',fontSize: 12,),
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
                          child:CustomText(text: 'Age Between 18 to 26  ',fontSize: 12,),),
                        RangeSlider(
                          min: min,
                          max: max,
                          activeColor: ColorResources.primaryColor,
                          inactiveColor: Color(0xffABABAB),
                          values: RangeValues(low, high),
                          onChanged: (values) => setState((){
                            low = values.start;
                            high = values.end;
                          }),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 20,),
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
              SizedBox(height: 20,),
               Container(
                 height: 40,
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
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),

        bottomNavigationBar:Container(
          height:60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75)
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child:   Container(
              width: 66,
              color: Colors.white,
              padding: EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
              child:CustomButton(
                height: 45,
                fontSize: 16,
                width: MediaQuery.of(context).size.width,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){},
                buttonText: 'Apply',
              ),
            ),
          ),
        )
    );
  }
}
