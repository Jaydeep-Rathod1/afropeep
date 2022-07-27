import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {


  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'About',
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
            padding:EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 30.0,),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.png",
                    color: ColorResources.blackColor,
                    width: MediaQuery.of(context).size.width/2,
                    height: 53,
                  ),
                ),
                SizedBox(height: 30.0,),
                CustomText(
                  text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam  nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam  nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
                  fontSize: 12,
                  height:1.5,
                ),

                SizedBox(height: 20,),
                CustomText(
                  text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam  nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam  nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.',
                  fontSize: 12,
                  height:1.5,
                ),
                SizedBox(height: 20,),
                CustomText(
                  text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam  nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
                  fontSize: 12,
                  height:1.5,
                ),
                SizedBox(height: 20,),
                CustomText(
                  text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam  nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
                  fontSize: 12,
                  height:1.5,
                ),
                SizedBox(height: 20,),

              ],
            ),
        ),
      ),
    );
  }
}
