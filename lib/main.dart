import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:afropeep/provider/card_provider.dart';
import 'package:afropeep/resouces/MyHttpOverrides.dart';
import 'package:afropeep/resouces/color_resources.dart';
import 'package:afropeep/resouces/default_firebase_config.dart';
import 'package:afropeep/screens/match_screens/its_match_screen.dart';
import 'package:afropeep/screens/payment_screens/payment_screen.dart';
import 'package:afropeep/screens/payment_screens/paymentnew.dart';
import 'package:afropeep/screens/settings_screen/subscription_screen.dart';
import 'package:afropeep/screens/splash_screen.dart';
import 'package:connectycube_flutter_call_kit/connectycube_flutter_call_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
// import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

/*Future<void> showNotification(RemoteMessage message) async {
  await Firebase.initializeApp();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('simple', 'coin',
      channelDescription: 'coin collected notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const DarwinNotificationDetails iosNotificationDetails =
  DarwinNotificationDetails();
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
    await flutterLocalNotificationsPlugin.show(11, message.data["title"],
        message.data["body"], platformChannelSpecifics,
        payload: json.encode(message.data)
    );
  }
}

Future<void> showBackgroundNotification(RemoteMessage message) async {
  await Firebase.initializeApp();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('simple', 'coin',
      channelDescription: 'coin collected notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const DarwinNotificationDetails iosNotificationDetails =
  DarwinNotificationDetails();
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);
  String sessionId = DateTime.now().millisecondsSinceEpoch.toString();
  Set<int> specialNumbers = Set();
  specialNumbers.add(12);
  if(message.data["body"]=="audio"){
    CallEvent callEvent = CallEvent(
        sessionId: sessionId,
        callType: 0,
        callerId: 12,
        callerName: message.data["title"],
        opponentsIds: specialNumbers,
        userInfo: {'customParameter1': 'value1'});
    ConnectycubeFlutterCallKit.showCallNotification(callEvent);
  }else if(message.data["body"]=="video"){
    CallEvent callEvent = CallEvent(
        sessionId: sessionId,
        callType: 1,
        callerId: 12,
        callerName: message.data["title"],
        opponentsIds: specialNumbers,
        userInfo: {'customParameter1': 'value1'});
    ConnectycubeFlutterCallKit.showCallNotification(callEvent);
  }else{
    if (Platform.isAndroid) {
      await Firebase.initializeApp();
      await flutterLocalNotificationsPlugin.show(11, message.data["title"],
          message.data["body"], platformChannelSpecifics,
          payload: json.encode(message.data)
      );
    }
  }
}*/


Future<void> showNotification(RemoteMessage message) async {
  RemoteNotification notification = message.notification;
  await Firebase.initializeApp();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('simple', 'coin',
      channelDescription: 'coin collected notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const DarwinNotificationDetails iosNotificationDetails =
  DarwinNotificationDetails();
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
    await flutterLocalNotificationsPlugin.show(11, notification.title,
        notification.body, platformChannelSpecifics,
        payload: json.encode(message.data)
    );
  }
}

Future<void> showBackgroundNotification(RemoteMessage message) async {
  RemoteNotification notification = message.notification;
  await Firebase.initializeApp();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('simple', 'coin',
      channelDescription: 'coin collected notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const DarwinNotificationDetails iosNotificationDetails =
  DarwinNotificationDetails();
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);
  String sessionId = DateTime.now().millisecondsSinceEpoch.toString();
  Set<int> specialNumbers = Set();
  specialNumbers.add(12);
  if(message.data["body"]=="audio"){
    CallEvent callEvent = CallEvent(
        sessionId: sessionId,
        callType: 0,
        callerId: 12,
        callerName: message.data["title"],
        opponentsIds: specialNumbers,
        userInfo: {'customParameter1': 'value1'});
    ConnectycubeFlutterCallKit.showCallNotification(callEvent);
  }else if(message.data["body"]=="video"){
    CallEvent callEvent = CallEvent(
        sessionId: sessionId,
        callType: 1,
        callerId: 12,
        callerName: message.data["title"],
        opponentsIds: specialNumbers,
        userInfo: {'customParameter1': 'value1'});
    ConnectycubeFlutterCallKit.showCallNotification(callEvent);
  }else{
    if (Platform.isAndroid) {
      await Firebase.initializeApp();
      await flutterLocalNotificationsPlugin.show(11, notification.title,
          notification.body, platformChannelSpecifics,
          payload: json.encode(message.data)
      );
    }
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();

final StreamController<String> selectNotificationStream =
StreamController<String>.broadcast();

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

void main()async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51Lcpm0Eztgk3t6AlqZmdV28fiGt9JT45ELncsCKIvzRtoa9lsjmZ3OR3E1qMYE9pHoXW2HElw9VRZaePVyeFReGX00dqPXg6pe";
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  //Stripe.publishableKey = "pk_test_51Lcpm0Eztgk3t6AlqZmdV28fiGt9JT45ELncsCKIvzRtoa9lsjmZ3OR3E1qMYE9pHoXW2HElw9VRZaePVyeFReGX00dqPXg6pe";
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  WidgetsFlutterBinding.ensureInitialized();
  final AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings =
  InitializationSettings(
      android: initializationSettingsAndroid,
      );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("fcmtoken = ${fcmToken}");
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("message called");
    showNotification(message);
  });
  FirebaseMessaging.onBackgroundMessage(showBackgroundNotification);
//Firebase messaging
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  /*await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;*/
  // Stripe.publishableKey = "pk_test_51Lcpm0Eztgk3t6AlqZmdV28fiGt9JT45ELncsCKIvzRtoa9lsjmZ3OR3E1qMYE9pHoXW2HElw9VRZaePVyeFReGX00dqPXg6pe";
  // Stripe.merchantIdentifier = 'MerchantIdentifier';
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFFFFFFF),
            primarySwatch: ColorResources.primaryColor,
            fontFamily: 'Poppins',
            textTheme:GoogleFonts.poppinsTextTheme()
          // textTheme: const TextTheme(
          //   headline1: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          //   headline2: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
          //   bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
          // )
        ),
        home:  SplashScreen(),
        // home: PaymentNew(),
      ),
    );
  }
}

