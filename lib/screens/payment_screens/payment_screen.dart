import 'dart:convert';

import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/widgets/custom_button.dart';
import 'package:afropeep/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../resouces/constants.dart';
import '../../widgets/loading_button_screen.dart';

class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CardDetails _card = CardDetails();
  bool _saveCard = false;
  Map<String, dynamic> paymentIntentData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPayment();
  }
  var getispayment =false;
  getPayment()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getispayment =prefs.getBool('ispayment') ;
    print(getispayment);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child:getispayment==false || getispayment == null? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10,),
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
           /* SizedBox(height: 10,),
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
            ),*/
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
              onChanged: (number) {
                setState(() {
                  _card = _card.copyWith(number: number);
                });
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Month',
                      labelStyle: TextStyle(fontSize: 22,),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'MM',
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
                    onChanged: (number) {
                      setState(() {
                        _card = _card.copyWith(
                            expirationMonth: int.tryParse(number));
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 20,),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Year',
                      labelStyle: TextStyle(fontSize: 22,),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'YY',
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
                    onChanged: (number) {
                      setState(() {
                        _card = _card.copyWith(
                            expirationYear: int.tryParse(number));
                      });
                    },
                    keyboardType: TextInputType.number,
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
                    onChanged: (number) {
                      setState(() {
                        _card = _card.copyWith(cvc: number);
                      });
                    },
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
            SizedBox(height: 40,),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: _saveCard,
              onChanged: (value) {
                setState(() {
                  _saveCard = value;
                });
              },
              title: Text('Save card during payment'),
            ),
            CustomButton(
              height: 45,
              width:MediaQuery.of(context).size.width,
              backgroundColor: ColorResources.primaryColor,
              onPressed: makePayment,
              buttonText: "Pay Now",
              fontSize: 16.0,
              textColor: ColorResources.whiteColor,
              // width:MediaQuery.of(context).size.width,

            ),
          ],
        ):Container(child:  CustomText(text:'Payment Successful ',fontSize: 20,),),
        )
      ),
    );
  }

  Future<void> _handlePayPress() async {
    await Stripe.instance.dangerouslyUpdateCardDetails(_card);

    try {
      // 1. Gather customer billing information (ex. email)

      final billingDetails = BillingDetails(
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mocked data for tests
      final shippingDetails = ShippingDetails(
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      );
      // 2. Create payment method
      var paymentMethod = await Stripe.instance.createPaymentMethod(
          PaymentMethodParams.card(
            paymentMethodData: PaymentMethodData(
              billingDetails: billingDetails,
              shippingDetails: shippingDetails,
            ),
          ));
      print(paymentMethod.card);
      // 3. call API to create PaymentIntent
      final paymentIntentResult = await callNoWebhookPayEndpointMethodId(
        useStripeSdk: true,
        paymentMethodId: paymentMethod.id,

        currency: 'usd', // mocked data
        items: [
          'id-1',
          'id-2',
        ],
      );
      print("called");
      if (paymentIntentResult['error'] == null) {
        // Error during creating or confirming Intent
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${paymentIntentResult['error']}')));
        return;
      }

      if (paymentIntentResult['clientSecret'] != null &&
          paymentIntentResult['requiresAction'] == null) {
        // Payment succedeed

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
            Text('Success!: The payment was confirmed successfully!')));
        return;
      }

      if (paymentIntentResult['clientSecret'] != null &&
          paymentIntentResult['requiresAction'] == true) {
        // 4. if payment requires action calling handleNextAction
        final paymentIntent = await Stripe.instance
            .handleNextAction(paymentIntentResult['clientSecret']);

        if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
          // 5. Call API to confirm intent
          await confirmIntent(paymentIntent.id);
        } else {
          // Payment succedeed
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error: ${paymentIntentResult['error']}')));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
      rethrow;
    }
  }

  Future<void> confirmIntent(String paymentIntentId) async {
    final result = await callNoWebhookPayEndpointIntentId(
        paymentIntentId: paymentIntentId);
    if (result['error'] != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${result['error']}')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success!: The payment was confirmed successfully!')));
    }
  }

  Future<Map<String, dynamic>> callNoWebhookPayEndpointIntentId({
    String paymentIntentId,
  }) async {
    final url = Uri.parse('$kApiUrl/charge-card-off-session');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'paymentIntentId': paymentIntentId}),
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> callNoWebhookPayEndpointMethodId({
    bool useStripeSdk,
    String paymentMethodId,
    String currency,
    List<String> items,
  }) async {
    final url = Uri.parse('$kApiUrl/pay-without-webhooks');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'useStripeSdk': useStripeSdk,
        'paymentMethodId': paymentMethodId,
        'currency': currency,

        'items': items
      }),
    );
    return json.decode(response.body);
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData =
      await createPaymentIntent("50", 'USD'); //json.decode(response.body);
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


        print('payment intent'+paymentIntentData['id'].toString());
        print('payment intent'+paymentIntentData['client_secret'].toString());
        print('payment intent'+paymentIntentData['amount'].toString());
        print('payment intent'+paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('ispayment', true);
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
    final a = (int.parse(amount)) * 100 ;
    return a.toString();
  }
}
