import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hero_bear_driver/data/closable.dart';

class FirebaseMessagingClient implements Closable {
  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  StreamSubscription<RemoteMessage>? _subNotif;

  @override
  void close() {
    _subNotif?.cancel();
  }

  static Future<String?> getDeviceToken() =>
      FirebaseMessaging.instance.getToken();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  void listenNotifications() {
    _subNotif = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final android = message.notification?.android;
      if (notification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              _channel.description,
              // TODO add a proper drawable resource to android, for now using
              icon: 'launch_background',
            ),
          ),
        );
        /* print('data from the notifications');
        print(notification.body.toString());
        print(notification.title.toString());
        print(notification.toString());*/
      }
    });
  }
}

// FirebaseMessaging.instance
//     .getInitialMessage()
//     .then((RemoteMessage message) {
//       // todo: handle here
// });

// FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//   print('A new onMessageOpenedApp event was published!');
//   Navigator.pushNamed(context, '/message',
//       arguments: MessageArguments(message, true));
// });
