import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset : false,
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height/1.26,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Row(
                  children: [
                    CustomText(text:'Total Amount : ',fontSize: 20,),
                    CustomText(text: '\$50',color: ColorResources.primaryColor,fontSize: 20,)
                  ],
                ),

                SizedBox(height: 15,),
                Divider(),
                SizedBox(height: 15,),
                CustomText(text:'Add Card Details',fontSize: 20,fontWeight: FontWeight.bold,),
                SizedBox(height: 10,),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name on Card',
                    labelStyle: TextStyle(fontSize: 22,),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Name on card',
                    hintStyle: TextStyle(fontSize: 12),
                    // Enabled Border
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    // Focused Border
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff097969), width: 1),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    labelStyle: TextStyle(fontSize: 22,),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Card Number',
                    hintStyle: TextStyle(fontSize: 12),
                    // Enabled Border
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    // Focused Border
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff097969), width: 1),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Expiry',
                          labelStyle: TextStyle(fontSize: 22,),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'mm/yy',
                          hintStyle: TextStyle(fontSize: 12),
                          // Enabled Border
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          // Focused Border
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff097969), width: 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          labelStyle: TextStyle(fontSize: 22,),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: '000',
                          hintStyle: TextStyle(fontSize: 12),
                          // Enabled Border
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          // Focused Border
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff097969), width: 1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40,),
                Expanded(child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: this.value,
                              onChanged: (bool value) {
                                setState(() {
                                  this.value = value;
                                });
                              },
                            ),
                            SizedBox(width: 1,),
                            CustomText(text:'I Agree All Terms And Conditions')
                          ],
                        ),
                        CustomButton(
                          height: 45,
                          width:MediaQuery.of(context).size.width,
                          backgroundColor: ColorResources.primaryColor,

                          onPressed: (){
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QuestionsScreen()));
                          },
                          buttonText: "Pay Now",
                          fontSize: 16.0,
                          textColor: ColorResources.whiteColor,
                          // width:MediaQuery.of(context).size.width,

                        ),

                      ],
                    )
                ),),
                const SizedBox(
                  height: 15,
                )
              ],
            )

        ),
      )
    );

  }
}
