part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class CheckIntitialMessage extends NotificationEvent {
  CheckIntitialMessage();
}

class NotificationReceivedEvent extends NotificationEvent {
  final PushNotification notification;
  NotificationReceivedEvent({required this.notification});
}

// class registerForPushNotifications extends NotificationEvent {
//   await Firebase.initializeApp();

//   // 2. Instantiate Firebase Messaging
//   _messaging = FirebaseMessaging.instance;

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   // 3. On iOS, this helps to take the user permissions
//   NotificationSettings settings = await _messaging.requestPermission(
//     alert: true,
//     badge: true,
//     provisional: false,
//     sound: true,
//   );

//   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//     print('User granted permission');
//     // For handling the received notifications
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // Parse the message received
//       PushNotification notification = PushNotification(
//         title: message.notification?.title,
//         body: message.notification?.body,
//         dataTitle: message.data['title'],
//         dataBody: message.data['body'],
//         url: message.data['image'],
//       );

//       setState(() {
//         _notificationInfo = notification;
//         _totalNotifications++;
//       });

//       if (_notificationInfo != null) {
//         // For displaying the notification as an overlay
//         showSimpleNotification(
//           Text(_notificationInfo!.title!),
//           leading: NotificationBadge(totalNotifications: _totalNotifications),
//           subtitle: Text(_notificationInfo!.body!),
//           background: Colors.cyan.shade700,
//           duration: Duration(seconds: 2),
//         );
//       }
//     });
//   } else {
//     print('User declined or has not accepted permission');
//   }
// }