import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CloudMessaging {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  void setUp(BuildContext context) {
    configure(context);
    // setNotificationPermissions();
  }

  Future deleteToken() async {
    await _firebaseMessaging.setAutoInitEnabled(false);
    await _firebaseMessaging.deleteToken();
  }

  // String _homeScreenText = "Waiting for token...";

  void configure(BuildContext context) {
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");

    //     // var title = message['notification']['title'];
    //     // var body = message['notification']['body'];

    //     // await showNotification(message, title, body);

    //     NavRouter.navigator.pushNamed(NavRouter.notificationsPage);

    //     // showMessage(context: context, message: message);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     NavRouter.navigator.pushNamed(NavRouter.notificationsPage);
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     NavRouter.navigator.pushNamed(NavRouter.notificationsPage);
    //     print("onResume: $message");
    //   },
    // );

    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
    // _firebaseMessaging.getToken().then((String token) {
    //   assert(token != null);

    //   _homeScreenText = "Push Messaging token: $token";

    //   print(_homeScreenText);
    // });
  }

  // showNotification(
  //     Map<String, dynamic> message, String title, String body) async {
  //   var android = const AndroidNotificationDetails(
  //       'channel_id', 'CHANNLE NAME', 'channelDescription');
  //   var ios = const IOSNotificationDetails();
  //   var platform = NotificationDetails(android, ios);
  //   await flutterLocalNotificationsPlugin.show(26, title, body, platform);
  // }

  // showMessage({BuildContext context, Map<String, dynamic> message}) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           content: Text(message['notification']['body']),
  //           actions: [
  //             FlatButton(
  //                 color: kColorAccent,
  //                 onPressed: () => Navigator.pop(context),
  //                 child: Text(
  //                   'Ok',
  //                   style: TextStyle(color: Colors.white),
  //                 ))
  //           ],
  //         );
  //       });
  // }

  // void setNotificationPermissions() {
  //   _firebaseMessaging.requestNotificationPermissions(
  //       const IosNotificationSettings(
  //           sound: true, badge: true, alert: true, provisional: true));
  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  // }

  Future<String> getToken() async {
    _firebaseMessaging.setAutoInitEnabled(true);
    return await _firebaseMessaging.getToken();
  }
}
