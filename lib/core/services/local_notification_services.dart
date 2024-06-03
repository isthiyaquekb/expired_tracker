import 'package:expiry_track/core/constant/app_string.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();



  // INITIALIZATION
  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: null);

    final InitializationSettings initializationSettings = const InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
       );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) => null,);
  }

  ///SIMPLE NOTIFICATION
  static Future showSimpleNotification(String title,String body,String payload) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(AppString.notificationChannelId,AppString.notificationChannelName,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, title,body, notificationDetails,
        payload: payload);
  }

  ///REPEATED NOTIFICATION
  static Future showRepeatedNotification(String title,String body,String payload) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(AppString.notificationChannelId,AppString.notificationChannelName,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound("f1_notification"),
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0, title,body,RepeatInterval.everyMinute, notificationDetails,
        payload: payload);
  }

  ///SCHEDULED NOTIFICATION
  void showScheduleNotification(){

  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //       title: Text(title??''),
  //       content: Text(body??''),
  //       actions: [
  //         CupertinoDialogAction(
  //           isDefaultAction: true,
  //           child: Text('Ok'),
  //           onPressed: () async {
  //             Navigator.of(context, rootNavigator: true).pop();
  //             await Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => SecondScreen(payload),
  //               ),
  //             );
  //           },
  //         )
  //       ],
  //     ),
  //   );
  }
}

