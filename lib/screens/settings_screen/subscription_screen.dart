import 'dart:convert';

import 'package:afropeep/models/settings_models/SubscriptionModel.dart';
import 'package:afropeep/models/user_models/user_subscription_model.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../resouces/constants.dart';
import '../../resouces/functions.dart';
import '../../resouces/payment.dart';

class SubscriptionScreen extends StatefulWidget {

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  CardDetails _card = CardDetails();
  bool _saveCard = false;
  Map<String, dynamic> paymentIntent;
  SubscritionModel selectedvalue;
  Dio _dio = Dio();
  var privacyData ;
  BuildContext _mainContex;
  List<SubscritionModel> arrSubscriptionList = [];
  Map<String, dynamic> paymentIntentData;
  bool issubscribemonth =false;
  bool issubscribeweek =false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainContex = this.context;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getUserid();
      await getSubscriptiondata();
      await sharePrefsvalue();
    });
  }
  var userid;
  var subid6;
  var subid2;
  sharePrefsvalue()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      subid6 =prefs.getBool("istaken6");
      subid2 =prefs.getBool("istaken2");
    });
    print(subid6);
    print(subid2);
  }
  getUserid()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getInt('userid');
    });
  }
  getSubscriptiondata()async{
    Apploader(_mainContex);
    await _dio.get(SUBSCRITION_URL).then((value) {
      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrSubscriptionList =varJson.map((e) =>SubscritionModel.fromJson(e)).toList();
          selectedvalue = arrSubscriptionList[0];
          RemoveAppLoader(_mainContex);
        });

      }
    }).then((value) async{
      await getUserSubscriptionDetails();
    });
  }
  List<UserSubscritionModel> arrAllUserSubscription = [];
  List<UserSubscritionModel> arrUserSubscription = [];
  getUserSubscriptionDetails()async{
    Apploader(_mainContex);

    // await _dio.post(SUBSCRIPTION_URL,data:{'userid':userid.toString()}).then((value) {
    await _dio.post(SUBSCRIPTION_URL,data:{'userid':userid.toString()}).then((value) {
      var varJson = value.data as List;
      print(varJson);
      if(value.statusCode == 200)
      {
        setState(() {
          arrAllUserSubscription =varJson.map((e) =>UserSubscritionModel.fromJson(e)).toList();
          arrAllUserSubscription.forEach((element) { 
            if(element.subscriptionId.toString() == "1")
              {
                issubscribemonth =true;
              }
            if(element.subscriptionId.toString() == "2")
              {
                issubscribeweek = true;
              }
          });
          RemoveAppLoader(_mainContex);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:CustomText(
          text: 'Subscription',
          fontSize: 18,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: Padding(
            padding:EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                   alignment: Alignment.center,
                   child: CustomText(
                       text:'choose subscription'.toUpperCase(),
                       fontSize: 22,
                   ),
                 ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. ',
                    style: TextStyle(fontSize: 12,),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(child: Container(
                      height: 1,
                      color: Color(0xff707070),),),
                    OutlinedButton(
                      onPressed: (){},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffF5F5F5),
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(29.0)),
                        side: BorderSide(width: 1.0, color: Color(0xff707070)),
                      ),
                      child: Container(
                        width: 106,
                        height: 38,
                        alignment: Alignment.center,
                        child: CustomText(text: 'Plans'.toUpperCase(),color: ColorResources.blackColor,fontSize: 16,),
                      ),
                    ),
                    Expanded(child: Container(
                      height: 1,
                        color: Color(0xff707070)),)
                  ],
                ),
                SizedBox(height: 20.0,),

                Expanded(
                   child:  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                       padding: EdgeInsets.zero,
                       shrinkWrap: true,
                       itemCount: arrSubscriptionList.length,
                       itemBuilder: (BuildContext context, int index) {

                         return  GestureDetector(
                             onTap: (){
                               setState(() {
                                 // isSelected = !isSelected;
                                 selectedvalue = arrSubscriptionList[index];
                               });
                             },
                             child:Container(
                               width: 700,
                               margin: EdgeInsets.only(top: 10,bottom: 10),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color:arrAllUserSubscription.isEmpty? selectedvalue.subId.toString() == arrSubscriptionList[index].subId.toString()? Color(0xffD8FFF9): Color(0xffF5F5F5):Color(0xffF5F5F5),
                                 border: Border.all(
                                   color:arrAllUserSubscription.isEmpty? selectedvalue.subId.toString() == arrSubscriptionList[index].subId.toString()? Color(0xff097969): Color(0xff707070):Color(0xff707070),
                                 ),
                               ),
                               padding: EdgeInsets.all(15.0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   CustomText(text: "${arrSubscriptionList[index].price}/${arrSubscriptionList[index].duration}",fontSize: 20,),
                                   SizedBox(height: 5,),
                                   CustomText(text: arrSubscriptionList[index].discription,fontSize: 12,),
                                 ],
                               ),
                             )
                         );

                       }),
                 ),

               /* GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedvalue = 'weekly';
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selectedvalue == 'weekly'? Color(0xffD8FFF9): Color(0xffF5F5F5),
                      border: Border.all(
                        color:selectedvalue == 'weekly'? Color(0xff097969): Color(0xff707070),
                      ),
                    ),
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(text: "\$20/ Weekly",fontSize: 20,),
                        SizedBox(height: 5,),
                        CustomText(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.",fontSize: 12,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                 GestureDetector(
                   onTap: (){
                     setState(() {
                       selectedvalue = 'month';
                     });
                   },
                   child:  Container(
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: selectedvalue == 'month'? Color(0xffD8FFF9): Color(0xffF5F5F5),
                       border: Border.all(
                         color: selectedvalue == 'month'? Color(0xff097969): Color(0xff707070),
                       ),
                     ),
                     padding: EdgeInsets.all(15.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         CustomText(text: "\$60/1 Month",fontSize: 20,),
                         SizedBox(height: 5,),
                         CustomText(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.",fontSize: 12,),
                       ],
                     ),
                   ),
                 ),
                SizedBox(height: 15.0,),
                GestureDetector(
                  onTap: (){

                    setState(() {
                      selectedvalue = 'year';
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selectedvalue == 'year'? Color(0xffD8FFF9): Color(0xffF5F5F5),
                      border: Border.all(
                        color: selectedvalue == 'year'? Color(0xff097969): Color(0xff707070),
                      ),
                    ),
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(text: "\$120/1 Year",fontSize: 20,),
                        SizedBox(height: 5,),
                        CustomText(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.",fontSize: 12,),
                      ],
                    ),
                  ),
                ),*/
                SizedBox(height: 20.0,),
                CustomButton(
                  height: 45,
                  fontSize: 16,
                  width: MediaQuery.of(context).size.width,
                  backgroundColor: ColorResources.blackColor,
                  onPressed:arrAllUserSubscription.isEmpty?()async{
                    // await makePayment();
                    print(selectedvalue);
                    var price = selectedvalue.price.replaceAll("\$", "");
                    print(price);
                    makePayment(price);
                  }:null,
                  buttonText: 'Buy Now',
                ),
                // TextButton(onPressed: (){}, child: CustomText(text: 'Skip',fontSize: 12,color: ColorResources.blackColor,))
              ],
            ),
        ),

    );
  }

  Future<void> makePayment(String price) async {
    try {
      paymentIntentData =
      await createPaymentIntent(price, 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'ANNIE')).then((value){
      });
      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData['client_secret'],
            confirmPayment: true,
          )).then((newValue)async{
          // await _dio.post(path)
        print('payment intent'+paymentIntentData['id'].toString());
        print('payment intent'+paymentIntentData['client_secret'].toString());
        print('payment intent'+paymentIntentData['amount'].toString());
        print('payment intent'+paymentIntentData.toString());
        print("dacce = ${paymentIntentData}");
        //orderPlaceApi(paymentIntentData!['id'].toString());
        await insertSubscriptionDetails(paymentIntentData['id'].toString());

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));
        paymentIntentData = null;
      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });


    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }
  insertSubscriptionDetails(String paymentid)async{
    print(userid);
    var user_id = userid.toString();
    var subscriptionid = selectedvalue.subId.toString();
    var startdate = DateTime.now().toString();
    var expiredate = "";
    if(subscriptionid=="1")
       expiredate = DateTime.now().add(new Duration(days: 30)).toString();
    else 
       expiredate = DateTime.now().add(new Duration(days: 7)).toString();

    var payment_id = paymentid;

    var transnum = "transnum";
    Map params = Map();
    params['userid'] =user_id ;
    params['subid'] = subscriptionid;
    params['paydate'] = startdate;
    params['expiredate'] = expiredate;
    params['payid'] = payment_id;
    params['transnum'] = transnum;
    print("subscriptionid = ${params}");
    await _dio.post(SUBSCRIPTION_INSERT,data: params).then((value)async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("istaken6", true);

      await sharePrefsvalue();

      if(value.statusCode == 200)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment Successful")));
        }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment Failed")));
      }
    });

  }

  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((RegExpMatch match) =>   print(match.group(0)));
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51Lcpm0Eztgk3t6Alzr0c1YA48MWEFI5B0DKOjvVcSX9ynU8ewa1GOL97v2rBXgs1hBoppPotvnlWZvHnQqbEz7Bc003Zeo6Kbz',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }
  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100  ;
    return "${a}";
  }




}
