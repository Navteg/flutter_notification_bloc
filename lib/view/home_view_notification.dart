import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/bloc/notification_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../models/push_notification.dart';
import '../models/notification_badge.dart';
import '../widget/notification_widget.dart';

class HomePageNotification extends StatefulWidget {
  @override
  _HomePageNotificationState createState() => _HomePageNotificationState();
}

/// *[To handle background messages]
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class _HomePageNotificationState extends State {
  final NotificationBloc bloc = NotificationBloc();
  late int _totalNotifications;
  PushNotification? _notificationInfo;
  late final FirebaseMessaging _messaging;

  @override
  void initState() {
    _totalNotifications = 0;

    print('1. initState');
    registerNotification();

    print('2. initState');
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp');

      PushNotification notification = PushNotification(
        title: message.data['title'],
        body: message.data['body'],
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
        url: message.data['url'],
      );

      // bloc.add(CheckIntitialMessage());

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    });

    print('3. initState');
    checkForInitialMessage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notify'),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'App for capturing Firebase Push Notifications',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16.0),
            NotificationBadge(totalNotifications: _totalNotifications),
            const SizedBox(height: 16.0),
            _notificationInfo != null ? const NotificationWidget() : Container(),
          ],
        ),
      ),
    );
  }

  void registerNotification() async {
    print('inside registerNotification');
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    _messaging.getToken().then((token) {
      print('token: $token');
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        print("Listenintg for onMessage");

        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
          url: message.data['image'],
        );

        bloc.add(
          NotificationReceivedEvent(notification: notification),
        );

        // context.read<NotificationBloc>().add(
        //   CheckIntitialMessage(
        //     title: message.data['title'],
        //     body: message.data['body'],
        //     dataTitle: message.data['title'],
        //     dataBody: message.data['body'],
        //     url: message.data['image'],
        //   ),
        // );

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });

        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(bloc.state.props[0].toString()),
            leading: NotificationBadge(totalNotifications: _totalNotifications),
            subtitle: Text(bloc.state.props[1].toString()),
            background: Colors.cyan.shade700,
            duration: const Duration(seconds: 2),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  /// *[To handle backgroungd messages]
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }
}
