import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:afropeep/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _reTypeNewPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Change Password',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(20.0),
          child:  Column(
            children: [
              CustomTextField(controller: _currentPassword,fontSize: 14,hintText: 'Current Password',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              SizedBox(height: 20,),
              CustomTextField(controller: _newPassword,fontSize: 14,hintText: 'New Password',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              SizedBox(height: 20,),
              CustomTextField(controller: _reTypeNewPassword,fontSize: 14,hintText: 'Re-type New Password ',borderRadius: 30,enabledBorder: true,focusedBorder: true,),
              SizedBox(height: 48,),
              CustomButton(
                height: 45,
                fontSize: 16,
                width: MediaQuery.of(context).size.width,
                backgroundColor: ColorResources.blackColor,
                onPressed: (){},
                buttonText: 'Update Password',
              ),
              SizedBox(height: 11.0,),
              CustomButton(
                height: 45,
                fontSize: 16,
                width: MediaQuery.of(context).size.width,
                backgroundColor: Color(0xffF4F4F6),
                onPressed: (){},
                buttonText: 'Cancel',
                textColor: ColorResources.blackColor,
              ),
              SizedBox(height: 0.0,),
              TextButton(onPressed: (){}, child: CustomText(text: 'Forgot your Password',fontSize: 12,color: Color(0xff009EFF),))
            ],
          ),
        )
      ),
    );
  }
}
