import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_app/Screens/notifications/notification_helper.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/model/pushnotification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // intilation some values
  ConstantColors constantColors = ConstantColors();
  late final FirebaseMessaging _messaging;
  late int _totalNotificationCount;
  // model
  PushNotificationModel? _notificationModel;
  // register notificaton
  void registreNotfication() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    // notifiction settings
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    //check that permssion given by user
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted all permission');

      // main message

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotificationModel notificationModel = PushNotificationModel(
          title: message.notification!.title,
          body: message.notification!.body,
          datatitle: message.data['title'],
          databody: message.data['body'],
        );

        setState(() {
          _totalNotificationCount++;
          _notificationModel = notificationModel;
        });

        if (notificationModel != null) {
          showSimpleNotification(
            Text(
              _notificationModel!.title!,
              style: TextStyle(color: constantColors.darkColor),
            ),
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: constantColors.redColor,
              ),
              width: MediaQuery.of(context).size.width * 0.1,
              child: Center(child: Icon(Icons.check)),
            ),
            subtitle: Text(
              _notificationModel!.body!,
              style: TextStyle(color: constantColors.darkColor),
            ),
            background: Colors.green.shade300,
            duration: Duration(seconds: 10),
          );
        }
      });
    } else {
      print('permission declaing');
    }
  }

  checkForInitalMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initalmessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initalmessage != null) {
      PushNotificationModel notificationModel = PushNotificationModel(
        title: initalmessage.notification!.title,
        body: initalmessage.notification!.body,
        datatitle: initalmessage.data['title'],
        databody: initalmessage.data['body'],
      );

      setState(() {
        _totalNotificationCount++;
        _notificationModel = notificationModel;
      });
    }
  }

  @override
  void initState() {
    //app in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotificationModel notificationModel = PushNotificationModel(
        title: message.notification!.title,
        body: message.notification!.body,
        datatitle: message.data['title'],
        databody: message.data['body'],
      );

      setState(() {
        _totalNotificationCount++;
        _notificationModel = notificationModel;
      });
    });
    //normal
    registreNotfication();
    // terminated
    checkForInitalMessage();
    _totalNotificationCount = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.whiteColor),
        backgroundColor: constantColors.greenColor,
        title: SizedBox(
          child: Text(
            'Notifications',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: constantColors.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            NotificationHelpers(
              totalNotificatonCount: _totalNotificationCount,
            ),
            _notificationModel != null
                ? Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        "${_notificationModel!.datatitle ?? _notificationModel!.title}",
                        style: TextStyle(
                            color: constantColors.darkColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${_notificationModel!.databody ?? _notificationModel!.body}",
                        style: TextStyle(
                          color: constantColors.darkColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      )),
    );
  }
}
