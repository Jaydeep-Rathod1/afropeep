import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Terms And Conditions',
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
                SizedBox(height: 20,),CustomText(
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
